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
#include <string.h>
#include <sys/stat.h>
#include "dac.h"

#ifdef __cplusplus
#define EXPORT extern "C"
#endif

#ifdef MSVC
#include <process.h>
#include <shlwapi.h>
#include <ShlObj.h>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <iphlpapi.h>
#include <Windows.h>
#else
#define EXPORT __declspec(dllexport)
#endif

#include <thread>
#include <chrono>

/* Globals
 */

static CRITICAL_SECTION dac_list_lock;
dac_t * dac_list = nullptr;

HANDLE ThisDll = nullptr, watcherthread = nullptr;
static FILE * logging_fp = nullptr;
int fucked = 0;
int time_to_go = 0;
std::chrono::system_clock::time_point load_time;

static std::chrono::steady_clock::time_point log_timer_start;

/* Logging
 */
static void trace_impl(const int32_t *id, const char *fmt, va_list args) {
    if (logging_fp == nullptr) return;

    auto v = std::chrono::duration_cast<std::chrono::microseconds>(
        std::chrono::steady_clock::now() - log_timer_start).count();

    char linebuf[1024];
    vsnprintf(linebuf, sizeof(linebuf), fmt, args);

    if (id) {
        fprintf(logging_fp, "[%d.%06d] %06x %s", (int)(v / 1000000), (int)(v % 1000000), *id & 0xffffff, linebuf);
    } else {
        fprintf(logging_fp, "[%d.%06d]        %s", (int)(v / 1000000), (int)(v % 1000000), linebuf);
    }
}

void trace(const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    trace_impl(nullptr, fmt, args);
    va_end(args);
}

void trace (int32_t dac_id, const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    trace_impl(&dac_id, fmt, args);
    va_end(args);
}

void dac_list_insert(dac_t *d) {
    EnterCriticalSection(&dac_list_lock);
    d->next = dac_list;
    dac_list = d;
    LeaveCriticalSection(&dac_list_lock);
}

unsigned __stdcall FindDACs(void *_bogus) {
    SOCKET sock;

    sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (sock == INVALID_SOCKET) {
        log_socket_error("socket");
        return 1;
    }

    int opt = 1;
    if (setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, (const char *)&opt, sizeof(opt)) < 0) {
        log_socket_error("setsockopt SO_REUSEADDR");
        return 1;
    }

    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(7654);
    addr.sin_addr.s_addr = htonl(INADDR_ANY);

    if (bind(sock, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        log_socket_error("bind");
        return 1;
    }

    trace("_: listening for DACs...\n");

    while(!time_to_go) {
        struct sockaddr_in src;
        struct dac_broadcast buf;
        int srclen = sizeof(src);
        int len = recvfrom(sock, (char *)&buf, sizeof(buf), 0, (struct sockaddr *)&src, &srclen);
        if (len < 0) {
            log_socket_error("recvfrom");
            return 1;
        }

        /* See if this is a DAC we already knew about */
        EnterCriticalSection(&dac_list_lock);
        dac_t *p = dac_list;
        while (p) {
            if (p->addr.s_addr == src.sin_addr.s_addr) break;
            p = p->next;
        }

        if (p && (p->addr.s_addr == src.sin_addr.s_addr)) {
            LeaveCriticalSection(&dac_list_lock);
            continue;
        }

        LeaveCriticalSection(&dac_list_lock);

        /* Make a new DAC entry */
        dac_t * new_dac = new dac_t;
        if (!new_dac) {
            trace("!! dac_t allocation failed\n");
            continue;
        }

        new_dac->addr = src.sin_addr;
        new_dac->dac_id = (1 << 31) | (buf.mac_address[3] << 16) \
            | (buf.mac_address[4] << 8) | buf.mac_address[5];
        new_dac->identity = buf;

        char host[40];
        strncpy(host, inet_ntoa(src.sin_addr), sizeof(host) - 1);
        host[sizeof(host) - 1] = 0;

        trace("_: Found new DAC: %s\n", inet_ntoa(src.sin_addr));

        new_dac->state = ST_DISCONNECTED;
        dac_list_insert(new_dac);
    }

    trace("_: Exiting\n");

    return 0;
}

