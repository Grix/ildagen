#include "Device_LASDAC.h"
#include <thread>

Device_LASDAC::Device_LASDAC()
{
	ready = false;
}


Device_LASDAC::~Device_LASDAC()
{
	if (ready)
	{
		CloseLasdacDevice();
	}
}

int Device_LASDAC::Init()
{
	HINSTANCE lasdacLibrary = LoadLibrary(L"LasdacDll.dll");

	// Retrieve a pointer to each of the lasdac library functions,
	// and check to make sure that the pointer is valid...
	OpenLasdacDevice = (lasdacFuncPtr0)GetProcAddress(lasdacLibrary, "open_device");
	if (!OpenLasdacDevice)
	{
		FreeLibrary(lasdacLibrary);
		return -1;
	}

	CloseLasdacDevice = (lasdacFuncPtr0)GetProcAddress(lasdacLibrary, "close_device");
	if (!CloseLasdacDevice)
	{
		FreeLibrary(lasdacLibrary);
		return -2;
	}

	SendLasdacFrame = (lasdacFuncPtr1)GetProcAddress(lasdacLibrary, "send_frame");
	if (!SendLasdacFrame)
	{
		FreeLibrary(lasdacLibrary);
		return -3;
	}

	int openResult = OpenLasdacDevice();
	if (openResult != 0)
	{
		CloseLasdacDevice();
		FreeLibrary(lasdacLibrary);
		return (-3 + openResult);
	}

	ready = true;
	
	//Point* blankPoint = new Point[2];
	//blankPoint[0] = { 0x800, 0x800, 0, 0, 0, 0 };
	//OutputFrame(0, 10000, 1, (UINT8*)&blankPoint);

	return 1;
}

void Device_LASDAC::OutputFrameThreaded(UINT8 flags, UINT16 speed, UINT16 num, UINT8* buffer)
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
		buffer);

	outputThread.detach();

	return 1;
}