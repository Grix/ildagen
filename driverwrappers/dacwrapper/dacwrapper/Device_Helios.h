#pragma once

#include "HeliosDacClass.h"
#include <stdint.h>

class Device_Helios
{
public:

	Device_Helios();
	~Device_Helios();

	int Init();
	bool OutputFrame(int cardNum, int rate, int frameSize, HeliosDacClass::HeliosPoint* bufferAddress);
	bool OpenDevice(int cardNum);
	bool Stop(int cardNum);
	bool CloseAll();
	bool GetName(int cardNum, char* name);
	bool SetName(int cardNum, char* name);
	double GetFirmwareVersion(int cardNum);

private:

	HeliosDacClass* heliosDevice;

	bool ready;
	int frameNum[16];
};

