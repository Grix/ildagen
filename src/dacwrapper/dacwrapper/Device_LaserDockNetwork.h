#pragma once

#include "LaserCubeNetwork.h"
#include <thread>
#include <chrono>
#include <mutex>
#include <string.h>

#define LASERDOCK_MAX_DEVICES 8

class Device_LaserDockNetwork
{
public:

	Device_LaserDockNetwork();
	~Device_LaserDockNetwork();

	typedef struct
	{
		uint16_t rg;	//lower byte is red, top byte is green
		uint16_t b;		//lower byte is blue
		uint16_t x;		//12bit?
		uint16_t y;		//12bit?
	} LaserDockPoint;

	int Init();
	bool OutputFrame(int devNum, int rate, int frameSize, LaserDockPoint* bufferAddress);
	bool OpenDevice(int cardNum);
	bool Stop(int devNum);
	bool CloseAll();
	void GetName(int devNum, char* name);

private:

	//std::vector<ldNetworkHardware*> laserdockDevices;
	//ldNetworkHardwareManager* laserdockDeviceManager;
	LaserCubeNetwork deviceController;
	bool inited;
	int previousRate[LASERDOCK_MAX_DEVICES];
	bool outputEnabled[LASERDOCK_MAX_DEVICES];

	//opens connection, call before any other function
	int _Initialize();

	//send frame to dac (updating rate etc is handled in the function). 
	//Data buffer struct can be found in LaserdockDevice.h.
	//Length is number of points
	//Rate is points per second
	bool _SendFrame(int devNum, LaserdockSample* data, uint32_t length, uint32_t rate);

	//stop output until sendFrame is called again
	bool _Stop(int devNum);

	//close connection and free resources
	bool _FreeAll();

	bool ready;
	int frameNum[LASERDOCK_MAX_DEVICES];
	std::mutex frameLock[LASERDOCK_MAX_DEVICES];
};

