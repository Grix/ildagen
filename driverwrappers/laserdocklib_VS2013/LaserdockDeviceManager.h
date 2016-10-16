//
// Created by Guoping Huang on 9/6/16.
//

#ifndef LASERDOCKLIB_LASERDOCKDEVICEMANAGER_H
#define LASERDOCKLIB_LASERDOCKDEVICEMANAGER_H

#include <memory>

class LaserdockDevice;
class LaserdockDeviceManagerPrivate;

class LaserdockDeviceManager
{
public:
	static LaserdockDeviceManager& getInstance();

	void list_laserdock_devices();
	LaserdockDevice *get_next_available_device();

private:
	explicit LaserdockDeviceManager();
	virtual ~LaserdockDeviceManager();

private:
	std::unique_ptr<LaserdockDeviceManagerPrivate> d;
};

#endif //LASERDOCKLIB_LASERDOCKDEVICEMANAGER_H
