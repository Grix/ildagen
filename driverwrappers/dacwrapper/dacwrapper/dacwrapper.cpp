/*
wrapper for dac libraries,
used in LasershowGen, license: https://raw.githubusercontent.com/Grix/ildagen/master/LICENSE
by Gitle Mikkelsen
*/

#include "dacwrapper.h"

//must be called before anything else
GMEXPORT double InitDacwrapper()
{
	FreeDacwrapper();

	etherDreamDevice = new Device_Etherdream();
	riyaDevice = new Device_RIYA();
	heliosDevice = new Device_Helios();
	olscDevice = new Device_OLSC();
	olscEasylaseDevice = new Device_OLSC_Easylase();
	olscEzAudDacDevice = new Device_OLSC_EzAudDac();
	laserDockDevice = new Device_LaserDock();
	
	initialized = true;

	return 1.0;
}

//returns number of etherdream devices available
GMEXPORT double ScanDevices()
{
	if (!initialized) return -1.0;

	numDevices = 0;

	int numEtherdreams = etherDreamDevice->Init();
	fprintf(stderr, "Found %d Etherdreams\n", numEtherdreams);
	for (int i = 0; i < numEtherdreams; i++)
	{
		char* name = new char[64];
		etherDreamDevice->GetName(i, name);
		dacs[numDevices++] = { 1, i, name };
	}

	int numOLSC = olscDevice->Init();
	fprintf(stderr, "Found %d OLSC\n", numOLSC);
	for (int i = 0; i < numOLSC; i++)
	{
		char* name = new char[64];
		olscDevice->GetName(i, name);
		dacs[numDevices++] = { 3, i, name };
	}

	int numOLSCEasylase = olscEasylaseDevice->Init();
	fprintf(stderr, "Found %d Easylase\n", numOLSCEasylase);
	for (int i = 0; i < numOLSCEasylase; i++)
	{
		char* name = new char[64];
		olscEasylaseDevice->GetName(i, name);
		dacs[numDevices++] = { 5, i, name };
	}

	int numOLSCEzAudDac = olscEzAudDacDevice->Init();
	fprintf(stderr, "Found %d EZAud\n", numOLSCEzAudDac);
	for (int i = 0; i < numOLSCEzAudDac; i++)
	{
		char* name = new char[64];
		olscEzAudDacDevice->GetName(i, name);
		dacs[numDevices++] = { 6, i, name };
	}

	int numHelios = heliosDevice->Init();
	fprintf(stderr, "Found %d Helios\n", numHelios);
	for (int i = 0; i < numHelios; i++)
	{
		char* name = new char[64];
		heliosDevice->GetName(i, name);
		dacs[numDevices++] = { 4, i, name };
	}

	int numRiyas = riyaDevice->Init();
	fprintf(stderr, "Found %d Riyas\n", numRiyas);
	for (int i = 0; i < numRiyas; i++)
	{
		char* name = new char[64];
		riyaDevice->GetName(i, name);
		dacs[numDevices++] = { 2, i, name };
	}
	int numLaserDocks = laserDockDevice->Init();
	fprintf(stderr,"Found %d LaserDocks\n", numLaserDocks);
	for (int i = 0; i < numLaserDocks; i++)
	{
		char* name = new char[64];
		laserDockDevice->GetName(i, name);
		dacs[numDevices++] = { 7, i, name };
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
	else if (dacType == 3)	//OLSC
		return (double)olscDevice->OpenDevice(cardNum);
	else if (dacType == 4)	//Helios
		return (double)heliosDevice->OpenDevice(cardNum);
	else if (dacType == 5)	//OLSC_Easylase
		return (double)olscEasylaseDevice->OpenDevice(cardNum);
	else if (dacType == 6)	//OLSC_EzAudDac
		return (double)olscEzAudDacDevice->OpenDevice(cardNum);
	else if (dacType == 7)	//LaserDock
		return (double)laserDockDevice->OpenDevice(cardNum);
	else
		return -1.0;
}

//prepares buffer and outputs frame to specified device
GMEXPORT double OutputFrame(double num,  double scanRate, double frameSize, uint16_t* bufferAddress)
{
	if ((!initialized) || (bufferAddress == NULL))
		return -1.0;

	std::thread outputThread(OutputFrameThreaded, num, scanRate, frameSize, bufferAddress);
	outputThread.detach();

	return 1.0;
}

//threaded subfunction of outputframe
void OutputFrameThreaded(double doubleNum, double doubleScanRate, double doubleFrameSize, uint16_t* bufferAddress)
{
	int num = (int)(doubleNum + 0.5); //dac index
	if ((num >= numDevices) || (num < 0))
		return;
	int scanRate = (int)(doubleScanRate + 0.5); //in pps
	if ((false) || (scanRate < 0))
		return;
	int frameSize = (int)(doubleFrameSize + 0.5); //in points
	if (frameSize > MAX_FRAME_SIZE)
		return;

	std::lock_guard<std::mutex> lock(dacMutex[num]); //todo clean up superfluous syncing in individual dac classes

	int dacType = dacs[num].type;
	int cardNum = dacs[num].cardNum;

	if (dacType == 1)	//EtherDream
	{
		int currentPos = 0;
		Device_Etherdream::EAD_Pnt_s etherdreamBuffer[MAX_FRAME_SIZE];
		for (int i = 0; i < frameSize; i++)
		{
			etherdreamBuffer[i].X = bufferAddress[currentPos++] - 0x8000;
			etherdreamBuffer[i].Y = bufferAddress[currentPos++] - 0x8000;
			etherdreamBuffer[i].R = bufferAddress[currentPos++] << 7;
			etherdreamBuffer[i].G = bufferAddress[currentPos++] << 7;
			etherdreamBuffer[i].B = bufferAddress[currentPos++] << 7;
			etherdreamBuffer[i].I = bufferAddress[currentPos++] << 7;
			etherdreamBuffer[i].AL = 0;
			etherdreamBuffer[i].AR = 0;
		}
		etherDreamDevice->OutputFrame(cardNum, &etherdreamBuffer[0], frameSize*sizeof(Device_Etherdream::EAD_Pnt_s), scanRate);
	}
	else if (dacType == 2)	//RIYA
	{
		int currentPos = 0;
		Device_RIYA::Riya_Point riyaBuffer[MAX_FRAME_SIZE];
		for (int i = 0; i < frameSize; i++)
		{
			riyaBuffer[i].X = bufferAddress[currentPos++] >> 4;
			riyaBuffer[i].Y = bufferAddress[currentPos++] >> 4;
			riyaBuffer[i].R = (uint8_t)bufferAddress[currentPos++];
			riyaBuffer[i].G = (uint8_t)bufferAddress[currentPos++];
			riyaBuffer[i].B = (uint8_t)bufferAddress[currentPos++];
			riyaBuffer[i].I = (uint8_t)bufferAddress[currentPos++];
		}
		riyaDevice->OutputFrame(cardNum, scanRate, frameSize, (uint8_t*)&riyaBuffer[0]);
	}
	else if (dacType == 3)	//OLSC
	{
		int currentPos = 0;
		Device_OLSC::OLSC_Point olscBuffer[MAX_FRAME_SIZE];
		for (int i = 0; i < frameSize; i++)
		{
			olscBuffer[i].x = bufferAddress[currentPos++];
			olscBuffer[i].y = bufferAddress[currentPos++];
			olscBuffer[i].r = bufferAddress[currentPos++];
			olscBuffer[i].g = bufferAddress[currentPos++];
			olscBuffer[i].b = bufferAddress[currentPos++];
			olscBuffer[i].i = bufferAddress[currentPos++];
		}
		olscDevice->OutputFrame(cardNum, scanRate, frameSize, &olscBuffer[0]);

	}
	else if (dacType == 5)	//OLSC_Easylase
	{
		int currentPos = 0;
		Device_OLSC_Easylase::OLSC_Point olscEasylaseBuffer[MAX_FRAME_SIZE];
		for (int i = 0; i < frameSize; i++)
		{
			olscEasylaseBuffer[i].x = bufferAddress[currentPos++];
			olscEasylaseBuffer[i].y = bufferAddress[currentPos++];
			olscEasylaseBuffer[i].r = bufferAddress[currentPos++];
			olscEasylaseBuffer[i].g = bufferAddress[currentPos++];
			olscEasylaseBuffer[i].b = bufferAddress[currentPos++];
			olscEasylaseBuffer[i].i = bufferAddress[currentPos++];
		}
		olscEasylaseDevice->OutputFrame(cardNum, scanRate, frameSize, &olscEasylaseBuffer[0]);
	}
	else if (dacType == 6)	//OLSC_EzAudDac
	{
		int currentPos = 0;
		Device_OLSC_EzAudDac::OLSC_Point olscEzAudDacBuffer[MAX_FRAME_SIZE];
		for (int i = 0; i < frameSize; i++)
		{
			olscEzAudDacBuffer[i].x = bufferAddress[currentPos++];
			olscEzAudDacBuffer[i].y = bufferAddress[currentPos++];
			olscEzAudDacBuffer[i].r = bufferAddress[currentPos++];
			olscEzAudDacBuffer[i].g = bufferAddress[currentPos++];
			olscEzAudDacBuffer[i].b = bufferAddress[currentPos++];
			olscEzAudDacBuffer[i].i = bufferAddress[currentPos++];
		}
		olscEzAudDacDevice->OutputFrame(cardNum, scanRate, frameSize, &olscEzAudDacBuffer[0]);
	}
	else if (dacType == 4)	//Helios
	{
		int currentPos = 0;
		HeliosDacClass::HeliosPoint heliosBuffer[MAX_FRAME_SIZE];
		for (int i = 0; i < frameSize; i++)
		{
			heliosBuffer[i].x = bufferAddress[currentPos++] >> 4;
			heliosBuffer[i].y = bufferAddress[currentPos++] >> 4;
			heliosBuffer[i].r = (uint8_t)bufferAddress[currentPos++];
			heliosBuffer[i].g = (uint8_t)bufferAddress[currentPos++];
			heliosBuffer[i].b = (uint8_t)bufferAddress[currentPos++];
			heliosBuffer[i].i = (uint8_t)bufferAddress[currentPos++];
		}
		heliosDevice->OutputFrame(cardNum, scanRate, frameSize, &heliosBuffer[0]);
	}
	else if (dacType == 7)	//LaserDock
	{
		int currentPos = 0;
		Device_LaserDock::LaserDockPoint laserDockBuffer[MAX_FRAME_SIZE];
		for (int i = 0; i < frameSize; i++)
		{
			laserDockBuffer[i].x = bufferAddress[currentPos++] >> 4;
			laserDockBuffer[i].y = bufferAddress[currentPos++] >> 4;
			uint16_t* r = bufferAddress + currentPos++;
			uint16_t* g = bufferAddress + currentPos++;
			laserDockBuffer[i].rg = (((uint8_t)*g << 8) | (uint8_t)*r);
			laserDockBuffer[i].b = (uint8_t)bufferAddress[currentPos++];// << 8;
			currentPos++;
		}
		laserDockDevice->OutputFrame(cardNum, scanRate, frameSize * 8, &laserDockBuffer[0]);
	}

}

GMEXPORT double FreeDacwrapper()
{
	if (!initialized) return -1.0;

	delete etherDreamDevice;
	delete riyaDevice;
	delete heliosDevice;
	delete olscDevice;
	delete olscEzAudDacDevice;
	delete olscEasylaseDevice;
	delete laserDockDevice;

	return 1.0;
}

//stop playback
GMEXPORT double Stop(double doubleNum)
{
	if (!initialized) return -1.0;
	int num = (int)(doubleNum + 0.5); //dac number

	int dacType = dacs[num].type;
	int cardNum = dacs[num].cardNum;

	if (dacType == 1)		//EtherDream
		return (double)etherDreamDevice->Stop(cardNum);
	else if (dacType == 2)	//RIYA
		return (double)riyaDevice->Stop(cardNum);
	else if (dacType == 3)	//OLSC
		return (double)olscDevice->Stop(cardNum);
	else if (dacType == 5)	//OLSC_Easylase
		return (double)olscEasylaseDevice->Stop(cardNum);
	else if (dacType == 6)	//OLSC_EzAudDac
		return (double)olscEzAudDacDevice->Stop(cardNum);
	else if (dacType == 4)	//Helios
		return (double)heliosDevice->Stop(cardNum);
	else if (dacType == 7)	//Laserdock
		return (double)laserDockDevice->Stop(cardNum);
	else
		return -1.0;
}

//get descriptive name of specific dac
GMEXPORT char* GetName(double doubleNum)
{
	if (!initialized) return "error";
	int num = (int)(doubleNum + 0.5); //dac number

	return dacs[num].desc;
}

//set dac name (only for Helios)
GMEXPORT double SetName(double doubleNum, char* name)
{
	if (!initialized) return false;
	int num = (int)(doubleNum + 0.5); //dac number

	int dacType = dacs[num].type;
	int cardNum = dacs[num].cardNum;
	name[30] = '\0'; //name cant be over 31 chars

	if (dacType == 4)	//Helios
		return (heliosDevice->SetName(cardNum, name) == 1);
	else
		return 0;
}

//Get firmware version (only for Helios)
GMEXPORT double GetFirmwareVersion(double doubleNum)
{
	if (!initialized) return false;
	int num = (int)(doubleNum + 0.5); //dac number

	int dacType = dacs[num].type;
	int cardNum = dacs[num].cardNum;

	if (dacType == 4)	//Helios
		return heliosDevice->GetFirmwareVersion(cardNum);
	else
		return -1;
}