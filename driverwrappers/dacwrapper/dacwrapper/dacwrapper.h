//dac wrapper for LasershowGen main header file

#include "Device_RIYA.h"
#include "Device_LASDAC.h"
#include "Device_Etherdream.h"

#define GMEXPORT extern "C" __declspec (dllexport)

Device_Etherdream* etherDreamDevice;
Device_RIYA* riyaDevice;
Device_LASDAC* lasdacDevice;
bool initialized = false;
int numDevices = 0;

typedef struct {
	int type;	//1: Etherdream, 2: RIYA, 3: Helios
	int cardNum;
	const char* desc;
}DAC;

DAC dacs[32];

Device_Etherdream::EAD_Pnt_s* etherdreamBuffer;
Device_Etherdream::EAD_Pnt_s* etherdreamBuffer2;

GMEXPORT double InitDacwrapper();
GMEXPORT double FreeDacwrapper();
GMEXPORT double ScanDevices();
GMEXPORT double OpenDevice(double dacNum);
GMEXPORT double OutputFrame(double dacNum, double scanRate, double bufferSize, UINT16* bufferAddress);
GMEXPORT void OutputFrameThreaded(double dacNum, double scanRate, double bufferSize, UINT16* bufferAddress);
//GMEXPORT double UpdateSettings(UINT8* bufferAddress);


