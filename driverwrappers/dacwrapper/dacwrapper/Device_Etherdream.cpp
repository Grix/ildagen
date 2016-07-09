#include "Device_Etherdream.h"
#include <windows.h>
#include <thread>


Device_Etherdream::Device_Etherdream()
{
	ready = false;
}


Device_Etherdream::~Device_Etherdream()
{
	if (ready)
		CloseAll();
}

int Device_Etherdream::Init()
{
	if (ready)
		CloseAll();

	etherdreamLibrary = LoadLibrary(L"Etherdream.dll");
	if (etherdreamLibrary == NULL) return -1;

	// Retrieve a pointer to each of the library functions, and check to make sure that the pointer is valid...

	EtherDreamGetCardNum = (etherdreamFuncPtr0)GetProcAddress(etherdreamLibrary, "EtherDreamGetCardNum");
	if (!EtherDreamGetCardNum)
	{
		FreeLibrary(etherdreamLibrary);
		return -1;
	}

	EtherDreamGetDeviceName = (etherdreamFuncPtr1)GetProcAddress(etherdreamLibrary, "EtherDreamGetDeviceName");
	if (!EtherDreamGetDeviceName)
	{
		FreeLibrary(etherdreamLibrary);
		return -1;
	}

	EtherDreamOpenDevice = (etherdreamFuncPtr2)GetProcAddress(etherdreamLibrary, "EtherDreamOpenDevice");
	if (!EtherDreamOpenDevice)
	{
		FreeLibrary(etherdreamLibrary);
		return -1;
	}

	EtherDreamStop = (etherdreamFuncPtr2)GetProcAddress(etherdreamLibrary, "EtherDreamStop");
	if (!EtherDreamStop)
	{
		FreeLibrary(etherdreamLibrary);
		return -1;
	}

	EtherDreamCloseDevice = (etherdreamFuncPtr2)GetProcAddress(etherdreamLibrary, "EtherDreamCloseDevice");
	if (!EtherDreamCloseDevice)
	{
		FreeLibrary(etherdreamLibrary);
		return -1;
	}

	EtherDreamWriteFrame = (etherdreamFuncPtr3)GetProcAddress(etherdreamLibrary, "EtherDreamWriteFrame");
	if (!EtherDreamWriteFrame)
	{
		FreeLibrary(etherdreamLibrary);
		return -1;
	}

	EtherDreamClose = (etherdreamFuncPtr4)GetProcAddress(etherdreamLibrary, "EtherDreamClose");
	if (!EtherDreamClose)
	{
		FreeLibrary(etherdreamLibrary);
		return -1;
	}

	EtherDreamGetStatus = (etherdreamFuncPtr5)GetProcAddress(etherdreamLibrary, "EtherDreamGetStatus");
	if (!EtherDreamGetStatus)
	{
		FreeLibrary(etherdreamLibrary);
		return -1;
	}

	int openResult = EtherDreamGetCardNum();
	if (openResult <= 0)
	{
		EtherDreamClose();
		FreeLibrary(etherdreamLibrary);
		return openResult;
	}

	ready = true;

	return openResult;
}

bool Device_Etherdream::OpenDevice(int cardNum)
{
	if (!ready) return false;

	frameNum[cardNum] = 0;

	return EtherDreamOpenDevice(&cardNum);
}

bool Device_Etherdream::CloseDevice(int cardNum)
{
	if (!ready) return false;

	return EtherDreamCloseDevice(&cardNum);
}

bool Device_Etherdream::CloseAll()
{
	if (!ready) return false;

	EtherDreamClose();
	FreeLibrary(etherdreamLibrary);

	return true;
}

bool Device_Etherdream::Stop(int cardNum)
{
	if (!ready) return false;

	return EtherDreamStop(&cardNum);
}

bool Device_Etherdream::OutputFrame(int cardNum, const EAD_Pnt_s* data, int Bytes, UINT16 PPS)
{
	if (!ready) return false;

	int thisFrameNum = ++frameNum[cardNum];

	for (int i = 0; i < 16; i++)
	{
		if (frameNum[cardNum] > thisFrameNum) //if newer frame is waiting to be transfered, cancel this one
			break;
		else if (EtherDreamGetStatus(&cardNum) == 1)
		{
			return EtherDreamWriteFrame(&cardNum, data, Bytes, PPS, -1);
		}
	}

	return false;
}

void Device_Etherdream::GetName(int cardNum, char* name)
{
	if (!ready) name = "Etherdream";

	EtherDreamGetDeviceName(&cardNum, name, 64);
}