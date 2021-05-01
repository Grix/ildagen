/* Copyright 2011-2017 Jacob Potter
 * Copyright 2009 Andrew Kibler
 *
 * Redistribution and use in source and binary forms, with or without modification, are
 * permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this list of
 *    conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice, this list of
 *    conditions and the following disclaimer in the documentation and/or other materials
 *    provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
 * TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#define WINVER 0x0501

#include <stdio.h>
#include <math.h>
#include <time.h>
#include <string.h>

#include "dac.h"

#include <thread>

#define DEBUG_THRESHOLD 800

using namespace std::chrono_literals;

extern dac_t * dac_list;

void LoopUpdate(dac_t *d);

/* Connect */
int dac_open_connection(dac_t *d) {
    if (d->worker_thread.joinable()) {
        dac_close_connection(d);
    }

    char host[40];
    strncpy(host, inet_ntoa(d->addr), sizeof(host) - 1);
    host[sizeof(host) - 1] = 0;

    // Initialize buffer
    d->buffer_read = 0;
    d->buffer_fullness = 0;
    memset(d->buffer, sizeof(d->buffer), 0);

    // Connect to the DAC
    if (dac_connect(&d->conn, host, "7765", d->dac_id, d->identity) < 0) {
        trace(d->dac_id, "!! DAC connection failed.\n");
        return -1;
    }

    // Fire off the worker thread
    d->state = ST_READY;

    trace(d->dac_id, "init: starting worker threads...");

    d->worker_thread = std::thread(LoopUpdate, d);

    trace(d->dac_id, "Ready.\n");
    return 0;
}

void dac_close_connection(dac_t *d) {
    {
        std::unique_lock<std::mutex> lock(d->worker_mutex);
        d->state = ST_SHUTDOWN;
        d->worker_cond.notify_all();
    }

    if (d->worker_thread.joinable()) {
        d->worker_thread.join();
    }

    d->conn.disconnect();
    d->state = ST_DISCONNECTED;
}

/* Look up a DAC by index or unique-ID
 */
dac_t * dac_get(int num) {
    dac_t *d = dac_list;
    if (num >= 0) {
        while (num--) {
            if (!d->next) {
                /* If they pass one past the last DAC,
                 * just return the last one. Ugh, buggy
                 * software. */
                if (!num) return d;
                else return nullptr;
            }
            d = d->next;
        }
    } else {
        while (d) {
            if (num == d->dac_id) break;
            d = d->next;
        }
    }

    return d;
}

void dac_get_name(dac_t *d, char *buf, int max) {
    snprintf(buf, max, "Ether Dream %02x%02x%02x",
            d->identity.mac_address[3], d->identity.mac_address[4], d->identity.mac_address[5]);
}

/* Buffer access
 */
struct buffer_item *buf_get_write(dac_t *d) {
    std::unique_lock<std::mutex> lock(d->worker_mutex);
    int write = (d->buffer_read + d->buffer_fullness) % BUFFER_NFRAMES;
    return &d->buffer[write];
}

void buf_advance_write(dac_t *d) {
    std::unique_lock<std::mutex> lock(d->worker_mutex);
    d->buffer_fullness++;
    d->state = ST_RUNNING;
    d->worker_cond.notify_all();
}

int dac_get_status(dac_t *d) {
    std::unique_lock<std::mutex> lock(d->worker_mutex);

    if (d->buffer_fullness == BUFFER_NFRAMES) {
        return GET_STATUS_BUSY;
    } else {
        return GET_STATUS_READY;
    }
}

/* Write a frame.
 */

bool do_write_frame(dac_t *d, const void * data, int bytes, int pps,
        int reps, int (*convert)(struct buffer_item *, const void *, int, int)) {

    int points = convert(nullptr, nullptr, bytes, 1);

    int pointrep = 16000 / pps;
    if (pointrep < 1) pointrep = 1;
    pps *= pointrep;

    if (reps == ((uint16_t) -1))
        reps = -1;
    // trace(d, "F: %d\n", pps);

    /* If not ready for a new frame, bail */
    if (dac_get_status(d) != GET_STATUS_READY) {
        trace(d->dac_id, "M: NOT READY: %d points, %d reps\n", points, reps);
        return 0;
    }

    /* Ignore 0-repeat frames */
    if (!reps)
        return 1;

    int internal_reps = 250 / points;
    char * bigdata = nullptr;
    if (internal_reps) {
        bigdata = (char *)malloc(bytes * internal_reps);
        int i;
        for (i = 0; i < internal_reps; i++) {
            memcpy(bigdata + i*bytes, data, bytes);
        }
        bytes *= internal_reps;
        data = bigdata;
    }

    /*
       trace(d, "M: Writing: %d/%d points, %d reps, %d pps\n",
       points, convert(nullptr, nullptr, bytes, 1), reps, pps);
     */

    struct buffer_item *next = buf_get_write(d);
    convert(next, data, bytes, pointrep);
    next->pps = pps;
    next->repeatcount = reps;

    buf_advance_write(d);

    if (bigdata) free(bigdata);

    return 1;
}

#include <locale.h>

