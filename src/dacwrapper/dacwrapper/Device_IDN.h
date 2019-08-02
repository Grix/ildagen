#pragma once

#include "idn.h"
#include <mutex>
#include <vector>

#include <stdio.h>
#include <stdarg.h>
#include <stdint.h>
#include <time.h>

class Device_IDN
{
public:

	Device_IDN();
	~Device_IDN();

	// point data structure
	typedef struct
	{
		std::uint16_t x; //16 bit
		std::uint16_t y; //16 bit
		std::uint8_t r;	//8 bit	(from 0 to 0xFF)
		std::uint8_t g;	//8 bit (from 0 to 0xFF)
		std::uint8_t b;	//8 bit (from 0 to 0xFF)
		std::uint8_t i;	//8 bit (from 0 to 0xFF)
	} IdnPoint;

	int Init();
	bool OutputFrame(int cardNum, int rate, int frameSize, IdnPoint* bufferAddress);
	bool OpenDevice(int cardNum);
	bool Stop(int cardNum);
	bool CloseAll();
	bool GetName(int cardNum, char* name);
	bool SetName(int cardNum, char* name);
	double GetFirmwareVersion(int cardNum);

private:

	IDNCONTEXT* contexts[16];
	in_addr_t helloServerAddr = 0;

	bool ready;
	int frameNum[16];
	std::mutex frameLock[16];
};

