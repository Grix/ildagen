//
// Created by Guoping Huang on 9/6/16.
//

#ifndef PROJECTTESTUTILITIES_LASERDOCKDEVICEMANAGER_H
#define PROJECTTESTUTILITIES_LASERDOCKDEVICEMANAGER_H


class LaserdockDeviceManagerPrivate;
class LaserdockDevice;

class LaserdockDeviceManager
{
public:
	static LaserdockDeviceManager& getInstance()
	{
		static LaserdockDeviceManager    instance;
		return instance;
	}

	void list_laserdock_devices();
	LaserdockDevice * get_next_available_device();

private:
	LaserdockDeviceManager();
	LaserdockDeviceManager(LaserdockDeviceManager const&);
	void operator=(LaserdockDeviceManager const&); 
	~LaserdockDeviceManager();

private:
    LaserdockDeviceManagerPrivate * d;

};


#endif //PROJECTTESTUTILITIES_LASERDOCKDEVICEMANAGER_H
