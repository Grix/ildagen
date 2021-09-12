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

	int Init();
	bool OutputFrame(int devNum, int rate, int frameSize, LaserCubeNetwork::LaserCubeNetworkSample* bufferAddress);
	bool OpenDevice(int cardNum);
	bool Stop(int devNum);
	bool CloseAll();
	void GetName(int devNum, char* name);

private:

	LaserCubeNetwork deviceController;
	bool inited = false;
	int previousRate[LASERDOCK_MAX_DEVICES];
	bool outputEnabled[LASERDOCK_MAX_DEVICES];

	FILE* logFile = 0;

	//opens connection, call before any other function
	int _Initialize();

	//send frame to dac (updating rate etc is handled in the function). 
	//Data buffer struct can be found in LaserdockDevice.h.
	//Length is number of points
	//Rate is points per second
	bool _SendFrame(int devNum, LaserCubeNetwork::LaserCubeNetworkSample* data, uint32_t length, uint32_t rate);

	//stop output until sendFrame is called again
	bool _Stop(int devNum);

	//close connection and free resources
	bool _FreeAll();

	bool ready;
	int frameNum[LASERDOCK_MAX_DEVICES];
	std::mutex frameLock[LASERDOCK_MAX_DEVICES];
};

