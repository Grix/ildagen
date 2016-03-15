//some code borrowed from LFI player https://sourceforge.net/projects/lfiplayer3d/

#pragma once

#include "windows.h"

class Device_RIYA
{

#define RIYA_BUFFER_SIZE		0x1000
#define RIYA_DEVICE_ATTRIBUTES	0 //8byte point structure
#define RIYA_FRAME_ATTRIBUTES	15

public:

	struct Point
	{
		UINT16 X;
		UINT16 Y;
		UINT8  R;
		UINT8  G;
		UINT8  B;
		UINT8  I;
	};

	Device_RIYA();
	~Device_RIYA();
	
	int Init(UINT8 riyaDeviceNum);
	int OutputFrame(int scanRate, int bufferSize, UINT8* bufferAddress);
	//int SetShutter(bool value); //needed?

	Point frame1[RIYA_BUFFER_SIZE];
	//Point frame2[RIYA_BUFFER_SIZE];

	//Point *frameAddress;

private: 
	// function pointer for library routine RiOpenDevices
	typedef unsigned char(*riyaFuncPtr1)();

	// function pointer for library routine RiCloseDevices
	typedef void(*riyaFuncPtr2)();

	// function pointer for library routine Ri_InitChanal
	typedef void(*riyaFuncPtr3)(unsigned char,              // card ID
		unsigned long);             // attribute

	// function pointer for library routines Ri_SetIntCh & RiStopShow
	typedef unsigned char(*riyaFuncPtr4)(unsigned char);    // card ID

	// function pointer for library routine RiSetShowCadr
	typedef unsigned char(*riyaFuncPtr5)(unsigned char,     // card ID
			unsigned char *,   // data
			unsigned int,      // size
			unsigned int,      // output period
			unsigned char);    // attribute


	UINT8 riyaDeviceNum;
	UINT pointPeriod;
	bool ready;


	riyaFuncPtr1 OpenAllRiyaDevices;    // library routine RiOpenDevices
	riyaFuncPtr2 CloseAllRiyaDevices;   // library routine RiCloseDevices
	riyaFuncPtr3 InitRiyaDevice;        // library routine Ri_InitChanal
	riyaFuncPtr4 RiyaReadyForNextFrame; // library routine Ri_SetIntCh
	riyaFuncPtr5 TransferFrameToBuffer; // library routine RiSetShowCadr
	riyaFuncPtr4 StopRiyaDevice;        // library routine RiStopShow
};

