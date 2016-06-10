#pragma once

#include "windows.h"

class Device_LASDAC
{
public:

	Device_LASDAC();
	~Device_LASDAC();

	int Init();
	int OutputFrame(UINT8 flags, UINT16 speed, UINT16 num, UINT8* buffer);

private:

	// function pointer for library routine open_device
	typedef int(*lasdacFuncPtr0)();

	// function pointer for library routine send_frame
	typedef int(*lasdacFuncPtr1)(UINT8, UINT16, UINT16, UINT8*);

	lasdacFuncPtr0 OpenLasdacDevice;
	lasdacFuncPtr1 SendLasdacFrame;
	lasdacFuncPtr0 CloseLasdacDevice;

	bool ready;

	void OutputFrameThreaded(UINT8 flags, UINT16 speed, UINT16 num, UINT8* buffer);
};

