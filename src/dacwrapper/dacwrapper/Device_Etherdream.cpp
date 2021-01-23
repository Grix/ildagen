#include "Device_Etherdream.h"



Device_Etherdream::Device_Etherdream()
{
	ready = false;
	for (int i = 0; i < 16; i++)
		stopped[i] = true;
}


Device_Etherdream::~Device_Etherdream()
{
	CloseAll();
}

int Device_Etherdream::Init()
{
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
	bool result = EtherDreamOpenDevice(&cardNum);
	if (result)
		stopped[cardNum] = false;

	return result;
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
	ready = false;

	return true;
}

bool Device_Etherdream::Stop(int cardNum)
{
	if (!ready) return false;

	//bool result = EtherDreamStop(&cardNum);
	//if (result)
	//	stopped[cardNum] = true;

	EAD_Pnt_s blankPoints[100];

	for (int i = 0; i < 100; i++)
	{
		blankPoints[i].X = 0;
		blankPoints[i].Y = 0;
		blankPoints[i].R = 0;
		blankPoints[i].G = 0;
		blankPoints[i].B = 0;
		blankPoints[i].I = 0;
		blankPoints[i].AR = 0;
		blankPoints[i].AL = 0;
	}
	OutputFrame(cardNum, blankPoints, 100 * sizeof(Device_Etherdream::EAD_Pnt_s), 10000);

	return true;
}

bool Device_Etherdream::OutputFrame(int cardNum, const EAD_Pnt_s* data, int Bytes, uint16_t PPS)
{
	if (!ready) return false;

	//if (stopped[cardNum])
	//	OpenDevice(cardNum);

	int thisFrameNum = ++frameNum[cardNum];

	std::lock_guard<std::mutex> lock(frameLock[cardNum]);

	for (int i = 0; i < 1000; i++)
	{
		if (frameNum[cardNum] > thisFrameNum) //if newer frame is waiting to be transfered, cancel this one
			break;
		else if (EtherDreamGetStatus(&cardNum) == 1)
		{
			return EtherDreamWriteFrame(&cardNum, data, Bytes, PPS, -1);
		}
		std::this_thread::sleep_for(std::chrono::microseconds(100));
	}

	return false;
}

void Device_Etherdream::GetName(int cardNum, char* name)
{
	if (!ready)
		sprintf_s(name, 12, "Etherdream");

	EtherDreamGetDeviceName(&cardNum, name, 64);
}