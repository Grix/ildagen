#include "Device_LASDAC.h"
#include <thread>

Device_LASDAC::Device_LASDAC()
{
	ready = false;
}


Device_LASDAC::~Device_LASDAC()
{
	if (ready)
		CloseLasdacDevice();
}

int Device_LASDAC::Init()
{
	HINSTANCE lasdacLibrary = LoadLibrary(L"LasdacDll.dll");

	// Retrieve a pointer to each of the lasdac library functions,
	// and check to make sure that the pointer is valid...
	OpenLasdacDevice = (lasdacFuncPtr0)GetProcAddress(lasdacLibrary, "open_device");
	if (!OpenLasdacDevice)
	{
		return 0;
	}

	CloseLasdacDevice = (lasdacFuncPtr0)GetProcAddress(lasdacLibrary, "close_device");
	if (!CloseLasdacDevice)
	{
		return 0;
	}

	SendLasdacFrame = (lasdacFuncPtr1)GetProcAddress(lasdacLibrary, "send_frame");
	if (!SendLasdacFrame)
	{
		return 0;
	}

	ready = true;

	return 1;
}

void Device_LASDAC::OutputFrameThreaded(UINT8 flags, UINT16 speed, UINT16 num, Point* buffer)
{
	SendLasdacFrame(flags, speed, num, buffer);
}

int Device_LASDAC::OutputFrame(UINT8 flags, UINT16 speed, UINT16 num, UINT8* buffer)
{
	if (!ready)
		return 0;

	std::thread outputThread(&Device_LASDAC::OutputFrameThreaded, this, flags,
		speed,
		num,
		(Point*)buffer);

	outputThread.detach();

	return 1;
}