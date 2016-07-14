//some code borrowed from LFI player https://sourceforge.net/projects/lfiplayer3d/

#include "Device_RIYA.h"
#include <windows.h>
#include <thread>
#include <string>

Device_RIYA::Device_RIYA()
{
	pointPeriod = 10000;
	ready = false;
}

Device_RIYA::~Device_RIYA()
{
	CloseAll();
}

int Device_RIYA::Init()
{
	CloseAll();

	riyaLibrary = LoadLibrary(L"RiyaNetServer.dll");
	if (riyaLibrary == NULL) return -2;

	// Retrieve a pointer to each of the RIYA library functions,
	// and check to make sure that the pointer is valid...
	OpenAllRiyaDevices = (riyaFuncPtr1)GetProcAddress(riyaLibrary, "RiOpenDevices");
	if (!OpenAllRiyaDevices)
	{
		FreeLibrary(riyaLibrary);
		return -1;
	}

	CloseAllRiyaDevices = (riyaFuncPtr2)GetProcAddress(riyaLibrary, "RiCloseDevices");
	if (CloseAllRiyaDevices == NULL)
	{
		FreeLibrary(riyaLibrary);
		return -1;
	}

	InitRiyaDevice = (riyaFuncPtr3)GetProcAddress(riyaLibrary, "Ri_InitChanal");
	if (InitRiyaDevice == NULL)
	{
		FreeLibrary(riyaLibrary);
		return -1;
	}

	RiyaReadyForNextFrame = (riyaFuncPtr4)GetProcAddress(riyaLibrary, "Ri_SetIntCh");
	if (RiyaReadyForNextFrame == NULL)
	{
		FreeLibrary(riyaLibrary);
		return 0;
	}

	StopRiyaDevice = (riyaFuncPtr4)GetProcAddress(riyaLibrary, "RiStopShow");
	if (StopRiyaDevice == NULL)
	{
		FreeLibrary(riyaLibrary);
		return -1;
	}

	TransferFrameToBuffer = (riyaFuncPtr5)GetProcAddress(riyaLibrary, "RiSetShowCadr");
	if (TransferFrameToBuffer == NULL)
	{
		FreeLibrary(riyaLibrary);
		return -1;
	}

	GetIDVersionNumber = (riyaFuncPtr6)GetProcAddress(riyaLibrary, "GetVersionID");
	if (GetIDVersionNumber == NULL)
	{
		FreeLibrary(riyaLibrary);
		return -1;
	}

	uint8_t riyaDevicesNumTotal = OpenAllRiyaDevices();
	//logFile << "Device_RIYA::Open() - Device count = " << (M_uint16_t)riyaDevicesNum << endl;

	if (riyaDevicesNumTotal == 0)
	{
		CloseAllRiyaDevices();
		FreeLibrary(riyaLibrary);
		return 0;
	}

	if (riyaDevicesNumTotal == 255)
	{
		CloseAllRiyaDevices();
		FreeLibrary(riyaLibrary);
		return -2;
	}

	ready = true;
	return riyaDevicesNumTotal;
}

bool Device_RIYA::OpenDevice(int cardNum)
{
	if (!ready) return false;

	InitRiyaDevice((uint8_t)cardNum, RIYA_DEVICE_ATTRIBUTES);

	pointPeriod = (UINT)(1.0 / 20000.0 * 33333333.3);

	Riya_Point blankPoint[1] = { 0x800, 0x800, 0, 0, 0, 0 };
	TransferFrameToBuffer((uint8_t)cardNum, (uint8_t*)&blankPoint, 1, pointPeriod, RIYA_FRAME_ATTRIBUTES_NOSYNC);

	frameNum[cardNum] = 0;

	return true;
}


bool Device_RIYA::OutputFrame(int cardNum, int scanRate, int bufferSize, uint8_t* bufferAddress)
{
	if (!ready) return false;
	
	pointPeriod = (UINT)(1.0 / (double)scanRate * 33333333.3);

	int thisFrameNum = ++frameNum[cardNum];

	for (int i = 0; i < 16; i++)
	{
		if (frameNum[cardNum] > thisFrameNum) //if newer frame is waiting to be transfered, cancel this one
			break;
		else if (RiyaReadyForNextFrame((uint8_t)cardNum))
		{
			return (TransferFrameToBuffer((uint8_t)cardNum, (uint8_t*)bufferAddress, (UINT)bufferSize, pointPeriod, RIYA_FRAME_ATTRIBUTES_SYNC) == 0);
		}
	}

	return false;
}

bool Device_RIYA::Stop(int cardNum)
{
	if (!ready) return false;

	StopRiyaDevice((uint8_t)cardNum);

	return true;
}

bool Device_RIYA::CloseAll()
{
	if (!ready) return false;

	CloseAllRiyaDevices();
	FreeLibrary(riyaLibrary);
	ready = false;

	return true;
}

void Device_RIYA::GetName(int cardNum, char* name)
{
	if (!ready) name = "RIYA";

	char riya[16] = "RIYA ";
	char id[8];
	_itoa_s(GetIDVersionNumber(cardNum), id, 10);

	strcat_s(riya, id);
	strcpy_s(name, 64, riya);
}