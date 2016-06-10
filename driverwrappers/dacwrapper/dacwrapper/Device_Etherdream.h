#pragma once

#include "windows.h"

class Device_Etherdream
{
public:
	Device_Etherdream();
	~Device_Etherdream();

	int Init();
	int OutputFrame();

private:

	struct EAD_Pnt_s {
		INT16 X;
		INT16 Y;
		INT16 R;
		INT16 G;
		INT16 B;
		INT16 I;
		INT16 AL;
		INT16 AR;
	};

	//pointer for EtherDreamGetCardNum()
	typedef int(*etherdreamFuncPtr0)();

	//pointer for EtherDreamGetDeviceName()
	typedef void(*etherdreamFuncPtr1)(const int *CardNum, char *buf, int max);

	//pointer for EtherDreamOpenDevice(), EtherDreamStop() and EtherDreamCloseDevice()
	typedef bool(*etherdreamFuncPtr2)(const int *CardNum);

	//pointer for EtherDreamWriteFrame()
	typedef bool(*etherdreamFuncPtr3)(const int *CardNum, const struct EAD_Pnt_s* data, int Bytes, UINT16 PPS, UINT16 Reps);

	//pointer for EtherDreamClose()
	typedef bool(*etherdreamFuncPtr4)();

	etherdreamFuncPtr0 EtherDreamGetCardNum;
	etherdreamFuncPtr1 EtherDreamGetDeviceName;
	etherdreamFuncPtr2 EtherDreamOpenDevice;
	etherdreamFuncPtr2 EtherDreamStop;
	etherdreamFuncPtr2 EtherDreamCloseDevice;
	etherdreamFuncPtr3 EtherDreamWriteFrame;
	etherdreamFuncPtr4 EtherDreamClose;

	bool ready;

	void OutputFrameThreaded();
};