void startWatcherThread()
{
    time_to_go = 0;
    watcherthread = (HANDLE)_beginthreadex(nullptr, 0, &FindDACs, nullptr, 0, nullptr);
    if (!watcherthread) {
        trace("!! BeginThreadEx error: %s\n", strerror(errno));
        fucked = 1;
    }
}

void __cdecl edInvalidParameterHandler(const wchar_t* expression,
        const wchar_t* function,
        const wchar_t* file,
        unsigned int line,
        uintptr_t pReserved)
{
    char buf[1000];
    snprintf(buf, sizeof(buf), "Invalid parameter in %ls: "
            "%ls:%d: %ls", function, file, line, expression);
    MessageBox(nullptr, buf, nullptr, 0);
    abort();
}

static FILE *attempt_open_log_file(const char *fn) {
    struct stat st;
    bool should_append = !stat(fn, &st) && st.st_size < 1000000;

    return fopen(fn, should_append ? "a" : "w");
}

static FILE *open_mydocuments_log_file() {
    char fn[MAX_PATH];
    HRESULT res = SHGetFolderPath(nullptr, CSIDL_PERSONAL, nullptr, SHGFP_TYPE_CURRENT, fn);
    if (res != S_OK) {
        return nullptr;
    }

    strncat(fn, "\\LSG\\EtherDreamLog.txt", sizeof(fn));
    return attempt_open_log_file(fn);
}

static FILE *open_dllpath_log_file(HANDLE thisDll) {
    char fn[MAX_PATH];
    GetModuleFileName((HMODULE)ThisDll, fn, sizeof(fn) - 1);
    PathRemoveFileSpec(fn);

    strncat(fn, "\\EtherDreamLog.txt", sizeof(fn));
    return attempt_open_log_file(fn);
}

static FILE * open_log_file(HANDLE thisDll) {
    // First try the documents folder
    FILE *fp;

    if ((fp = open_mydocuments_log_file())) {
        return fp;
    } else if (fp = open_dllpath_log_file(thisDll)) {
        return fp;
    } else {
        return nullptr;
    }
}

/* Stub DllMain function.
 */
bool __stdcall DllMain(HANDLE hModule, DWORD reason, LPVOID lpReserved) {
    _invalid_parameter_handler newHandler;
    newHandler = &edInvalidParameterHandler;
    _set_invalid_parameter_handler(newHandler);
    ThisDll = hModule;

    fucked = 0;

    if (reason == DLL_PROCESS_ATTACH) {
        log_timer_start = std::chrono::steady_clock::now();

        /* Log file */
        if (!logging_fp) {
            logging_fp = open_log_file(hModule);
            if (logging_fp) {
                fprintf(logging_fp, "----------\n");
                fflush(logging_fp);
                trace("== DLL Loaded ==\n");
            }
        }

        trace("== DLL Init ==\n");

        // Initialize Winsock
        WSADATA wsaData;
        int res = WSAStartup(MAKEWORD(2,2), &wsaData);
        if (res != 0) {
            trace("!! WSAStartup failed: %d\n", res);
            fucked = 1;
        }

        InitializeCriticalSection(&dac_list_lock);
        time_to_go = 0;

        // Start up a thread looking for broadcasts
        startWatcherThread();

        load_time = std::chrono::system_clock::now();

        SetPriorityClass(GetCurrentProcess(), HIGH_PRIORITY_CLASS);

        DWORD pc = GetPriorityClass(GetCurrentProcess());
        trace("Process priority class: %d\n", pc);
        if (!pc) trace("Error: %d\n", GetLastError());

        if (logging_fp) {
            fflush(logging_fp);
        }

    } else if (reason == DLL_PROCESS_DETACH) {
        EtherDreamClose();

        WSACleanup();
        DeleteCriticalSection(&dac_list_lock);

        if (logging_fp) {
            trace("== DLL Unloaded ==\n");
            fclose(logging_fp);
            logging_fp = nullptr;
        }
    }
    return 1;
}

/* Get the output status.
 */
