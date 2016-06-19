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
	FreeDacwrapper();

	etherDreamDevice = new Device_Etherdream();
	riyaDevice = new Device_RIYA();
	lasdacDevice = new Device_LASDAC();
	
	etherdreamBuffer = new Device_Etherdream::EAD_Pnt_s[4000];
	etherdreamBuffer2 = new Device_Etherdream::EAD_Pnt_s[4000];
	riyaBuffer = new Device_RIYA::Riya_Point[4000];
	riyaBuffer2 = new Device_RIYA::Riya_Point[4000];
	
	initialized = true;

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

	riyaDevice->CloseAll();
	int numRiyas = riyaDevice->Init();
	for (int i = 0; i < numRiyas; i++)
	{
		//todo open to verify and get desc
		dacs[numDevices++] = { 2, i, ("RIYA " + std::to_string(i)).c_str() };
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
		return (double)riyaDevice->OpenDevice(cardNum);
	else if (dacType == 3)	//Helios
		return -1.0; //todo
	else
		return -1.0;
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
	else if (dacType == 2)	//RIYA
	{
		for (int i = 0; i < frameSize; i++)
		{
			int currentPos = i * 6;
			riyaBuffer[i].X = bufferAddress[currentPos + 0] >> 4;
			riyaBuffer[i].Y = bufferAddress[currentPos + 1] >> 4;
			riyaBuffer[i].R = (UINT8)bufferAddress[currentPos + 2];
			riyaBuffer[i].G = (UINT8)bufferAddress[currentPos + 3];
			riyaBuffer[i].B = (UINT8)bufferAddress[currentPos + 4];
			riyaBuffer[i].I = (UINT8)bufferAddress[currentPos + 5];
		}
		riyaDevice->OutputFrame(cardNum, scanRate, frameSize, (UINT8*)riyaBuffer);

		Device_RIYA::Riya_Point* riyaBufferPrev = riyaBuffer;
		riyaBuffer = riyaBuffer2;
		riyaBuffer2 = riyaBufferPrev;
	}
}

GMEXPORT double FreeDacwrapper()
{
	if (!initialized) return -1.0;

	delete etherDreamDevice;
	delete riyaDevice;
	delete lasdacDevice;
	delete etherdreamBuffer;
	delete etherdreamBuffer2;
	delete riyaBuffer;
	delete riyaBuffer2;

	return 1.0;
}