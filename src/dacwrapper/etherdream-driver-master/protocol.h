/* Copyright 2011 Jacob Potter
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

#ifndef PROTOCOL_H
#define PROTOCOL_H

#include <stdint.h>

#ifdef MSVC
#define PACK( __Declaration__ ) __pragma( pack(push, 1) ) __Declaration__ __pragma( pack(pop) )
#else
#define PACK( __Declaration__ ) __Declaration__ __attribute__((__packed__))
#endif

typedef struct dac_point {
	uint16_t control;
	int16_t x;
	int16_t y;
	uint16_t r;
	uint16_t g;
	uint16_t b;
	uint16_t i;
	uint16_t u1;
	uint16_t u2;
} dac_point_t;

#define DAC_CTRL_RATE_CHANGE    0x8000

PACK(
struct dac_status {
	uint8_t protocol;
	uint8_t light_engine_state;
	uint8_t playback_state;
	uint8_t source;
	uint16_t light_engine_flags;
	uint16_t playback_flags;
	uint16_t source_flags;
	uint16_t buffer_fullness;
	uint32_t point_rate;
	uint32_t point_count;
});

PACK(
struct dac_broadcast {
	uint8_t mac_address[6];
	uint16_t hw_revision;
	uint16_t sw_revision;
	uint16_t buffer_capacity;
	uint32_t max_point_rate;
        struct dac_status status;
});

PACK(
struct begin_command {
	uint8_t command;	/* 'b' (0x62) */
	uint16_t low_water_mark;
	uint32_t point_rate;
});

PACK(
struct queue_command {
	uint8_t command;	/* 'q' (0x74) */
	uint32_t point_rate;
});

PACK(
struct data_command {
	uint8_t command;	/* 'd' (0x64) */
	uint16_t npoints;
	struct dac_point data[];
});

PACK(
struct data_command_header {
	uint8_t command;	/* 'd' (0x64) */
	uint16_t npoints;
});

PACK(
struct dac_response {
	uint8_t response;
	uint8_t command;
	struct dac_status dac_status;
});

#define CONNCLOSED_USER		(1)
#define CONNCLOSED_UNKNOWNCMD	(2)
#define CONNCLOSED_SENDFAIL	(3)
#define CONNCLOSED_MASK		(0xF)

#define RESP_ACK		'a'
#define RESP_NAK_FULL		'F'
#define RESP_NAK_INVL		'I'
#define RESP_NAK_ESTOP		'!'

#endif
