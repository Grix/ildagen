#pragma once
// LaserCube Network C++ API by Gitle Mikkelsen.
// Thanks to Sidney San Martín for python API https://gist.github.com/s4y/0675595c2ff5734e927d68caf652e3af
// and Dirk Apitz for socket library https://github.com/DexLogic/idn-C-helloScan/tree/master/src


#include <stdio.h>
#include <vector>
#include <thread>
#include <algorithm>
#include "LaserdockDevice.h"

#if defined(_WIN32) || defined(WIN32)
#include "plt-windows.h"
#else
#include <stdlib.h>
#include <ifaddrs.h>
#include "plt-posix.h"
#include <netdb.h>
#endif

#define LDN_ALIVE_PORT 45456
#define LDN_CMD_PORT 45457
#define LDN_DATA_PORT 45458
#define LDN_CMD_GET_FULL_INFO 0x77
#define LDN_CMD_ENABLE_BUFFER_SIZE_RESPONSE_ON_DATA 0x78
#define LDN_CMD_SET_OUTPUT 0x80
#define LDN_CMD_GET_RINGBUFFER_EMPTY_SAMPLE_COUNT 0x8a
#define LDN_CMD_SAMPLE_DATA 0xa9
#define LDN_CMD_SET_RATE

class LaserCubeNetwork
{
public:

	struct LaserCubeNetworkSample
	{
		uint16_t x; // each 12bit
		uint16_t y;
		uint16_t r;
		uint16_t g;
		uint16_t b;
	};

	LaserCubeNetwork();
	int FindDevices();
	bool OpenDevice(unsigned int deviceNum);
	bool SendCommand(unsigned int deviceNum, unsigned char command, unsigned char data);
	bool SendData(unsigned int deviceNum, LaserCubeNetworkSample* data, size_t count);
	bool StopOutput(unsigned int deviceNum);
	bool Close(unsigned int deviceNum);


private:
	class LaserCubeNetworkDevice
	{
	public:
		LaserCubeNetworkDevice(unsigned long ipAddress);
		bool OpenDevice();
		bool SendCommand(unsigned char command, char* data, int dataLength = 1);
		bool SendData(LaserCubeNetworkSample* data, size_t count);
		bool StopOutput();
		bool Close();

	private:
		void ReceiveResponseHandler();
		void FrameHandler();

		sockaddr_in cmdSocketAddr;
		sockaddr_in dataSocketAddr;
		int cmdSocketFd;
		int dataSocketFd;
		int dataLeft = 0;
		LaserCubeNetworkSample frameBuffer[10000];
		int messageNumber = 0;
		int totalFrameSize = 0;
		int frameNumber = 0;
		bool outputEnabled = false;
	};

	bool FindDevicesOnInterface(const char* ifName, uint32_t adapterIpAddr);

	sockaddr_in pingSocketAddr;
	int pingSocketFd;
	std::vector<std::unique_ptr<LaserCubeNetworkDevice>> devices;
	bool inited = false;
};

