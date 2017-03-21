#pragma once

#include "HeliosDac.h"

class Device_Helios
{
public:

	Device_Helios();
	~Device_Helios();

	int Init();
	bool OutputFrame(int cardNum, int rate, int frameSize, HeliosPoint* bufferAddress);
	bool OpenDevice(int cardNum);
	bool Stop(int cardNum);
	bool CloseAll();
	bool GetName(int cardNum, char* name);
	bool SetName(int cardNum, char* name);
	double GetFirmwareVersion(int cardNum);

private:

	HeliosDac* heliosDevice;

	bool ready;
	int frameNum[16];
};

