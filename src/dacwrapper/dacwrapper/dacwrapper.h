//dac wrapper for LasershowGen main header file

#include "Device_Helios.h"
#include "Device_LaserDock.h"
#ifdef _WIN32
	#include "Device_Etherdream.h"
	#include "Device_OLSC.h"
	#include "Device_RIYA.h"
	#include "Device_OLSC_Easylase.h"
	#include "Device_OLSC_EzAudDac.h"
#else
	#include "Device_Etherdream_unix.h"
#endif
#include <string>
#include <thread>
#include <mutex>

#ifdef _WIN32
	#define GMEXPORT extern "C" __declspec (dllexport)
#else
	#define GMEXPORT extern "C"
#endif

#define MAX_FRAME_SIZE 0x1000

Device_LaserDock* laserDockDevice;
Device_Helios* heliosDevice;
#ifdef _WIN32
	Device_Etherdream* etherDreamDevice;
	Device_RIYA* riyaDevice;
	Device_OLSC* olscDevice;
	Device_OLSC_Easylase* olscEasylaseDevice;
	Device_OLSC_EzAudDac* olscEzAudDacDevice;
#else
	Device_Etherdream_unix* etherDreamDevice;
#endif

bool initialized = false;
int numDevices = 0;

typedef struct {
	int type;	//1: Etherdream, 2: RIYA, 3: OLSC, 4: Helios, 5: OLSC_Easylase, 6: OLSC_EzAudDac, 7: Laserdock
	int cardNum;
	char* desc;
}DAC;

DAC dacs[32];
std::mutex dacMutex[32];

GMEXPORT double InitDacwrapper();
GMEXPORT double FreeDacwrapper();
GMEXPORT double ScanDevices();
GMEXPORT double DeviceOpen(double dacNum);
GMEXPORT double OutputFrame(double dacNum, double scanRate, double bufferSize, uint16_t* bufferAddress);
void OutputFrameThreaded(double dacNum, double scanRate, double bufferSize, uint16_t* bufferAddress);
GMEXPORT double Stop(double dacNum);
GMEXPORT char* GetName(double dacNum);
GMEXPORT double SetName(double dacNum, char* name);
GMEXPORT double GetFirmwareVersion(double dacNum);
//GMEXPORT double UpdateSettings(uint8_t* bufferAddress);
