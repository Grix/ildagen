//some code borrowed from LFI player https://sourceforge.net/projects/lfiplayer3d/

#include "Device_RIYA.h"
#include "windows.h"
#include <thread>

Device_RIYA::Device_RIYA()
{
	pointPeriod = 10000;
	ready = false;
}

Device_RIYA::~Device_RIYA()
{
	if (ready)
	{
		CloseAllRiyaDevices();
		FreeLibrary(riyaLibrary);
	}
}

int Device_RIYA::Init()
{
	riyaLibrary = LoadLibrary(L"RiyaNetServer.dll");
	if (riyaLibrary == NULL) return -1;

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
		return -1;
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

	UINT8 riyaDevicesNumTotal = OpenAllRiyaDevices();
	//logFile << "Device_RIYA::Open() - Device count = " << (M_UINT16)riyaDevicesNum << endl;

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

	InitRiyaDevice((UINT8)cardNum, RIYA_DEVICE_ATTRIBUTES);

	return true;
}


bool Device_RIYA::OutputFrame(int cardNum, int scanRate, int bufferSize, UINT8* bufferAddress)
{
	if (!ready) return false;
	
	while (RiyaReadyForNextFrame((UINT8)cardNum) == 0);

	pointPeriod = (UINT)(1.0 / (double)scanRate * 33333333.3);

	TransferFrameToBuffer(	(UINT8)cardNum,
							(UINT8*)bufferAddress,
							(UINT)bufferSize,
							pointPeriod,
							RIYA_FRAME_ATTRIBUTES_SYNC);

	return true;
}

bool Device_RIYA::Stop(int cardNum)
{
	if (!ready) return false;

	StopRiyaDevice((UINT8)cardNum);

	return true;
}

bool Device_RIYA::CloseAll()
{
	if (!ready) return false;

	CloseAllRiyaDevices();
	FreeLibrary(riyaLibrary);

	return true;
}