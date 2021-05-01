/* Copyright 2011-2017 Jacob Potter
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

#ifndef DAC_H
#define DAC_H

#include <winsock2.h>
#include <ws2tcpip.h>
#include <iphlpapi.h>

#include "protocol.h"
#include "j4cDAC.h"

#include "conn.h"

#include <memory>
#include <vector>
#include <thread>
#include <mutex>
#include <condition_variable>

#define BUFFER_POINTS_PER_FRAME 16000
#define BUFFER_NFRAMES          2

#define DAC_MIN_SEND 40

/* Double buffer
 */
struct buffer_item {
    struct dac_point data[BUFFER_POINTS_PER_FRAME];
    int points;
    int pps;
    int repeatcount;
    int idx = 0;
};

enum dac_state {
    ST_DISCONNECTED,
    ST_READY,
    ST_RUNNING,
    ST_BROKEN,
    ST_SHUTDOWN
};

/* DAC
 */
struct dac_t {
    struct buffer_item buffer[BUFFER_NFRAMES];
    int buffer_read, buffer_fullness;
    int bounce_count;

    std::thread worker_thread;
    std::mutex worker_mutex;
    std::condition_variable worker_cond;

    struct in_addr addr;
    dac_conn_t conn;
    int32_t dac_id;

    dac_broadcast identity; // set only when first seen, for hw revision, etc

    enum dac_state state;

    int dmx_rx_enabled;

    struct dac_t * next;
};

void trace(const char *fmt, ...);
void trace(int32_t dac, const char *fmt, ...);

int dac_open_connection(dac_t *d);
void dac_close_connection(dac_t *d);
dac_t *dac_get(int);
struct buffer_item *buf_get_write(dac_t *d);
void buf_advance_write(dac_t *d);
int dac_get_status(dac_t *d);
bool do_write_frame(dac_t *d, const void * data, int bytes, int pps,
    int reps, int (*convert)(struct buffer_item *, const void *, int, int));
void dac_get_name(dac_t *d, char *buf, int max);

#endif
