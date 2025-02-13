#include "LaserdockDeviceManager.h"
#include "LaserdockDeviceManager_p.h"

#include <cstdio>
#include <vector>

#include "libusb.h"

#include "LaserdockDevice.h"
#include "LaserdockDeviceManager_p.h"

#define LASERDOCK_VIN 0x1fc9
#define LASERDOCK_PIN 0x04d8

/// ---------------------------- LaserdockDeviceManager ----------------------------

LaserdockDeviceManager &LaserdockDeviceManager::getInstance()
{
    static LaserdockDeviceManager instance;
    return instance;
}

std::vector<std::unique_ptr<LaserdockDevice> > LaserdockDeviceManager::get_laserdock_devices()
{
    return d->get_devices();
}

std::unique_ptr<LaserdockDevice> LaserdockDeviceManager::reopen_device()
{
    libusb_device** libusb_device_list;
    ssize_t cnt = libusb_get_device_list(NULL, &libusb_device_list);
    ssize_t i = 0;

    if (cnt < 0) {
        libusb_free_device_list(libusb_device_list, 1); // probably not necessary
        return 0;
    }

    for (i = 0; i < cnt; i++) {
        libusb_device* libusb_device = libusb_device_list[i];
        if (d->is_laserdock(libusb_device)) {
            std::unique_ptr<LaserdockDevice> d(new LaserdockDevice(libusb_device));
            if (d->status() == LaserdockDevice::Status::INITIALIZED)
            {
                libusb_free_device_list(libusb_device_list, cnt);
                return std::move(d);
            }
        }
    }

    libusb_free_device_list(libusb_device_list, cnt);
    return 0;
}

void LaserdockDeviceManager::print_laserdock_devices() {
    std::vector<std::unique_ptr<LaserdockDevice> > devices = get_laserdock_devices();
    for(const std::unique_ptr<LaserdockDevice> &device : devices) {
        device->print();
    }
}

LaserdockDevice *LaserdockDeviceManager::get_next_available_device() {
    std::vector<std::unique_ptr<LaserdockDevice> > devices = get_laserdock_devices();
    if(devices.size() > 0) {
        return devices[0].release();
    } else {
        return NULL;
    }
}

LaserdockDeviceManager::LaserdockDeviceManager()
    : d(new LaserdockDeviceManagerPrivate(this)) {

}

LaserdockDeviceManager::~LaserdockDeviceManager() {
}

/// ---------------------------- LaserdockDeviceManagerPrivate ----------------------------

LaserdockDeviceManagerPrivate::LaserdockDeviceManagerPrivate(LaserdockDeviceManager *q_ptr) : q(q_ptr) {
    this->initialize_usb();
}

bool LaserdockDeviceManagerPrivate::initialize_usb() {
    int rc;
    rc = libusb_init(NULL/*&m_libusb_ctx*/);
    if (rc < 0)
    {
        fprintf(stderr, "Error initializing libusb: %d\n", /*libusb_error_name(rc)*/rc);
        return false;
    }

    return true;
}

bool LaserdockDeviceManagerPrivate::is_laserdock(libusb_device *device) const {
    struct libusb_device_descriptor device_descriptor;
    int result = libusb_get_device_descriptor(device, &device_descriptor);
    if (result < 0) {
        printf("Failed to get device descriptor!");
    }

    if (LASERDOCK_VIN == device_descriptor.idVendor && LASERDOCK_PIN == device_descriptor.idProduct)
        return true;

    return false;
}
