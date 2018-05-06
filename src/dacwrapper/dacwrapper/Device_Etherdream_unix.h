#pragma once

#include "etherdream.h"
#include <stdint.h>
#include <thread>
#include <chrono>
#include <mutex>

class Device_Etherdream
{
public:
	Device_Etherdream();
	~Device_Etherdream();

	int Init();
	bool OpenDevice(int cardNum);
	bool CloseDevice(int cardNum);
	bool Stop(int cardNum);
	bool CloseAll();
	bool OutputFrame(int cardNum, const etherdream_point* data, int numPoints, uint16_t PPS);
	void GetName(int cardNum, char* name);

private:

	bool ready;
	int frameNum[16];
	std::mutex frameLock[16];
};

