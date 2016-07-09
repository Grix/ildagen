//dac wrapper for LasershowGen main header file

#include "Device_RIYA.h"
#include "Device_LASDAC.h"
#include "Device_Etherdream.h"
#include "Device_OLSC.h"
#include <string>
#include <thread>

#define GMEXPORT extern "C" __declspec (dllexport)

Device_Etherdream* etherDreamDevice;
Device_RIYA* riyaDevice;
Device_LASDAC* lasdacDevice;
Device_OLSC* olscDevice;

bool initialized = false;
int numDevices = 0;

typedef struct {
	int type;	//1: Etherdream, 2: RIYA, 3: Helios
	int cardNum;
	char* desc;
}DAC;

DAC dacs[32];

Device_Etherdream::EAD_Pnt_s* etherdreamBuffer;
Device_Etherdream::EAD_Pnt_s* etherdreamBuffer2;
Device_RIYA::Riya_Point* riyaBuffer;
Device_RIYA::Riya_Point* riyaBuffer2;
Device_OLSC::OLSC_Point* olscBuffer;
Device_OLSC::OLSC_Point* olscBuffer2;

GMEXPORT double InitDacwrapper();
GMEXPORT double FreeDacwrapper();
GMEXPORT double ScanDevices();
GMEXPORT double OpenDevice(double dacNum);
GMEXPORT double OutputFrame(double dacNum, double scanRate, double bufferSize, UINT16* bufferAddress);
void OutputFrameThreaded(double dacNum, double scanRate, double bufferSize, UINT16* bufferAddress);
GMEXPORT double Stop(double dacNum);
GMEXPORT char* GetName(double dacNum);
//GMEXPORT double UpdateSettings(UINT8* bufferAddress);