EXPORT int __stdcall EtherDreamGetStatus(const int *CardNum) {
    dac_t *d = dac_get(*CardNum);
    if (!d) {
        trace("M: GetStatus(%d) return -1\n", *CardNum);
        return -1;
    }

    int st = dac_get_status(d);
    if (st == GET_STATUS_BUSY) {
        d->bounce_count++;
        if (d->bounce_count > 20)
            trace(d->dac_id, "M: bouncing\n");
        Sleep(2);
    } else {
        d->bounce_count = 0;
    }

    return st;
}

static void do_close(void) {
    EnterCriticalSection(&dac_list_lock);
    dac_t *d = dac_list;
    while (d) {
        if (d->state != ST_DISCONNECTED)
            dac_close_connection(d);
        d = d->next;
    }
    LeaveCriticalSection(&dac_list_lock);
}

void wait_after_startup() {
    /* Gross-vile-disgusting-sleep for up to a bit over a second to
     * catch broadcast packets from DACs */
    using namespace std::chrono;
    using namespace std::chrono_literals;

    auto time_since_load = system_clock::now() - load_time;
    auto time_left = 1100ms - time_since_load;
    if (watcherthread == nullptr) {
        startWatcherThread();
        time_left = 1200ms;
    }

    trace("Waiting %d milliseconds.\n", duration_cast<milliseconds>(time_left).count());
    if (time_left > 0s && time_left < 2s) {
        std::this_thread::sleep_for(time_left);
    }
}

EXPORT int __stdcall EtherDreamGetCardNum(void){

    trace("== EtherDreamGetCardNum ==\n");

    /* Clean up any already opened DACs */
    do_close();

    wait_after_startup();

    /* Count how many DACs we have. */
    int count = 0;

    EnterCriticalSection(&dac_list_lock);
    dac_t *d = dac_list;
    while (d) {
        d = d->next;
        count++;
    }
    LeaveCriticalSection(&dac_list_lock);

    trace("Found %d DACs.\n", count);

    return count;
}

EXPORT int __stdcall EtherDreamGetVersion(const int *CardNum) {
    return 0;
}

EXPORT bool __stdcall EtherDreamStop(const int *CardNum){
    dac_t *d = dac_get(*CardNum);
    if (!d) {
        trace("== Stop(%d) ==\n", *CardNum);
        return 0;
    }
    trace(d->dac_id, "== Stop(%d) ==\n", *CardNum);

    std::unique_lock<std::mutex> lock(d->worker_mutex);
    d->state = ST_READY;
    d->worker_cond.notify_all();

    return 0;
}

EXPORT bool __stdcall EtherDreamClose(void){
    trace("== Close ==\n");
    time_to_go = 1;
    WSACancelBlockingCall();
    if (!fucked && watcherthread) {
        if (WaitForSingleObject(watcherthread, 1200) != WAIT_OBJECT_0) {
            TerminateThread(watcherthread, -1);
            trace("!! Had to kill watcher thread on exit.\n");
        }
        CloseHandle(watcherthread);
        watcherthread = nullptr;
    }
    do_close();
    return 0;
}

EXPORT bool __stdcall EtherDreamOpenDevice(const int *CardNum) {
    dac_t *d = dac_get(*CardNum);
    if (!d) return 0;
    if (dac_open_connection(d) < 0) return 0;
    trace(d->dac_id, "device opened\n");
    return 1;
}

EXPORT bool __stdcall EtherDreamCloseDevice(const int *CardNum) {
    dac_t *d = dac_get(*CardNum);
    if (!d) return 0;
    dac_close_connection(d);
    return 1;
}

/****************************************************************************/

/* Data conversion functions
 */
int EasyLase_convert_data(struct buffer_item *buf, const void *vdata, int bytes, int rep) {
    const struct EL_Pnt_s *data = (const struct EL_Pnt_s *)vdata;
    int points = bytes / sizeof(*data);
    int i;

    if (!buf) return points * rep;
    if (points > BUFFER_POINTS_PER_FRAME) {
        points = BUFFER_POINTS_PER_FRAME;
    }

    int o = 0;
    for (i = 0; i < points; i++) {
        int j;
        for (j = 0; j < rep; j++) {
            buf->data[o].x = (data[i].X - 2048) * 16;
            buf->data[o].y = (data[i].Y - 2048) * 16;
            buf->data[o].r = data[i].R * 256;
            buf->data[o].g = data[i].G * 256;
            buf->data[o].b = data[i].B * 256;
            buf->data[o].i = data[i].I * 256;
            buf->data[o].u1 = 0;
            buf->data[o].u2 = 0;
            buf->data[o].control = 0;
            o++;
        }
    }

    buf->points = points * rep;
    return points * rep;
}

