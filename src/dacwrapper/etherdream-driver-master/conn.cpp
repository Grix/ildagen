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

#define WINVER 0x0501

#include <winsock2.h>
#include <ws2tcpip.h>
#include <iphlpapi.h>

#include <stdio.h>
#include <stdint.h>

#include "conn.h"

extern void trace(const char *fmt, ...);
extern void trace(int32_t dac, const char *fmt, ...);

#define DEFAULT_TIMEOUT 2000000

/* Log a socket error to the driver log file.
 */
void log_socket_error(const char *call) {
    char buf[80];
    int err = WSAGetLastError();
    FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, err, 0, buf, sizeof(buf), 0);
    trace("!! Socket error in %s: %d: %s\n", call, err, buf);
}

void log_socket_error(int32_t dac_id, const char *call) {
    char buf[80];
    int err = WSAGetLastError();
    FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, err, 0, buf, sizeof(buf), 0);
    trace(dac_id, "!! Socket error in %s: %d: %s\n", call, err, buf);
}

/* Wait for activity on one file descriptor.
 */
int dac_conn_t::wait_for_activity(int usec) {
    fd_set set;
    FD_ZERO(&set);
    FD_SET(m_sock, &set);
    struct timeval time;
    time.tv_sec = usec / 1000000;
    time.tv_usec = usec % 1000000;
    int res = select(0, &set, nullptr, &set, &time);

    if (res == SOCKET_ERROR) {
        log_socket_error(dac_id, "select");
        return -1;
    }

    return res;
}

/* Wait for writability.
 */
int dac_conn_t::wait_for_write(int usec) {
    fd_set set;
    FD_ZERO(&set);
    FD_SET(m_sock, &set);
    struct timeval time;
    time.tv_sec = usec / 1000000;
    time.tv_usec = usec % 1000000;
    int res = select(0, nullptr, &set, &set, &time);

    if (res == SOCKET_ERROR) {
        log_socket_error(dac_id, "select");
        return -1;
    }

    return res;
}

/* Read exactly n bytes from the DAC connection socket.
 *
 * This reads exactly len bytes into buf. Data is read in chunks from the
 * OS socket library and buffered in the dac_conn_t structure; individual
 * sections are then copied out.
 *
 * Returns 0 on success, -1 on error. If an error occurs, this will call
 * log_socket_error() to log the issue. The error code is also available
 * from WSAGetLastError().
 */
int dac_conn_t::read_bytes(char *buf, int len) {
    while (m_receive_buf_size < len) {
        // Wait for readability.
        int res = wait_for_activity(DEFAULT_TIMEOUT);

        if (res < 0) {
            closesocket(m_sock);
            closesocket(m_udp_sock);
            m_sock = INVALID_SOCKET;
            return -1;
        } else if (res == 0) {
            trace(dac_id, "!! Read from DAC timed out.\n");
            closesocket(m_sock);
            closesocket(m_udp_sock);
            m_sock = INVALID_SOCKET;
            return -1;
        }

        res = recv(m_sock, m_receive_buf + m_receive_buf_size,
                len - m_receive_buf_size, 0);

        if (res == SOCKET_ERROR) {
            log_socket_error(dac_id, "recv");
            return -1;
        }

        if (res == 0) {
            trace(dac_id, "conn closed in recv");
            return -1;
        }

        m_receive_buf_size += res;
    }

    memcpy(buf,  m_receive_buf, len);
    if (m_receive_buf_size > len) {
        memmove(m_receive_buf, m_receive_buf + len, m_receive_buf_size - len);
    }
    m_receive_buf_size -= len;

    return 0;
}

/* Read a response from the DAC into the dac_resp global
 *
 * This only reads the response structure. It does no parsing of the
 * result. All processing of dac_resp is the responsibility of the caller.
 *
 * Returns 0 on success, -1 on error. On error, log_socket_error() will
 * have been called.
 */
