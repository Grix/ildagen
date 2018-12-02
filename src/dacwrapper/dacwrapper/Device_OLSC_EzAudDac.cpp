#include "Device_OLSC_EzAudDac.h"


Device_OLSC_EzAudDac::Device_OLSC_EzAudDac()
{
	ready = false;
}


Device_OLSC_EzAudDac::~Device_OLSC_EzAudDac()
{
	CloseAll();
}

int Device_OLSC_EzAudDac::Init()
{
	CloseAll();

	OLSCLibrary = LoadLibrary(L"OLSC_EzAudDac.dll");
	if (OLSCLibrary == NULL) return -2;

	OLSC_Initialize = (OLSCFuncPtr1)GetProcAddress(OLSCLibrary, "OLSC_Initialize");
	if (!OLSC_Initialize)
	{
		FreeLibrary(OLSCLibrary);
		return -1;
	}

	OLSC_Shutdown = (OLSCFuncPtr1)GetProcAddress(OLSCLibrary, "OLSC_Shutdown");
	if (!OLSC_Shutdown)
	{
		FreeLibrary(OLSCLibrary);
		return -1;
	}

	OLSC_GetStatus = (OLSCFuncPtr4)GetProcAddress(OLSCLibrary, "OLSC_GetStatus");
	if (!OLSC_GetStatus)
	{
		FreeLibrary(OLSCLibrary);
		return -1;
	}

	OLSC_GetInterfaceName = (OLSCFuncPtr0)GetProcAddress(OLSCLibrary, "OLSC_GetInterfaceName");
	if (!OLSC_GetInterfaceName)
	{
		FreeLibrary(OLSCLibrary);
		return -1;
	}

	OLSC_Pause = (OLSCFuncPtr2)GetProcAddress(OLSCLibrary, "OLSC_Pause");
	if (!OLSC_Pause)
	{
		FreeLibrary(OLSCLibrary);
		return -1;
	}

	OLSC_WriteFrame = (OLSCFuncPtr3)GetProcAddress(OLSCLibrary, "OLSC_WriteFrame");
	if (!OLSC_WriteFrame)
	{
		FreeLibrary(OLSCLibrary);
		return -1;
	}
	
	int openResult = OLSC_Initialize();
	if (openResult <= 0)
	{
		OLSC_Shutdown();
		FreeLibrary(OLSCLibrary);
		return openResult;
	}

	ready = true;
	return openResult;
}

bool Device_OLSC_EzAudDac::OutputFrame(int cardNum, int scanRate, int bufferSize, OLSC_Point* bufferAddress)
{
	if (!ready)
		return false;

	int thisFrameNum = ++frameNum[cardNum];

	std::lock_guard<std::mutex> lock(frameLock[cardNum]);

	for (int i = 0; i < 1000; i++)
	{
		if (frameNum[cardNum] > thisFrameNum) //if newer frame is waiting to be transfered, cancel this one
			break;
		else
		{
			DWORD status;
			if ((OLSC_GetStatus(cardNum, status)) == 1)
			{
				if ((status & 1) != 0) //if ready
					continue;

				OLSC_Frame frame;
				frame.display_speed = scanRate;
				frame.point_count = bufferSize;
				frame.points = bufferAddress;
				return (OLSC_WriteFrame(cardNum, frame) == 1);
			}
		}
		std::this_thread::sleep_for(std::chrono::microseconds(100));
	}

	return false;
}

bool Device_OLSC_EzAudDac::OpenDevice(int cardNum)
{
	if (!ready)
		return false;

	//no individual open device functions for OLSC

	return true;
}

bool Device_OLSC_EzAudDac::Stop(int cardNum)
{
	if (!ready)
		return false;

	OLSC_Point stopBuffer[16000];
	for (int i = 0; i < 16000; i++)
	{
		stopBuffer[i].x = 0;
		stopBuffer[i].y = 0;
		stopBuffer[i].r = 0;
		stopBuffer[i].g = 0;
		stopBuffer[i].b = 0;
		stopBuffer[i].i = 0;
	}
	OutputFrame(cardNum, 16384, 16000, &stopBuffer[0]);
	std::this_thread::sleep_for(std::chrono::seconds(1));
	OutputFrame(cardNum, 16384, 16000, &stopBuffer[0]);
	std::this_thread::sleep_for(std::chrono::seconds(1));
	OutputFrame(cardNum, 16384, 16000, &stopBuffer[0]);
	std::this_thread::sleep_for(std::chrono::seconds(1));
	OutputFrame(cardNum, 16384, 16000, &stopBuffer[0]);
	std::this_thread::sleep_for(std::chrono::seconds(1));
	OutputFrame(cardNum, 16384, 16000, &stopBuffer[0]);


	return 1;
	//return (OLSC_Pause(cardNum) == 1);
}

bool Device_OLSC_EzAudDac::CloseAll()
{
	if (!ready)
		return false;

	OLSC_Shutdown();
	FreeLibrary(OLSCLibrary);
	ready = false;

	return true;
}

void Device_OLSC_EzAudDac::GetName(int cardNum, char* name)
{
	if (!ready) name = "EzAudDac";

	OLSC_GetInterfaceName(name + 2);
	name[0] = (char)(cardNum + 48); //ascii numbers start at 48
	name[1] = ' ';
	name[63] = '\0';
}