int EzAudDac_convert_data(struct buffer_item *buf, const void *vdata, int bytes, int rep) {
    const struct EAD_Pnt_s *data = (const struct EAD_Pnt_s *)vdata;
    int points = bytes / sizeof(*data);
    int i;

    if (!buf) return points * rep;
    if (points > BUFFER_POINTS_PER_FRAME) {
        points = BUFFER_POINTS_PER_FRAME;
    }

    int o = 0;
    for (i = 0; i < points; i++) {
        int j;
        for (j = 0; j < rep; j++) {
            buf->data[o].x = data[i].X; //  - 32768;
            buf->data[o].y = data[i].Y; //  - 32768;
            buf->data[o].r = data[i].R << 1;
            buf->data[o].g = data[i].G << 1;
            buf->data[o].b = data[i].B << 1;
            buf->data[o].i = data[i].I << 1;
            buf->data[o].u1 = data[i].AL << 1;
            buf->data[o].u2 = data[i].AR << 1;
            buf->data[o].control = 0;
            o++;
        }
    }

    buf->points = points * rep;
    return points * rep;
}

EXPORT bool __stdcall EtherDreamWriteFrame(const int *CardNum, const struct EAD_Pnt_s* data,
        int Bytes, uint16_t PPS, uint16_t Reps) {
    return EzAudDacWriteFrameNR(CardNum, data, Bytes, PPS, Reps);
}

EXPORT bool __stdcall EzAudDacWriteFrameNR(const int *CardNum, const struct EAD_Pnt_s* data,
        int Bytes, uint16_t PPS, uint16_t Reps) {
    dac_t *d = dac_get(*CardNum);
    if (!d) return 0;
    return do_write_frame(d, data, Bytes, PPS, Reps, EzAudDac_convert_data);
}

EXPORT bool __stdcall EzAudDacWriteFrame(const int *CardNum, const struct EAD_Pnt_s* data,
        int Bytes, uint16_t PPS) {
    return EzAudDacWriteFrameNR(CardNum, data, Bytes, PPS, -1);
}

EXPORT bool __stdcall EasyLaseWriteFrameNR(const int *CardNum, const struct EL_Pnt_s* data,
        int Bytes, uint16_t PPS, uint16_t Reps) {
    dac_t *d = dac_get(*CardNum);
    if (!d) return 0;
    return do_write_frame(d, data, Bytes, PPS, Reps, EasyLase_convert_data);
}

EXPORT bool __stdcall EasyLaseWriteFrame(const int *CardNum, const struct EL_Pnt_s* data,
        int Bytes, uint16_t PPS) {
    return EasyLaseWriteFrameNR(CardNum, data, Bytes, PPS, -1);
}

EXPORT void __stdcall EtherDreamGetDeviceName(const int *CardNum, char *buf, int max) {
    if (max <= 0) return;
    buf[0] = 0;
    dac_t *d = dac_get(*CardNum);
    if (!d) return;
    dac_get_name(d, buf, max);
}

EXPORT bool __stdcall EtherDreamWriteDMX(const int *CardNum, int universe, const unsigned char *data) {
    dac_t *d = dac_get(*CardNum);
    if (!d) return 0;

    if (universe < 1) return 0;
    if (universe > 3) return 0;

    char dmx_message[532] = {
        '/', 'd', 'm', 'x', (char)(universe + '0'), 0, 0, 0,
        ',', 'b', 0, 0, 0, 0, 2, 0
    };

    memcpy(dmx_message + 16, data, 512);
    d->conn.osc_send(dmx_message, 532);

    return 1;
}