int dac_conn_t::read_resp(int timeout) {
    int res = read_bytes((char *)&m_last_resp, sizeof(m_last_resp));
    if (res < 0)
        return res;

    m_last_ack_time = decltype(m_last_ack_time)::clock::now();

    return 0;
}

void dac_conn_t::dump_resp() const {
    const dac_status *st = &last_resp().dac_status;
    trace(dac_id, "Protocol %d / LE %d / playback %d / source %d\n",
            0 /* st->protocol */, st->light_engine_state,
            st->playback_state, st->source);
    trace(dac_id, "Flags: LE %x, playback %x, source %x\n",
            st->light_engine_flags, st->playback_flags,
            st->source_flags);
    trace(dac_id, "Buffer: %d points, %d pps, %d total played\n",
            st->buffer_fullness, st->point_rate, st->point_count);
}


/* Initialize a dac_conn_t and connect to the DAC.
 *
 * On success, return 0.
 */
int dac_connect(dac_conn_t *conn, const char *host, const char *port, int32_t dac_id, const dac_broadcast & identity) {
    ZeroMemory(conn, sizeof(*conn));
    conn->dac_id = dac_id;

    // Look up the server address
    struct addrinfo *result = nullptr, *ptr = nullptr, hints;
    ZeroMemory(&hints, sizeof(hints));
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;

    trace(conn->dac_id, "Calling getaddrinfo: \"%s\", \"%s\"\n", host, port);

    int res = getaddrinfo(host, port, &hints, &result);
    if (res != 0) {
        trace(conn->dac_id, "getaddrinfo failed: %d\n", res);
        return -1;
    }

    // Create a SOCKET
    ptr = result;
    conn->m_sock = socket(ptr->ai_family, ptr->ai_socktype,
            ptr->ai_protocol);

    if (conn->m_sock == INVALID_SOCKET) {
        log_socket_error(conn->dac_id, "socket");
        freeaddrinfo(result);
        return -1;
    }

    unsigned long nonblocking = 1;
    ioctlsocket(conn->m_sock, FIONBIO, &nonblocking);

    memset(&conn->m_udp_target, 0, sizeof(conn->m_udp_target));
    conn->m_udp_target.sin_family = AF_INET;
    conn->m_udp_target.sin_addr.s_addr = ((struct sockaddr_in *)(ptr->ai_addr))->sin_addr.s_addr;
    conn->m_udp_target.sin_port = htons(60000);

    // Connect to host. Because the socket is nonblocking, this
    // will always return WSAEWOULDBLOCK.
    connect(conn->m_sock, ptr->ai_addr, (int)ptr->ai_addrlen);
    freeaddrinfo(result);

    if (WSAGetLastError() != WSAEWOULDBLOCK) {
        log_socket_error(conn->dac_id, "connect");
        closesocket(conn->m_sock);
        conn->m_sock = INVALID_SOCKET;
        return -1;
    }

    // Wait for connection.
    fd_set set;
    FD_ZERO(&set);
    FD_SET(conn->m_sock, &set);
    struct timeval time;
    time.tv_sec = 0;
    time.tv_usec = DEFAULT_TIMEOUT;
    res = select(0, &set, &set, &set, &time);

    if (res == SOCKET_ERROR) {
        log_socket_error(conn->dac_id, "select");
        closesocket(conn->m_sock);
        conn->m_sock = INVALID_SOCKET;
        return -1;
    } else if (res == 0) {
        trace(conn->dac_id, "Connection to %s timed out.\n", host);
        closesocket(conn->m_sock);
        conn->m_sock = INVALID_SOCKET;
        return -1;
    }

    // See if we have *actually* connected
    int error;
    int len = sizeof(error);
    if (getsockopt(conn->m_sock, SOL_SOCKET, SO_ERROR, (char *)&error, &len) ==
            SOCKET_ERROR) {
        log_socket_error(conn->dac_id, "getsockopt");
        closesocket(conn->m_sock);
        conn->m_sock = INVALID_SOCKET;
        return -1;
    }

    if (error) {
        WSASetLastError(error);
        log_socket_error(conn->dac_id, "connect");
        closesocket(conn->m_sock);
        conn->m_sock = INVALID_SOCKET;
        return -1;
    }

    BOOL ndelay = 1;
    res = setsockopt(conn->m_sock, IPPROTO_TCP, TCP_NODELAY,
            (char *)&ndelay, sizeof(ndelay));
    if (res == SOCKET_ERROR) {
        log_socket_error(conn->dac_id, "setsockopt TCP_NODELAY");
        closesocket(conn->m_sock);
        conn->m_sock = INVALID_SOCKET;
        return -1;
    }

    trace(conn->dac_id, "Connected.\n");

    // Create socket for OSC
    conn->m_udp_sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (conn->m_udp_sock == INVALID_SOCKET) {
        log_socket_error(conn->dac_id, "socket(AF_INET, SOCK_DRGAM)");
    } else {
        res = connect(conn->m_udp_sock, (struct sockaddr *)&conn->m_udp_target, sizeof(conn->m_udp_target));
        if (res == SOCKET_ERROR) {
            log_socket_error(conn->dac_id, "connect(udp_sock)");
        }
    }

    nonblocking = 1;
    ioctlsocket(conn->m_udp_sock, FIONBIO, &nonblocking);

    // After we connect, the host will send an initial status response.
    conn->read_resp(DEFAULT_TIMEOUT);
    conn->dump_resp();

    conn->send_all({ 'p' });
    conn->read_resp(DEFAULT_TIMEOUT);
    conn->dump_resp();

    if (identity.sw_revision >= 2) {
        conn->send_all({ 'v' });
        res = conn->read_bytes(conn->m_firmware_version.data(), conn->m_firmware_version.size());
        if (res < 0)
            return res;

        trace(conn->dac_id, "DAC version: %.*s\n", conn->m_firmware_version.size(), conn->m_firmware_version.data());
    } else {
        conn->m_firmware_version = {};
        trace(conn->dac_id, "DAC version old!\n");
    }

    /* Send a prepare command */
    trace(conn->dac_id, "init: Sending prepare and stop commands...\n");
    if ((res = conn->send_all({ 's', 'p' })) < 0)
        return res;
    conn->m_pending_meta_acks = 2;

    /* Block here until all ACKs received... */
    while (conn->m_pending_meta_acks) {
        if (conn->get_acks(1500) < 0) {
            return -1;
        }
    }

    return 0;
}

