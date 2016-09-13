#include "Device_LaserDock.h"


Device_LaserDock::Device_LaserDock()
{
	ready = false;
}


Device_LaserDock::~Device_LaserDock()
{
	CloseAll();
}


int Device_LaserDock::Init()
{
	CloseAll();

	laserDockLibrary = LoadLibrary(L"laserdocklib.dll");
	if (laserDockLibrary == NULL) return -2;

	_initialize = (laserDockFuncPtr0)GetProcAddress(laserDockLibrary, "initialize");
	if (!_initialize)
	{
		FreeLibrary(laserDockLibrary);
		return -1;
	}

	_stop = (laserDockFuncPtr0)GetProcAddress(laserDockLibrary, "stop");
	if (!_stop)
	{
		FreeLibrary(laserDockLibrary);
		return -1;
	}

	_free = (laserDockFuncPtr0)GetProcAddress(laserDockLibrary, "freeAll");
	if (!_free)
	{
		FreeLibrary(laserDockLibrary);
		return -1;
	}

	_sendFrame = (laserDockFuncPtr1)GetProcAddress(laserDockLibrary, "sendFrame");
	if (!_sendFrame)
	{
		FreeLibrary(laserDockLibrary);
		return -1;
	}

	ready = true;
	int result = _initialize();

	if (result <= 0)
		CloseAll();

	return result;
}

bool Device_LaserDock::OutputFrame(int rate, int frameSize, LaserDockPoint* bufferAddress)
{
	if (!ready) return false;

	int thisFrameNum = ++frameNum;

	for (int i = 0; i < 16; i++)
	{
		if (frameNum > thisFrameNum) //if newer frame is waiting to be transfered, cancel this one
			break;
		else if (_sendFrame((uint8_t*)bufferAddress, frameSize, rate))
		{
			return true;
		}
	}

	return false;
}

bool Device_LaserDock::OpenDevice()
{
	if (!ready) return false;
	
	return true; //don't need to to anything
}

bool Device_LaserDock::Stop()
{
	if (!ready) return false;

	return _stop();
}

bool Device_LaserDock::CloseAll()
{
	if (!ready) return false;

	_free();
	FreeLibrary(laserDockLibrary);
	ready = false;
	return true;
}

void Device_LaserDock::GetName(char* name)
{
	memcpy(name, "LaserDock", 10);
}
