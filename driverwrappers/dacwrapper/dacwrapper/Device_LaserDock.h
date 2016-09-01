#pragma once

#include <Windows.h>
#include <stdint.h>

class Device_LaserDock
{
public:

	Device_LaserDock();
	~Device_LaserDock();

	typedef struct
	{
		uint16_t rg;	//lower byte is red, top byte is green
		uint16_t b;		//lower byte is blue
		uint16_t x;		//12bit?
		uint16_t y;		//12bit?
	} LaserDockPoint;

	int Init();
	bool OutputFrame(int rate, int frameSize, LaserDockPoint* bufferAddress);
	bool OpenDevice();
	bool Stop();
	bool CloseAll();
	void GetName(char* name);

private:

	HINSTANCE laserDockLibrary;

	//initialize, stop, free
	typedef bool(*laserDockFuncPtr0)();

	//sendFrame
	typedef bool(*laserDockFuncPtr1)(uint8_t* data, uint32_t length, uint32_t rate);


	laserDockFuncPtr0 _initialize;
	laserDockFuncPtr0 _stop;
	laserDockFuncPtr0 _free;
	laserDockFuncPtr1 _sendFrame;

	bool ready;
	int frameNum;
};