void dac_conn_t::disconnect() {
    closesocket(m_sock);
    closesocket(m_udp_sock);
    m_sock = INVALID_SOCKET;
}

int dac_conn_t::send_all(const char *data, int len) {
    do {
        int res = wait_for_write(1500000);
        if (res < 0) {
            return -1;
        } else if (res == 0) {
            trace(dac_id, "write timed out\n");
        }

        res = send(m_sock, data, len, 0);

        if (res == SOCKET_ERROR) {
            log_socket_error(dac_id, "send");
            return -1;
        }

        len -= res;
        data += res;
    } while (len);

    return 0;
}

int dac_conn_t::check_data_response() {
    if (m_last_resp.dac_status.playback_state == 0)
        m_begin_sent = 0;

    if (m_last_resp.command == 'd' || m_last_resp.command == 'P' || m_last_resp.command == 'D' || m_last_resp.command == 'e') {
        if (m_ackbuf.empty()) {
            trace(dac_id, "!! Protocol error: didn't expect data ack\n");
            return -1;
        }
        m_unacked_points -= m_ackbuf.pop();
    } else {
        if (m_pending_meta_acks > 0) {
            m_pending_meta_acks--;
        } else {
            trace(dac_id, "!! unexpected meta ACK\n");
        }
    }

    if (m_last_resp.response != 'a' && m_last_resp.response != 'I') {
        trace(dac_id, "!! Protocol error: ACK for '%c' got '%c' (%d)\n",
            m_last_resp.command,
            m_last_resp.response, m_last_resp.response);
        return -1;
    }

    return 0;
}

