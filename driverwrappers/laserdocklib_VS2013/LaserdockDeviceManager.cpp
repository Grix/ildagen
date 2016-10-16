#include "LaserdockDeviceManager.h"

#include "libusb/libusb.h"
#include <cstdio>
#include <vector>
#include "LaserdockDevice.h"

#define LASERDOCK_VIN 0x1fc9
#define LASERDOCK_PIN 0x04d8



namespace {
	void print_device(libusb_device *device)
	{
		struct libusb_device_descriptor device_descriptor;
		struct libusb_device_handle *device_handle = NULL;

		// Get USB device descriptor
		int result = libusb_get_device_descriptor(device, &device_descriptor);
		if (result < 0) {
			printf("Failed to get device descriptor!");
		}

		// Only print our devices
		if (LASERDOCK_VIN == device_descriptor.idVendor && LASERDOCK_PIN == device_descriptor.idProduct) {
			// Print VID & PID
			printf("0x%04x 0x%04x", device_descriptor.idVendor, device_descriptor.idProduct);
		}
		else {
			return;
		}

		// Attempt to open the device
		int open_result = libusb_open(device, &device_handle);
		if (open_result < 0) {
			fprintf(stderr, libusb_error_name(open_result));
			fprintf(stderr, "\n");
			libusb_close(device_handle);
			return;
		}

		// Print the device manufacturer string
		char manufacturer[256] = " ";
		if (device_descriptor.iManufacturer) {
			libusb_get_string_descriptor_ascii(device_handle, device_descriptor.iManufacturer,
				(unsigned char *)manufacturer, sizeof(manufacturer));
			printf(" %s\n", manufacturer);
		}

		//puts("\n");
		libusb_close(device_handle);
	}

}


struct LaserdockDeviceManagerPrivate {

	std::vector<LaserdockDevice *> devices;
	std::vector<libusb_device *> usbdevices;

	LaserdockDeviceManagerPrivate(LaserdockDeviceManager *q_ptr) :q(q_ptr), devices(), usbdevices() {
		this->initialize_usb();
	};

	bool initialize_usb() {
		int rc;
		rc = libusb_init(NULL);
		if (rc < 0)
		{
			fprintf(stderr, "Error initializing libusb: %d\n", /*libusb_error_name(rc)*/rc);
			return false;
		}

		return true;
	}

	bool is_laserdock(libusb_device * device){
		struct libusb_device_descriptor device_descriptor;
		int result = libusb_get_device_descriptor(device, &device_descriptor);

		if (LASERDOCK_VIN == device_descriptor.idVendor && LASERDOCK_PIN == device_descriptor.idProduct)
			return true;

		return false;
	}

	LaserdockDevice * discover_devices(){
		this->usbdevices.clear();

		libusb_device **list;
		ssize_t cnt = libusb_get_device_list(NULL, &list);
		ssize_t i = 0;

		int err = 0;
		if (cnt < 0) {
			fprintf(stderr, "Error finding USB device\n");
			libusb_free_device_list(list, 1);
			return NULL;
		}

		for (i = 0; i < cnt; i++) {
			libusb_device *device = list[i];
			if (is_laserdock(device)) {
				std::unique_ptr<LaserdockDevice> d(new LaserdockDevice(device));
				if (d->status() == LaserdockDevice::LaserdockDeviceStatus::INITIALIZED)
					this->usbdevices.push_back(device);
			}
		}

		libusb_free_device_list(list, 1);
		return NULL;
	}

	LaserdockDevice * discover_next_available_device() {
		libusb_device **list;
		ssize_t cnt = libusb_get_device_list(NULL, &list);
		ssize_t i = 0;

		int err = 0;
		if (cnt < 0) {
			fprintf(stderr, "Error finding USB device\n");
			libusb_free_device_list(list, 1);
			return NULL;
		}

		for (i = 0; i < cnt; i++) {
			libusb_device *device = list[i];
			if (is_laserdock(device)) {
				LaserdockDevice * d = new LaserdockDevice(device);
				if (d->status() == LaserdockDevice::LaserdockDeviceStatus::INITIALIZED)
					return d;
			}
		}

		libusb_free_device_list(list, 1);
		return NULL;
	}

private:
	LaserdockDeviceManager * q;
};

LaserdockDeviceManager::LaserdockDeviceManager()
	: d(new LaserdockDeviceManagerPrivate(this)) {

}

LaserdockDeviceManager::~LaserdockDeviceManager() {
}

LaserdockDeviceManager &LaserdockDeviceManager::getInstance()
{
	static LaserdockDeviceManager    instance;
	return instance;
}

void LaserdockDeviceManager::list_laserdock_devices() {
	d->discover_devices();

	for (auto device : d->usbdevices) {
		print_device(device);
	}
}

LaserdockDevice *LaserdockDeviceManager::get_next_available_device() {
	return d->discover_next_available_device();
}
