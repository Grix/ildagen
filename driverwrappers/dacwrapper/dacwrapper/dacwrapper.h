//dac wrapper for LasershowGen main header file

#include "Device_RIYA.h"
#include "Device_Etherdream.h"
#include "Device_OLSC.h"
#include "Device_Helios.h"
#include "Device_OLSC_Easylase.h"
#include "Device_OLSC_EzAudDac.h"
#include <string>
#include <thread>

#define GMEXPORT extern "C" __declspec (dllexport)

Device_Etherdream* etherDreamDevice;
Device_RIYA* riyaDevice;
Device_OLSC* olscDevice;
Device_Helios* heliosDevice;
Device_OLSC_Easylase* olscEasylaseDevice;
Device_OLSC_EzAudDac* olscEzAudDacDevice;

bool initialized = false;
int numDevices = 0;

typedef struct {
	int type;	//1: Etherdream, 2: RIYA, 3: OLSC, 4: Helios, 5: OLSC_Easylase, 6: OLSC_EzAudDac
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
Device_Helios::HeliosPoint* heliosBuffer;
Device_Helios::HeliosPoint* heliosBuffer2;
Device_OLSC_Easylase::OLSC_Point* olscEasylaseBuffer;
Device_OLSC_Easylase::OLSC_Point* olscEasylaseBuffer2;
Device_OLSC_EzAudDac::OLSC_Point* olscEzAudDacBuffer;
Device_OLSC_EzAudDac::OLSC_Point* olscEzAudDacBuffer2;

GMEXPORT double InitDacwrapper();
GMEXPORT double FreeDacwrapper();
GMEXPORT double ScanDevices();
GMEXPORT double OpenDevice(double dacNum);
GMEXPORT double OutputFrame(double dacNum, double scanRate, double bufferSize, uint16_t* bufferAddress);
void OutputFrameThreaded(double dacNum, double scanRate, double bufferSize, uint16_t* bufferAddress);
GMEXPORT double Stop(double dacNum);
GMEXPORT char* GetName(double dacNum);
//GMEXPORT double UpdateSettings(uint8_t* bufferAddress);