int dac_conn_t::read_all_acks() {
    int pma_iter_count = 0;
    int res;

    while (m_pending_meta_acks) {
        trace(dac_id, "L: PMA %d\n", m_pending_meta_acks);
        if ((res = get_acks(1500)) < 0) {
            return res;
        }

        if (pma_iter_count % 20 == 0) {
            if ((res = send_all({ '?' })) < 0) {
                return res;
            }
            m_pending_meta_acks++;
        }

        pma_iter_count++;
    }

    return 0;
}

int dac_conn_t::start_if_ready(int rate) {
    int res;
    const dac_status &st = m_last_resp.dac_status;

    int iter_count = 0;
    while (m_ackbuf.full()) {
        trace(dac_id, "L: ackbuff full, waiting (%d)...\n", iter_count++);
        if ((res = get_acks(1500)) < 0) {
            return res;
        }
    }

    // If it's been a while since we last sent data, catch up
    if (m_last_ack_time < (std::chrono::steady_clock::now() - std::chrono::milliseconds(200))) {
        trace(dac_id, "L: restarting playback\n");
        if ((res = send_all({ '?' })) < 0) {
            return res;
        }

        m_pending_meta_acks++;
        if ((res = read_all_acks()) < 0) {
            return res;
        }

        trace(dac_id, "L: restart ping done\n");
    }

    if (st.playback_state == 0) {
        trace(dac_id, "L: Sending prepare command...\n");
        if ((res = send_all({ 'p' })) < 0)
            return res;

        m_pending_meta_acks++;
        if ((res = read_all_acks()) < 0) {
            return res;
        }

        trace(dac_id, "L: prepare ACKed\n");
    }

    if (st.buffer_fullness > 1500 && st.playback_state == 1 && !m_begin_sent) {
        trace(dac_id, "L: Sending begin command...\n");

        struct begin_command b;
        b.command = 'b';
        b.point_rate = rate;
        b.low_water_mark = 0;
        if ((res = send_all((const char *)&b, sizeof(b))) < 0)
            return res;

        m_begin_sent = 1;
        m_pending_meta_acks++;
    }

    return 0;
}

int dac_conn_t::send_data(struct dac_point *data, int npoints, int rate) {
    int res;
    const dac_status &st = m_last_resp.dac_status;

    if ((res = start_if_ready(rate)) < 0) {
        return res;
    }

    m_local_buffer.queue.command = 'q';
    m_local_buffer.queue.point_rate = rate;

    m_local_buffer.header.command = 'd';
    m_local_buffer.header.npoints = npoints;
    memcpy(&m_local_buffer.data[0], data, npoints * sizeof(struct dac_point));

    m_local_buffer.data[0].control |= DAC_CTRL_RATE_CHANGE;
    size_t data_size = npoints * sizeof(struct dac_point);

    static_assert(sizeof(m_local_buffer) == 18008, "buffer size mismatch - check struct packing?");

    /* Write the data */
    if ((res = send_all((const char *)&m_local_buffer, 8 + data_size)) < 0)
        return res;

    /* Expect two ACKs */
    m_pending_meta_acks++;
    m_ackbuf.push(npoints);
    m_unacked_points += npoints;

    if ((res = get_acks(1)) < 0)
        return res;

    return npoints;
}

int dac_conn_t::get_acks_once(int wait) {
    int res;
    if (wait_for_activity(wait)) {
        if ((res = read_resp(1)) < 0)
            return res;
        if ((res = check_data_response()) < 0)
            return res;
    }
    return 0;
}

int dac_conn_t::get_acks(int wait) {
    /* Read any ACKs we are owed */
    while (m_pending_meta_acks || !m_ackbuf.empty()) {
        int res;
        if (wait_for_activity(wait)) {
            if ((res = read_resp(1)) < 0)
                return res;
            if ((res = check_data_response()) < 0)
                return res;
        } else {
            break;
        }
    }
    return 0;
}
