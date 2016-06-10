#include "Device_Etherdream.h"
#include "windows.h"
#include <thread>


Device_Etherdream::Device_Etherdream()
{
	ready = false;
}


Device_Etherdream::~Device_Etherdream()
{
}

int Device_Etherdream::Init()
{
	HINSTANCE etherdreamLibrary = LoadLibrary(L"Etherdream.dll");

	// Retrieve a pointer to each of the lasdac library functions,
	// and check to make sure that the pointer is valid...
	/*OpenLasdacDevice = (lasdacFuncPtr0)GetProcAddress(lasdacLibrary, "open_device");
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
	}*/

	ready = true;

	return 1;
}