EXPORT bool __stdcall EtherDreamReadDMX(const int *CardNum, int universe, unsigned char *data) {
    char udp_buf[532];
    bool success = 0;

    dac_t *d = dac_get(*CardNum);
    if (!d) return 0;

    if (universe < 1) return 0;
    if (universe > 3) return 0;

    if (!d->dmx_rx_enabled) {
        const char dmx_input_message[24] = {
            '/', 'd', 'm', 'x', '1', '/', 'i', 'n', 'p', 'u', 't', 0,
            ',', 's', 'i', 0,
            'm', 'e', 0, 0,
            0, 0, 0, 0
        };

        d->conn.osc_send(dmx_input_message, sizeof(dmx_input_message));
        d->dmx_rx_enabled = 1;
        return 0;
    }

    while (1) {
        int len = d->conn.osc_receive(udp_buf, sizeof(udp_buf));
        if (strcmp(udp_buf, "/dmx1"))
            continue;

        memcpy(data, udp_buf + 16, 512);
        success = 1;
    }

    return success;
}


/****************************************************************************/

/* Wrappers and stubs
 */
EXPORT int __stdcall EzAudDacGetCardNum(void) {

    trace("== EzAudDacGetCardNum ==\n");

    /* Clean up any already opened DACs */
    do_close();

    wait_after_startup();

    /* Count how many DACs we have. Along the way, open them */
    int count = 0;

    EnterCriticalSection(&dac_list_lock);
    dac_t *d = dac_list;
    while (d) {
        dac_open_connection(d);
        d = d->next;
        count++;
    }
    LeaveCriticalSection(&dac_list_lock);

    trace("Found %d DACs.\n", count);

    return count;
}

EXPORT int __stdcall EasyLaseGetCardNum(void) {
    return EzAudDacGetCardNum();
}

EXPORT int __stdcall EasyLaseSend(const int *CardNum, const struct EL_Pnt_s* data, int Bytes, uint16_t KPPS) {
    trace("ELSend called: card %d, %d bytes, %d kpps\n", *CardNum, Bytes, KPPS);
    return 1;
}

EXPORT int __stdcall EasyLaseWriteFrameUncompressed(const int *CardNum, const struct EL_Pnt_s* data, int Bytes, uint16_t PPS) {
    trace(" ELWFU called: card %d, %d bytes, %d pps\n", *CardNum, Bytes, PPS);
    return 1;
}

EXPORT int __stdcall EasyLaseReConnect() {
    trace(" ELReConnect called.\n");
    return 0;
}

EXPORT int __stdcall EasyLaseGetLastError(const int *CardNum) {
    return 0;
}

EXPORT int __stdcall EzAudDacGetStatus(const int *CardNum) {
    return EtherDreamGetStatus(CardNum);
}

EXPORT int __stdcall EasyLaseGetStatus(const int *CardNum) {
    return EtherDreamGetStatus(CardNum);
}

EXPORT bool __stdcall EzAudDacStop(const int *CardNum) {
    return EtherDreamStop(CardNum);
}

EXPORT bool __stdcall EasyLaseStop(const int *CardNum) {
    return EtherDreamStop(CardNum);
}

EXPORT bool __stdcall EzAudDacClose(void) {
    return EtherDreamClose();
}

EXPORT bool __stdcall EasyLaseClose(void) {
    return EtherDreamClose();
}

EXPORT bool __stdcall EasyLaseWriteDMX(const int *CardNum, unsigned char * data) {
    return 0;
}

EXPORT bool __stdcall EasyLaseGetDMX(const int *CardNum, unsigned char * data) {
    return 0;
}

EXPORT bool __stdcall EasyLaseDMXOut(const int *CardNum, unsigned char * data, uint16_t Baseaddress, uint16_t ChannelCount) {
    return 0;
}

EXPORT bool __stdcall EasyLaseDMXIn(const int *CardNum, unsigned char * data, uint16_t Baseaddress, uint16_t ChannelCount) {
    return 0;
}

EXPORT bool __stdcall EasyLaseWriteTTL(const int *CardNum, uint16_t TTLValue) {
    return 0;
}

EXPORT bool __stdcall EasyLaseGetDebugInfo(const int *CardNum, void * data, uint16_t count) {
    return 0;
}
