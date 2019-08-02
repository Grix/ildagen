//dac wrapper for LasershowGen main header file
#ifdef _WIN32
#include <winsock2.h> // For IDN, need to declare this first, before windows.h used by other classes
#include <ws2tcpip.h> // ^
#include "Device_Etherdream.h"
#include "Device_OLSC.h"
#include "Device_RIYA.h"
#include "Device_OLSC_Easylase.h"
#include "Device_OLSC_EzAudDac.h"
#else
#include "Device_Etherdream_unix.h"
#endif
#include "Device_Helios.h"
#include "Device_LaserDock.h"
#include "Device_IDN.h"
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
Device_Etherdream* etherDreamDevice;
Device_IDN* idnDevice;
#ifdef _WIN32
	Device_RIYA* riyaDevice;
	Device_OLSC* olscDevice;
	Device_OLSC_Easylase* olscEasylaseDevice;
	Device_OLSC_EzAudDac* olscEzAudDacDevice;
#endif

// Needed for IDN plt files, gives redefinition error if moved there
int plt_monoValid = 0;
LARGE_INTEGER plt_monoCtrFreq;
LARGE_INTEGER plt_monoCtrRef;
uint32_t plt_monoTimeUS = 0;

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
