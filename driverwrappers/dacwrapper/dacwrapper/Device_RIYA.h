//some code borrowed from LFI player https://sourceforge.net/projects/lfiplayer3d/

#pragma once

#include <windows.h>
#include <stdint.h>

class Device_RIYA
{
		
#define RIYA_BUFFER_SIZE				0x1000
#define RIYA_DEVICE_ATTRIBUTES			0x10
#define RIYA_FRAME_ATTRIBUTES_SYNC		0x1E
#define RIYA_FRAME_ATTRIBUTES_NOSYNC	0x1C

public:
	Device_RIYA();
	~Device_RIYA();

	typedef struct {
		uint16_t X;
		uint16_t Y;
		uint8_t R;
		uint8_t G;
		uint8_t B;
		uint8_t I;
	}Riya_Point;
	
	int Init();
	bool OutputFrame(int cardNum, int scanRate, int bufferSize, uint8_t* bufferAddress);
	bool OpenDevice(int cardNum);
	bool Stop(int cardNum);
	bool CloseAll();
	void GetName(int cardNum, char* name);

private: 

	HINSTANCE riyaLibrary;

	// function pointer for library routine RiOpenDevices
	typedef uint8_t(*riyaFuncPtr1)();

	// function pointer for library routine RiCloseDevices
	typedef void(*riyaFuncPtr2)();

	// function pointer for library routine Ri_InitChanal
	typedef void(*riyaFuncPtr3)(uint8_t,              // card ID
								ULONG);             // attribute

	// function pointer for library routines Ri_SetIntCh & RiStopShow
	typedef uint8_t(*riyaFuncPtr4)(uint8_t);    // card ID
	
	// function pointer for library routine RiSetShowCadr
	typedef uint8_t(*riyaFuncPtr5)(	uint8_t,     // card ID
									uint8_t *,   // data
									UINT,      // size
									UINT,      // output period
									uint8_t);    // attribute

	//func ptr for GetIDVersionNumber
	typedef uint16_t(*riyaFuncPtr6)(uint8_t);

	riyaFuncPtr1 OpenAllRiyaDevices;    // library routine RiOpenDevices
	riyaFuncPtr2 CloseAllRiyaDevices;   // library routine RiCloseDevices
	riyaFuncPtr3 InitRiyaDevice;        // library routine Ri_InitChanal
	riyaFuncPtr4 RiyaReadyForNextFrame; // library routine Ri_SetIntCh
	riyaFuncPtr5 TransferFrameToBuffer; // library routine RiSetShowCadr
	riyaFuncPtr4 StopRiyaDevice;        // library routine RiStopShow
	riyaFuncPtr6 GetIDVersionNumber;	// GetVersionID

	UINT pointPeriod;
	bool ready;
	int frameNum[16];
};

