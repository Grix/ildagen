#pragma once

#include <Windows.h>
#include <stdint.h>

class Device_Helios
{
public:

	Device_Helios();
	~Device_Helios();

	typedef struct
	{
		uint16_t x; //12 bit (from 0 to 0xFFF)
		uint16_t y; //12 bit (from 0 to 0xFFF)
		uint8_t r;	//8 bit	(from 0 to 0xFF)
		uint8_t g;	//8 bit (from 0 to 0xFF)
		uint8_t b;	//8 bit (from 0 to 0xFF)
		uint8_t i;	//8 bit (from 0 to 0xFF)
	} HeliosPoint;

	int Init();
	bool OutputFrame(int cardNum, int rate, int frameSize, HeliosPoint* bufferAddress);
	bool OpenDevice(int cardNum);
	bool Stop(int cardNum);
	bool CloseAll();
	void GetName(int cardNum, char* name);

private:

	HINSTANCE heliosLibrary;

	//OpenDevices, CloseDevices
	typedef int(*heliosFuncPtr0)();

	//GetStatus
	typedef uint8_t(*heliosFuncPtr1)(int);

	//WriteFrame
	typedef int(*heliosFuncPtr2)(int, int, uint8_t, HeliosPoint*, int);

	//SetShutter
	typedef int(*heliosFuncPtr3)(int, bool);

	//GetName
	typedef int(*heliosFuncPtr4)(int, char*);

	//Stop
	typedef int(*heliosFuncPtr5)(int);

	heliosFuncPtr0 _OpenDevices;
	heliosFuncPtr0 _CloseDevices;
	heliosFuncPtr1 _GetStatus;
	heliosFuncPtr2 _WriteFrame;
	heliosFuncPtr3 _SetShutter;
	heliosFuncPtr4 _GetName;
	heliosFuncPtr5 _Stop;

	bool ready;
	int frameNum[16];
};

