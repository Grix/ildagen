//
// Created by Guoping Huang on 8/8/16.
//

#ifndef LASERDOCKLIB_LASERDOCKDEVICE_H
#define LASERDOCKLIB_LASERDOCKDEVICE_H

#include <cstdint>
#include <memory>

#include "libusb/libusb.h"

typedef struct
{
	uint16_t rg;      //lower byte is red, top byte is green
	uint16_t b;       //lower byte is blue
	uint16_t x;
	uint16_t y;
} LaserdockSample;


uint16_t float_to_laserdock_xy(float var);

uint16_t laserdock_sample_flip(uint16_t);


class LaserdockDevicePrivate;

class LaserdockDevice {

public:

	enum LaserdockDeviceStatus { UNKNOWN, INITIALIZED };

	LaserdockDevice(libusb_device * usbdevice);
	~LaserdockDevice();

	bool enable_output();
	bool disable_output();
	bool get_output(bool * enabled);

	bool dac_rate(uint32_t *rate);
	bool set_dac_rate(uint32_t rate);
	bool max_dac_rate(uint32_t *rate);
	bool min_dac_value(uint32_t *value);
	bool max_dac_value(uint32_t *value);

	bool sample_element_count(uint32_t *count);
	bool iso_packet_sample_count(uint32_t *count);
	bool bulk_packet_sample_count(uint32_t *count);

	bool version_major_number(uint32_t *major);
	bool version_minor_number(uint32_t *minor);

	bool clear_ringbuffer();
	bool ringbuffer_sample_count(uint32_t *count);
	bool ringbuffer_empty_sample_count(uint32_t *count);

	bool runner_mode_enable(bool);
	bool runner_mode_run(bool);
	bool runner_mode_load(LaserdockSample *samples, uint16_t position, uint16_t count);

	bool send(unsigned char * data, uint32_t length);
	bool send_samples(LaserdockSample * samples, uint32_t count);

	bool flixpX();
	bool flixpY();

	void setFlipX(bool);
	void setFlipY(bool);

	LaserdockDeviceStatus status();

	bool usb_send(unsigned char *data, int length);
	unsigned char *usb_get(unsigned char * data, int length);

private:
	std::unique_ptr<LaserdockDevicePrivate> d;
};

#endif //LASERDOCKLIB_LASERDOCKDEVICE_H
