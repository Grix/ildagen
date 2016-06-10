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
	
	int Init(UINT8 riyaDeviceNum);
	int OutputFrame(int scanRate, int bufferSize, UINT8* bufferAddress);
	int GetID();

private: 
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

	UINT8 riyaDeviceNum;
	UINT pointPeriod;
	bool ready;

	void outputFrameThreaded(int scanRate, int bufferSize, UINT8* bufferAddress);

	riyaFuncPtr1 OpenAllRiyaDevices;    // library routine RiOpenDevices
	riyaFuncPtr2 CloseAllRiyaDevices;   // library routine RiCloseDevices
	riyaFuncPtr3 InitRiyaDevice;        // library routine Ri_InitChanal
	riyaFuncPtr4 RiyaReadyForNextFrame; // library routine Ri_SetIntCh
	riyaFuncPtr5 TransferFrameToBuffer; // library routine RiSetShowCadr
	riyaFuncPtr4 StopRiyaDevice;        // library routine RiStopShow
	riyaFuncPtr6 GetIDVersionNumber;	// GetVersionID
};

