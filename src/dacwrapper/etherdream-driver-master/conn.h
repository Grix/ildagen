#pragma once

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

#include <array>
#include <cassert>
#include <vector>
#include <chrono>

#include "protocol.h"

#define MAX_LATE_ACKS 12

template <typename T, int N>
class ring_buffer {
public:
    bool empty() const {
        return m_produce == m_consume;
    }
    bool full() const {
        return count() == N - 1;
    }
    size_t count() const {
        return (m_produce - m_consume + N) % N;
    }
    void push(T value) {
        assert(!full());
        m_buffer[m_produce] = std::move(value);
        m_produce = (m_produce + 1) % N;
    }
    T pop() {
        assert(!empty());
        T temp = std::move(m_buffer[m_consume]);
        m_consume = (m_consume + 1) % N;
        return temp;
    }
private:
    size_t m_produce = 0;
    size_t m_consume = 0;
    std::array<T, N> m_buffer;
};

/* Network connection
 */
struct dac_conn_t {
    int32_t dac_id;

    int send_data(dac_point *data, int npoints, int rate);
    int start_if_ready(int rate);

    int get_acks_once(int wait);

    void disconnect();

    const dac_response & last_resp() const { return m_last_resp; }
    const auto & last_ack_time() const { return m_last_ack_time; }
    int unacked_points() const { return m_unacked_points; }
    int pending_meta_acks() const { return m_pending_meta_acks; }

    int osc_send(const char *data, size_t size) {
        return send(m_udp_sock, data, size, 0);
    }

    int osc_receive(char *buf, size_t buf_size) {
        struct sockaddr_in udp_from;
        socklen_t fromlen = sizeof(udp_from);
        int res = recvfrom(m_udp_sock, buf, buf_size, 0, (struct sockaddr *)&udp_from, &fromlen);
        if (res <= 0) {
            return res;
        }
        if (udp_from.sin_addr.s_addr != m_udp_target.sin_addr.s_addr) {
            return -1;
        }
        return res;
    }

private:
    SOCKET m_sock;

    SOCKET m_udp_sock;
    struct sockaddr_in m_udp_target;

    std::array<char, 32> m_firmware_version;

    char m_receive_buf[1024];
    int m_receive_buf_size;
    struct dac_response m_last_resp;
    std::chrono::steady_clock::time_point m_last_ack_time;

    PACK(
        struct {
        struct queue_command queue;
        struct data_command_header header;
        struct dac_point data[1000];
    }) m_local_buffer;

    int m_begin_sent;
    ring_buffer<int, MAX_LATE_ACKS> m_ackbuf;
    int m_unacked_points;
    int m_pending_meta_acks;

    int wait_for_write(int usec);
    int send_all(const char *data, int len);

    template <size_t N> int send_all(const char(&data)[N]) {
        return send_all(data, N);
    }

    int read_bytes(char *buf, int len);
    int read_resp(int timeout);
    void dump_resp() const;
    int wait_for_activity(int usec);
    int get_acks(int wait);
    int read_all_acks();
    int check_data_response();

    friend int dac_connect(dac_conn_t *conn, const char *host, const char *port, int32_t dac_id, const dac_broadcast & identity);
};

void log_socket_error(const char *call);
void log_socket_error(int32_t dac_id, const char *call);

int dac_connect(dac_conn_t *conn, const char *host, const char *port, int32_t dac_id, const dac_broadcast & identity);
