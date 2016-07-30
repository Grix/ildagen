#include "Device_OLSC.h"


Device_OLSC::Device_OLSC()
{
	ready = false;
}


Device_OLSC::~Device_OLSC()
{
	CloseAll();
}

int Device_OLSC::Init()
{
	CloseAll();

	OLSCLibrary = LoadLibrary(L"OLSC.dll");
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

	OLSC_WriteFrameEx = (OLSCFuncPtr3)GetProcAddress(OLSCLibrary, "OLSC_WriteFrameEx");
	if (!OLSC_WriteFrameEx)
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

bool Device_OLSC::OutputFrame(int cardNum, int scanRate, int bufferSize, OLSC_Point* bufferAddress)
{
	if (!ready)
		return false;

	int thisFrameNum = ++frameNum[cardNum];

	for (int i = 0; i < 16; i++)
	{
		if (frameNum[cardNum] > thisFrameNum) //if newer frame is waiting to be transfered, cancel this one
			break;
		else
		{
			DWORD status;
			if ( (OLSC_GetStatus(cardNum, status) & 1) == 0) //if ready
			{
				return (OLSC_WriteFrameEx(cardNum, scanRate, bufferSize, bufferAddress) == 1);
			}
		}
	}

	return false;
}

bool Device_OLSC::OpenDevice(int cardNum)
{
	if (!ready)
		return false;

	//no individual open device functions for OLSC

	return true; 
}

bool Device_OLSC::Stop(int cardNum)
{
	if (!ready)
		return false;

	return (OLSC_Pause(cardNum) == 1);
}

bool Device_OLSC::CloseAll()
{
	if (!ready)
		return false;

	OLSC_Shutdown();
	FreeLibrary(OLSCLibrary);
	ready = false;

	return true;
}

void Device_OLSC::GetName(int cardNum, char* name)
{
	if (!ready) name = "OLSC";

	OLSC_GetInterfaceName(name+2);
	name[0] = (char)(cardNum + 48); //ascii numbers start at 48
	name[1] = ' ';
	name[63] = '\0';
}