// This is the buffer filling thread for WriteFrame() and WriteFrameNR()
void LoopUpdate(dac_t *d) {
    int res;

#ifdef MSVC
    res = SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);
    trace(d->dac_id, "SetThreadPriority ret %d\n", res);
#endif

    std::unique_lock<std::mutex> lock(d->worker_mutex);

    /* the conn object must not go away for the life of this thread */
    dac_conn_t & conn = d->conn;

    while (1) {
        /* Wait for us to have data */
        if (d->state == ST_READY) {
            while (d->state == ST_READY) {
                trace(d->dac_id, "L: Waiting...\n");
                d->worker_cond.wait(lock);
            }
            trace(d->dac_id, "L: Restarting stream.\n");
        }

        if (d->state != ST_RUNNING) {
            trace(d->dac_id, "L: Shutting down.\n");
            return;
        }

        lock.unlock();

        struct buffer_item *b = &d->buffer[d->buffer_read];
        int cap;
        int iters = 0;

        while (1) {
            /* Estimate how much data has been consumed since the last
             * time we got an ACK. */
            std::chrono::duration<double> since_last_ack = std::chrono::steady_clock::now() - conn.last_ack_time();

            int iu = int(since_last_ack.count() * b->pps);
            if (conn.last_resp().dac_status.playback_state != 2) iu = 0;

            int expected_fullness = conn.last_resp().dac_status.buffer_fullness \
                                    - iu + conn.unacked_points();

            /* Now, see how much data we should write. */
            cap = 1600 - expected_fullness;

            if (conn.last_resp().dac_status.buffer_fullness < DEBUG_THRESHOLD
                    || expected_fullness < DEBUG_THRESHOLD
                    || iters > 20)
                trace(d->dac_id, "L: b %d + %d - %d = %d, w %d om %d st %d\n",
                        conn.last_resp().dac_status.buffer_fullness,
                        conn.unacked_points(),
                        iu, expected_fullness, cap,
                        conn.pending_meta_acks(),
                        conn.last_resp().dac_status.playback_state);

            if (cap > DAC_MIN_SEND) break;
            if (iters > 1 && cap >= 0) break;

            if (conn.start_if_ready(b->pps) < 0) {
                lock.lock();
                d->state = ST_BROKEN;
                return;
            }

            /* Wait a little. */
            int diff = DAC_MIN_SEND - cap;
            auto sleeptime = 1ms + std::chrono::milliseconds(1000 * diff / b->pps);
            conn.get_acks_once(1);
            std::this_thread::sleep_for(sleeptime);

            iters++;
        }

        /* How many points can we send? */
        int b_left = b->points - b->idx;

        if (cap > b_left)
            cap = b_left;
        if (cap > 80)
            cap = 80;
        if (cap <= 0)
            cap = 1;

        int res = conn.send_data(b->data + b->idx, cap, b->pps);

        if (res < 0) {
            /* Welp, something's wrong. There's not much we
             * can do at an API level other than start throwing
             * "error" returns up to the application... */

            //lock.lock();
            //d->state = ST_BROKEN;

            //fix?
            trace(d->dac_id, "Lost connection Trying reconnect.\n");
            d->conn.disconnect();

            char host[40];
            strncpy(host, inet_ntoa(d->addr), sizeof(host) - 1);
            host[sizeof(host) - 1] = 0;

            // Initialize buffer
            d->buffer_read = 0;
            d->buffer_fullness = 0;
            memset(d->buffer, sizeof(d->buffer), 0);

            // Connect to the DAC
            if (dac_connect(&d->conn, host, "7765", d->dac_id, d->identity) < 0) {
                trace(d->dac_id, "!! DAC connection failed.\n");
                lock.lock();
                d->state = ST_BROKEN;
                return;
            }

            // Fire off the worker thread
            d->state = ST_READY;

            trace(d->dac_id, "init: starting worker threads...");

            d->worker_thread = std::thread(LoopUpdate, d);

            trace(d->dac_id, "Ready.\n");

            return;
        }

        /* What next? */
        lock.lock();
        b->idx += res;

        if (b->idx < b->points) {
            /* There's more in this frame. */
            continue;
        }

        b->idx = 0;

        if (b->repeatcount > 1) {
            /* Play this frame again? */
            b->repeatcount--;
        } else if (d->buffer_fullness > 1) {
            /* Move to the next frame */
            /*
               trace(d, "L: advancing - b %d\n",
               d->buffer_fullness);
             */
            d->buffer_fullness--;
            d->buffer_read++;
            if (d->buffer_read >= BUFFER_NFRAMES)
                d->buffer_read = 0;
        } else if (b->repeatcount >= 0) {
            /* Stop playing until we get a new frame. Don't log right away, since we
             * might be in a situation where this DAC is getting shorter frames than
             * other DACs - instead, return to ready but don't log, and if we still
             * have no content in a bit, log. Either way, loop around after. */
            d->state = ST_READY;
            d->worker_cond.wait_for(lock, 30ms);
            if (d->state == ST_READY) {
                trace(d->dac_id, "L: returning to idle\n");
            }
        } else {
            /* If we get here without hitting any of the above cases,
             * then repeatcount is negative and there's no new frame -
             * so we're just supposed to keep playing this one again
             * and again. */
        }
    }
}
