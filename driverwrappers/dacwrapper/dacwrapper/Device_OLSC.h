#pragma once

#include <Windows.h>

class Device_OLSC
{
public:
	Device_OLSC();
	~Device_OLSC();

	typedef struct
	{
		INT16 x;
		INT16 y;
		INT16 r;
		INT16 g;
		INT16 b;
		INT16 i;
	}OLSC_Point;

	int Init();
	bool OutputFrame(int cardNum, int scanRate, int bufferSize, OLSC_Point* bufferAddress);
	bool OpenDevice(int cardNum);
	bool Stop(int cardNum);
	bool CloseAll();
	void GetName(int cardNum, char* name);

private:

	HINSTANCE OLSCLibrary;

	//OLSC_GetInterfaceName
	typedef int(__stdcall *OLSCFuncPtr0)(char*);

	//OLSC_Initialize, OLSC_Shutdown
	typedef int(__stdcall *OLSCFuncPtr1)();

	//OLSC_Pause
	typedef int(__stdcall *OLSCFuncPtr2)(int);

	//OLSC_WriteFrameEx
	typedef int(__stdcall *OLSCFuncPtr3)(int device_number, int display_speed, int point_count, OLSC_Point*);

	//OLSC_GetStatus
	typedef int(__stdcall *OLSCFuncPtr4)(int, DWORD&);

	OLSCFuncPtr0 OLSC_GetInterfaceName;
	OLSCFuncPtr1 OLSC_Initialize;
	OLSCFuncPtr1 OLSC_Shutdown;
	OLSCFuncPtr2 OLSC_Pause;
	OLSCFuncPtr3 OLSC_WriteFrameEx;
	OLSCFuncPtr4 OLSC_GetStatus;

	bool ready;
	int frameNum[8];
};

