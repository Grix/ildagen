#pragma once

#include <windows.h>
#include <stdint.h>
#include <thread>
#include <chrono>
#include <mutex>

class Device_Etherdream
{
public:
	Device_Etherdream();
	~Device_Etherdream();

	typedef struct {
		int16_t X;
		int16_t Y;
		int16_t R;
		int16_t G;
		int16_t B;
		int16_t I;
		int16_t AL;
		int16_t AR;
	}EAD_Pnt_s;

	int Init();
	bool OpenDevice(int cardNum);
	bool CloseDevice(int cardNum);
	bool Stop(int cardNum);
	bool CloseAll();
	bool OutputFrame(int cardNum, const EAD_Pnt_s* data, int Bytes, uint16_t PPS);
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
	typedef bool(__stdcall *etherdreamFuncPtr3)(const int* CardNum, const EAD_Pnt_s* data, int Bytes, uint16_t PPS, uint16_t Reps);

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
	int frameNum[32];
	std::mutex frameLock[32];
	bool stopped[32];
};

