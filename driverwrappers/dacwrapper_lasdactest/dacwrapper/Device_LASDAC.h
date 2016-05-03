#pragma once

#include "windows.h"

class Device_LASDAC
{
public:

	struct Point
	{
		UINT16 X;
		UINT16 Y;
		UINT8  R;
		UINT8  G;
		UINT8  B;
		UINT8  I;
	};

	Device_LASDAC();
	~Device_LASDAC();

	int Init();
	int OutputFrame(UINT8 flags, UINT16 speed, UINT16 num, UINT8* buffer);

private:

	// function pointer for library routine open_device
	typedef int(*lasdacFuncPtr0)();

	// function pointer for library routine send_frame
	typedef int(*lasdacFuncPtr1)(UINT8, UINT16, UINT16, Point*);

	lasdacFuncPtr0 OpenLasdacDevice;
	lasdacFuncPtr1 SendLasdacFrame;
	lasdacFuncPtr0 CloseLasdacDevice;

	bool ready;

	void OutputFrameThreaded(UINT8 flags, UINT16 speed, UINT16 num, Point* buffer);
};

