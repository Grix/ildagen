#include "Device_Etherdream.h"
#include "windows.h"
#include <thread>


Device_Etherdream::Device_Etherdream()
{
	ready = false;
}


Device_Etherdream::~Device_Etherdream()
{
	if (ready)
	{
		CloseAll();
	}
}

int Device_Etherdream::Init()
{
	etherdreamLibrary = LoadLibrary(L"Etherdream.dll");

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

	int openResult = EtherDreamGetCardNum();
	if (openResult <= 0)
	{
		EtherDreamClose();
		FreeLibrary(etherdreamLibrary);
		return (-2);
	}

	ready = true;

	return openResult;
}

bool Device_Etherdream::OpenDevice(int cardNum)
{
	if (!ready) return false;

	const int cardNumConst = cardNum;
	return EtherDreamOpenDevice(&cardNumConst);
}

bool Device_Etherdream::CloseDevice(int cardNum)
{
	if (!ready) return false;

	const int cardNumConst = cardNum;
	return EtherDreamCloseDevice(&cardNumConst);
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

	const int cardNumConst = cardNum;
	return EtherDreamStop(&cardNumConst);
}

int Device_Etherdream::OutputFrame(int cardNum, const EAD_Pnt_s* data, int Bytes, UINT16 PPS)
{
	if (!ready) return -1;

	const int cardNumConst = cardNum;
	return (int)EtherDreamWriteFrame(&cardNumConst, data, Bytes, PPS, -1);
}