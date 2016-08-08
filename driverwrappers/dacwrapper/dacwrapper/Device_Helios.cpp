#include "Device_Helios.h"


Device_Helios::Device_Helios()
{
	ready = false;
}


Device_Helios::~Device_Helios()
{
	CloseAll();
}

int Device_Helios::Init()
{
	CloseAll();

	heliosLibrary = LoadLibrary(L"HeliosLaserDAC.dll");
	if (heliosLibrary == NULL) return -2;

	_OpenDevices = (heliosFuncPtr0)GetProcAddress(heliosLibrary, "OpenDevices");
	if (!_OpenDevices)
	{
		FreeLibrary(heliosLibrary);
		return -1;
	}

	_CloseDevices = (heliosFuncPtr0)GetProcAddress(heliosLibrary, "CloseDevices");
	if (!_CloseDevices)
	{
		FreeLibrary(heliosLibrary);
		return -1;
	}

	_GetStatus = (heliosFuncPtr1)GetProcAddress(heliosLibrary, "GetStatus");
	if (!_GetStatus)
	{
		FreeLibrary(heliosLibrary);
		return -1;
	}

	_WriteFrame = (heliosFuncPtr2)GetProcAddress(heliosLibrary, "WriteFrame");
	if (!_WriteFrame)
	{
		FreeLibrary(heliosLibrary);
		return -1;
	}

	_SetShutter = (heliosFuncPtr3)GetProcAddress(heliosLibrary, "SetShutter");
	if (!_SetShutter)
	{
		FreeLibrary(heliosLibrary);
		return -1;
	}

	_GetName = (heliosFuncPtr4)GetProcAddress(heliosLibrary, "GetName");
	if (!_GetName)
	{
		FreeLibrary(heliosLibrary);
		return -1;
	}

	_Stop = (heliosFuncPtr1)GetProcAddress(heliosLibrary, "Stop");
	if (!_Stop)
	{
		FreeLibrary(heliosLibrary);
		return -1;
	}
	
	ready = true;
	int result = _OpenDevices();

	if (result <= 0)
		CloseAll();

	return result;
}

bool Device_Helios::OutputFrame(int cardNum, int rate, int frameSize, HeliosPoint* bufferAddress)
{
	if (!ready) return false;

	int thisFrameNum = ++frameNum[cardNum];

	//lock frame buffer
	//std::lock_guard<std::mutex> lock(frameMutex[dacNum]);

	for (int i = 0; i < 16; i++)
	{
		if (frameNum[cardNum] > thisFrameNum) //if newer frame is waiting to be transfered, cancel this one
			break;
		else if (_GetStatus(cardNum) == 1)
		{
			return (_WriteFrame(cardNum, rate, 0, bufferAddress, frameSize) == 1);
		}
	}

	return false;
}

bool Device_Helios::OpenDevice(int cardNum)
{
	//init already opened all devices
	return true;
}

bool Device_Helios::Stop(int cardNum)
{
	if (!ready) return false;

	return (_Stop(cardNum) == 1);

	return true;
}

bool Device_Helios::CloseAll()
{
	if (!ready)
		return false;

	_CloseDevices();
	FreeLibrary(heliosLibrary);
	ready = false;
	return true;
}

void Device_Helios::GetName(int cardNum, char* name)
{
	_GetName(cardNum, name);
}