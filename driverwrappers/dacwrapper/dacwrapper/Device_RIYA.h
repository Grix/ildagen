//some code borrowed from LFI player https://sourceforge.net/projects/lfiplayer3d/

#pragma once

#include "windows.h"

class Device_RIYA
{
		
#define RIYA_BUFFER_SIZE				0x1000
#define RIYA_DEVICE_ATTRIBUTES			0x10
#define RIYA_FRAME_ATTRIBUTES_SYNC		0x1E
#define RIYA_FRAME_ATTRIBUTES_NOSYNC	0x1C

public:
	Device_RIYA();
	~Device_RIYA();
	
	int Init();
	bool OutputFrame(int cardNum, int scanRate, int bufferSize, UINT8* bufferAddress);
	bool OpenDevice(int cardNum);
	bool Stop(int cardNum);
	bool CloseAll();
	void GetName(int cardNum, char* name);

	typedef struct {
		UINT16 X;
		UINT16 Y;
		UINT8 R;
		UINT8 G;
		UINT8 B;
		UINT8 I;
	}Riya_Point;

private: 

	HINSTANCE riyaLibrary = LoadLibrary(L"RiyaNetServer.dll");

	// function pointer for library routine RiOpenDevices
	typedef UINT8(*riyaFuncPtr1)();

	// function pointer for library routine RiCloseDevices
	typedef void(*riyaFuncPtr2)();

	// function pointer for library routine Ri_InitChanal
	typedef void(*riyaFuncPtr3)(UINT8,              // card ID
								ULONG);             // attribute

	// function pointer for library routines Ri_SetIntCh & RiStopShow
	typedef UINT8(*riyaFuncPtr4)(UINT8);    // card ID
	
	// function pointer for library routine RiSetShowCadr
	typedef UINT8(*riyaFuncPtr5)(	UINT8,     // card ID
									UINT8 *,   // data
									UINT,      // size
									UINT,      // output period
									UINT8);    // attribute

	//func ptr for GetIDVersionNumber
	typedef UINT16(*riyaFuncPtr6)(UINT8);

	riyaFuncPtr1 OpenAllRiyaDevices;    // library routine RiOpenDevices
	riyaFuncPtr2 CloseAllRiyaDevices;   // library routine RiCloseDevices
	riyaFuncPtr3 InitRiyaDevice;        // library routine Ri_InitChanal
	riyaFuncPtr4 RiyaReadyForNextFrame; // library routine Ri_SetIntCh
	riyaFuncPtr5 TransferFrameToBuffer; // library routine RiSetShowCadr
	riyaFuncPtr4 StopRiyaDevice;        // library routine RiStopShow
	riyaFuncPtr6 GetIDVersionNumber;	// GetVersionID

	UINT pointPeriod;
	bool ready;
	int frameNum[4];
};

