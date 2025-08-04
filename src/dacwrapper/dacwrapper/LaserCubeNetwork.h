#pragma once
// LaserCube Network C++ API by Gitle Mikkelsen.
// Thanks to Sidney San Martín for python API https://gist.github.com/s4y/0675595c2ff5734e927d68caf652e3af
// and Dirk Apitz for socket library https://github.com/DexLogic/idn-C-helloScan/tree/master/src


#include <stdio.h>
#include <vector>
#include <thread>
#include <algorithm>
#include <mutex>
#include <queue>
#include <iostream>
#include <fstream>
#include <cstring>
#include <chrono>

#if defined(_WIN32) || defined(WIN32)
#include "plt-windows.h"
#else
#include <stdlib.h>
#include <ifaddrs.h>
#include "plt-posix.h"
#include <netdb.h>
#endif

//#define LDN_LOG

#define LDN_ALIVE_PORT 45456
#define LDN_CMD_PORT 45457
#define LDN_DATA_PORT 45458
#define LDN_CMD_GET_FULL_INFO 0x77
#define LDN_CMD_ENABLE_BUFFER_SIZE_RESPONSE_ON_DATA 0x78
#define LDN_CMD_SET_OUTPUT 0x80
#define LDN_CMD_GET_RINGBUFFER_EMPTY_SAMPLE_COUNT 0x8A
#define LDN_CMD_SAMPLE_DATA 0xA9
#define LDN_CMD_SET_RATE 0x82
#define LDN_CMD_CLEAR_RINGBUFFER 0x8D

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
	int FindDevices(FILE* _logFile);
	bool OpenDevice(unsigned int deviceNum);
	//bool SendCommand(unsigned int deviceNum, unsigned char command, unsigned char data);
	bool GetStatus(unsigned int deviceNum, unsigned int requiredFreeBufferSpace);
	bool SendData(unsigned int deviceNum, LaserCubeNetworkSample* data, size_t count, int rate);
	bool StopOutput(unsigned int deviceNum);
	char* GetSerialNumber(unsigned int deviceNum);
	//bool Close(unsigned int deviceNum);


private:

	struct FrameInfo
	{
		LaserCubeNetwork::LaserCubeNetworkSample dataBuffer[5000];
		int rate;
		int numPoints;
	};

#ifdef LDN_LOG
	FILE* logFile;
#endif

	class LaserCubeNetworkDevice
	{
	public:
		LaserCubeNetworkDevice(unsigned long ipAddress, char* infoPacketBuffer);
		~LaserCubeNetworkDevice();
		bool OpenDevice();
		bool SendCommand(unsigned char command, char* data, int dataLength = 1);
		bool GetStatus(unsigned int requiredFreeBufferSpace);
		bool SendData(LaserCubeNetwork::LaserCubeNetworkSample* data, size_t count, int rate);
		bool StopOutput();
		//bool Close();

		char serialNumber[13];

	private:
		void ReceiveUdpHandler();
		void PeriodicCommandUdpHandler();
		void FrameHandler();
		void LogHandler();
		void WarmupHandler();

		sockaddr_in cmdSocketAddr;
		sockaddr_in dataSocketAddr;
		int cmdSocketFd = -1;
		int dataSocketFd = -1;
		std::queue<FrameInfo*> frameQueue;
		int messageNumber = 0;
		int frameNumber = 0;
		bool outputEnabled = false;
		int currentRate = -1;
		bool stopThreads = false;
		unsigned int freeBufferSpace = 6000;
		unsigned int maxBufferSpace = 6000;
		unsigned int localBufferSize = 0;

		bool skipNextFrame = false;
		bool isStopped = true;
		bool isReplyQueueDone = true;
		/*int skipTestCounter = 0;
		int freeBufferSpaceLastFrames[100];
		bool forceSendToggle = false;
		int skipAllowedAt0 = 1;*/
		int forceSendExceptAtZero = 1;
		int skipCounter = 0;

		//bool isWarmedUp = false;
		int warmupCounter = 0;
		const int requiredWarmupPackages = 300;


		std::mutex frameLock;
		std::chrono::system_clock::time_point previousBufferSpaceTime;
		std::chrono::microseconds limitLeeway;
		std::chrono::system_clock::time_point previousLeewayRefreshTime;

		const int commandRepeatCount = 2;
	};


	bool FindDevicesOnInterface(const char* ifName, uint32_t adapterIpAddr, std::vector<unsigned long>* foundIps);

	sockaddr_in pingSocketAddr;
	int pingSocketFd;
	std::vector<std::unique_ptr<LaserCubeNetworkDevice>> devices;
	bool inited = false;
	bool isWaitingForReply = false;
};

