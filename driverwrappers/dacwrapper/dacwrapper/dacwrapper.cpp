/*
wrapper for dac libraries,
used in LasershowGen, license: https://raw.githubusercontent.com/Grix/ildagen/master/LICENSE
by Gitle Mikkelsen
rev: 2016-03-13
*/

//#include "windows.h"
#include "dacwrapper.h"
#include "Device_RIYA.h"
#include "Device_LASDAC.h"
#include "Device_Etherdream.h"
#include <string>
#include <thread>

//must be called before anything else
GMEXPORT double InitDacwrapper()
{
	if (initialized)
	{
		delete etherDreamDevice;
		delete riyaDevice; 
		delete lasdacDevice;
	}

	etherDreamDevice = new Device_Etherdream();
	riyaDevice = new Device_RIYA();
	lasdacDevice = new Device_LASDAC();
	initialized = true;

	etherdreamBuffer = (Device_Etherdream::EAD_Pnt_s*)malloc(4000 * sizeof(Device_Etherdream::EAD_Pnt_s));
	etherdreamBuffer2 = (Device_Etherdream::EAD_Pnt_s*)malloc(4000 * sizeof(Device_Etherdream::EAD_Pnt_s));

	return 1.0;
}

//returns number of etherdream devices available
GMEXPORT double ScanDevices()
{
	if (!initialized) return -1.0;

	numDevices = 0;

	etherDreamDevice->CloseAll();
	int numEtherdreams = etherDreamDevice->Init();
	for (int i = 0; i < numEtherdreams; i++)
	{
		//todo open to verify and get desc
		dacs[numDevices++] = { 1, i, ("Etherdream " +std::to_string(i)).c_str() };
	}


	return (double)numDevices;
}

//opens specified device
GMEXPORT double DeviceOpen(double doubleNum)
{
	if (!initialized) return -1.0;
	int num = (int)(doubleNum + 0.5); //dac number

	int dacType = dacs[num].type;
	int cardNum = dacs[num].cardNum;

	if (dacType == 1)		//EtherDream
		return (double)etherDreamDevice->OpenDevice(cardNum);
	else if (dacType == 2)	//RIYA
		return -1.0; //todo
	else if (dacType == 3)	//Helios
		return -1.0; //todo
}

//prepares buffer and outputs frame to specified device
GMEXPORT double OutputFrame(double num,  double scanRate, double frameSize, UINT16* bufferAddress)
{
	if (!initialized) return -1.0;

	std::thread outputThread(OutputFrameThreaded, num, scanRate, frameSize, bufferAddress);
	outputThread.detach();

	return 1.0;
}

//threaded subfunction of outputframe
void OutputFrameThreaded(double doubleNum, double doubleScanRate, double doubleFrameSize, UINT16* bufferAddress)
{
	int num = (int)(doubleNum + 0.5); //type of dac
	int scanRate = (int)(doubleScanRate + 0.5); //in pps
	int frameSize = (int)(doubleFrameSize + 0.5); //in points

	int dacType = dacs[num].type;
	int cardNum = dacs[num].cardNum;

	if (dacType == 1)	//EtherDream
	{
		for (int i = 0; i < frameSize; i++)
		{
			int currentPos = i * 6;
			etherdreamBuffer[i].X = bufferAddress[currentPos + 0] - 32768;
			etherdreamBuffer[i].Y = bufferAddress[currentPos + 1] - 32768;
			etherdreamBuffer[i].R = bufferAddress[currentPos + 2] * 256;
			etherdreamBuffer[i].G = bufferAddress[currentPos + 3] * 256;
			etherdreamBuffer[i].B = bufferAddress[currentPos + 4] * 256;
			etherdreamBuffer[i].I = bufferAddress[currentPos + 5] * 256;
			etherdreamBuffer[i].AL = 0;
			etherdreamBuffer[i].AR = 0;
		}
		etherDreamDevice->OutputFrame(cardNum, etherdreamBuffer, frameSize*sizeof(Device_Etherdream::EAD_Pnt_s), scanRate);

		Device_Etherdream::EAD_Pnt_s* etherdreamBufferPrev = etherdreamBuffer;
		etherdreamBuffer = etherdreamBuffer2;
		etherdreamBuffer2 = etherdreamBufferPrev;
	}
}

GMEXPORT double FreeDacwrapper()
{
	if (!initialized) return -1.0;

	delete etherDreamDevice;
	delete riyaDevice;
	delete lasdacDevice;

	return 1.0;
}


//GMEXPORT double NewRiyaDevice(double riyaDeviceNum)
//{
//	//awful hack due to GM:S only allowing doubles to be passed
//	Device_RIYA* newDevice = new Device_RIYA();
//	int result = newDevice->Init((UINT8)(riyaDeviceNum + 0.5));
//	if (result <= 0)
//	{
//		delete newDevice;
//		return (double)result;
//	}	
//
//	devices[devicesIndex] = (void*)newDevice;
//	double returnValue = (double)devicesIndex;
//	devicesIndex++;
//
//	return returnValue;
//}
//
//GMEXPORT double RiyaOutputFrame(double deviceId, double scanRate, double bufferSize, UINT8* bufferAddress)
//{
//	Device_RIYA* device = (Device_RIYA*)devices[(int)(deviceId + 0.5)];
//	return (double)device->OutputFrame((int)(scanRate + 0.5), (int)(bufferSize + 0.5), bufferAddress);
//}
//
//GMEXPORT double RiyaClose(double deviceId)
//{
//	Device_RIYA* device = (Device_RIYA*)devices[(int)(deviceId + 0.5)];
//	delete device;
//	return 1.0;
//}
//
//GMEXPORT double RiyaGetID(double deviceId)
//{
//	//function doesn't work
//	Device_RIYA* device = (Device_RIYA*)devices[(int)(deviceId + 0.5)];
//	return (double)device->GetID();
//}
//
//GMEXPORT double NewLasdacDevice(void)
//{
//	//awful hack due to GM:S only allowing doubles to be passed
//	Device_LASDAC* newDevice = new Device_LASDAC();
//	int result = newDevice->Init();
//	if (result <= 0)
//	{
//		delete newDevice;
//		return (double)result;
//	}
//
//	devices[devicesIndex] = (void*)newDevice;
//	double returnValue = (double)devicesIndex;
//	devicesIndex++;
//
//	return returnValue;
//}
//
//GMEXPORT double LasdacOutputFrame(double deviceId, double speed, double num, UINT8* buffer)
//{
//	Device_LASDAC* device = (Device_LASDAC*)devices[(int)(deviceId + 0.5)];
//	return (double)device->OutputFrame(0, (UINT16)(speed + 0.5), (UINT16)(num + 0.5), buffer);
//}
//
//GMEXPORT double LasdacClose(double deviceId)
//{
//	Device_LASDAC* device = (Device_LASDAC*)devices[(int)(deviceId + 0.5)];
//	delete device;
//	return 1.0;
//}