#pragma once

#include <windows.h>

class Device_Etherdream
{
public:
	Device_Etherdream();
	~Device_Etherdream();

	typedef struct {
		INT16 X;
		INT16 Y;
		INT16 R;
		INT16 G;
		INT16 B;
		INT16 I;
		INT16 AL;
		INT16 AR;
	}EAD_Pnt_s;

	int Init();
	bool OpenDevice(int cardNum);
	bool CloseDevice(int cardNum);
	bool Stop(int cardNum);
	bool CloseAll();
	bool OutputFrame(int cardNum, const EAD_Pnt_s* data, int Bytes, UINT16 PPS);
	void GetName(int cardNum, char* name);

private:

	HINSTANCE etherdreamLibrary;

	//pointer for EtherDreamGetCardNum()
	typedef int(__stdcall *etherdreamFuncPtr0)();

	//pointer for EtherDreamGetDeviceName()
	typedef void(__stdcall *etherdreamFuncPtr1)(const int* CardNum, char *buf, int max);

	//pointer for EtherDreamOpenDevice(), EtherDreamStop() and EtherDreamCloseDevice()
	typedef bool(__stdcall *etherdreamFuncPtr2)(const int* CardNum);

	//pointer for EtherDreamWriteFrame()
	typedef bool(__stdcall *etherdreamFuncPtr3)(const int* CardNum, const EAD_Pnt_s* data, int Bytes, UINT16 PPS, UINT16 Reps);

	//pointer for EtherDreamClose()
	typedef bool(__stdcall *etherdreamFuncPtr4)();

	//pointer for EtherDreamGetStatus()
	typedef int(__stdcall *etherdreamFuncPtr5)(const int* CardNum);

	etherdreamFuncPtr0 EtherDreamGetCardNum;
	etherdreamFuncPtr1 EtherDreamGetDeviceName;
	etherdreamFuncPtr2 EtherDreamOpenDevice;
	etherdreamFuncPtr2 EtherDreamStop;
	etherdreamFuncPtr2 EtherDreamCloseDevice;
	etherdreamFuncPtr3 EtherDreamWriteFrame;
	etherdreamFuncPtr4 EtherDreamClose;
	etherdreamFuncPtr5 EtherDreamGetStatus;

	bool ready;
	int frameNum[4];

	void OutputFrameThreaded();
};

