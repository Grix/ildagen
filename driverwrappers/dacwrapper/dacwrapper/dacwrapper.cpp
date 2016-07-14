/*
wrapper for dac libraries,
used in LasershowGen, license: https://raw.githubusercontent.com/Grix/ildagen/master/LICENSE
by Gitle Mikkelsen
*/

//#include "windows.h"
#include "dacwrapper.h"

//must be called before anything else
GMEXPORT double InitDacwrapper()
{
	FreeDacwrapper();

	etherDreamDevice = new Device_Etherdream();
	riyaDevice = new Device_RIYA();
	heliosDevice = new Device_Helios();
	olscDevice = new Device_OLSC();
	
	etherdreamBuffer = new Device_Etherdream::EAD_Pnt_s[0x1000];
	etherdreamBuffer2 = new Device_Etherdream::EAD_Pnt_s[0x1000];
	riyaBuffer = new Device_RIYA::Riya_Point[0x1000];
	riyaBuffer2 = new Device_RIYA::Riya_Point[0x1000];
	olscBuffer = new Device_OLSC::OLSC_Point[0x1000];
	olscBuffer2 = new Device_OLSC::OLSC_Point[0x1000];
	heliosBuffer = new Device_Helios::HeliosPoint[0x1000];
	heliosBuffer2 = new Device_Helios::HeliosPoint[0x1000];
	
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
		char* name = new char[64];
		etherDreamDevice->GetName(i, name);
		dacs[numDevices++] = { 1, i, name };
	}

	riyaDevice->CloseAll();
	int numRiyas = riyaDevice->Init();
	for (int i = 0; i < numRiyas; i++)
	{
		char* name = new char[64];
		riyaDevice->GetName(i, name);
		dacs[numDevices++] = { 2, i, name };
	}

	olscDevice->CloseAll();
	int numOLSC = olscDevice->Init();
	for (int i = 0; i < numOLSC; i++)
	{
		char* name = new char[64];
		olscDevice->GetName(i, name);
		dacs[numDevices++] = { 3, i, name };
	}

	heliosDevice->CloseAll();
	int numHelios = heliosDevice->Init();
	for (int i = 0; i < numHelios; i++)
	{
		char* name = new char[64];
		heliosDevice->GetName(i, name);
		dacs[numDevices++] = { 4, i, name };
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
	else
		return -1.0;
}

//prepares buffer and outputs frame to specified device
GMEXPORT double OutputFrame(double num,  double scanRate, double frameSize, uint16_t* bufferAddress)
{
	if (!initialized) return -1.0;

	std::thread outputThread(OutputFrameThreaded, num, scanRate, frameSize, bufferAddress);
	outputThread.detach();

	return 1.0;
}

//threaded subfunction of outputframe
void OutputFrameThreaded(double doubleNum, double doubleScanRate, double doubleFrameSize, uint16_t* bufferAddress)
{
	//if (!initialized) return -1.0;

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
			etherdreamBuffer[i].X = bufferAddress[currentPos + 0] - 0x8000;
			etherdreamBuffer[i].Y = bufferAddress[currentPos + 1] - 0x8000;
			etherdreamBuffer[i].R = bufferAddress[currentPos + 2] << 7;
			etherdreamBuffer[i].G = bufferAddress[currentPos + 3] << 7;
			etherdreamBuffer[i].B = bufferAddress[currentPos + 4] << 7;
			etherdreamBuffer[i].I = bufferAddress[currentPos + 5] << 7;
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
			riyaBuffer[i].R = (uint8_t)bufferAddress[currentPos + 2];
			riyaBuffer[i].G = (uint8_t)bufferAddress[currentPos + 3];
			riyaBuffer[i].B = (uint8_t)bufferAddress[currentPos + 4];
			riyaBuffer[i].I = (uint8_t)bufferAddress[currentPos + 5];
		}
		riyaDevice->OutputFrame(cardNum, scanRate, frameSize, (uint8_t*)riyaBuffer);

		Device_RIYA::Riya_Point* riyaBufferPrev = riyaBuffer;
		riyaBuffer = riyaBuffer2;
		riyaBuffer2 = riyaBufferPrev;
	}
	else if (dacType == 3)	//OLSC
	{
		for (int i = 0; i < frameSize; i++)
		{
			int currentPos = i * 6;
			olscBuffer[i].x = bufferAddress[currentPos + 0];
			olscBuffer[i].y = bufferAddress[currentPos + 1];
			olscBuffer[i].r = bufferAddress[currentPos + 2];
			olscBuffer[i].g = bufferAddress[currentPos + 3];
			olscBuffer[i].b = bufferAddress[currentPos + 4];
			olscBuffer[i].i = bufferAddress[currentPos + 5];
		}
		olscDevice->OutputFrame(cardNum, scanRate, frameSize, olscBuffer);

		Device_OLSC::OLSC_Point* olscBufferPrev = olscBuffer;
		olscBuffer = olscBuffer2;
		olscBuffer2 = olscBufferPrev;
	}
	else if (dacType == 4)	//Helios
	{
		for (int i = 0; i < frameSize; i++)
		{
			int currentPos = i * 6;
			heliosBuffer[i].x = bufferAddress[currentPos + 0] >> 4;
			heliosBuffer[i].y = bufferAddress[currentPos + 1] >> 4;
			heliosBuffer[i].r = (uint8_t)bufferAddress[currentPos + 2];
			heliosBuffer[i].g = (uint8_t)bufferAddress[currentPos + 3];
			heliosBuffer[i].b = (uint8_t)bufferAddress[currentPos + 4];
			heliosBuffer[i].i = (uint8_t)bufferAddress[currentPos + 5];
		}
		heliosDevice->OutputFrame(cardNum, scanRate, frameSize, heliosBuffer);

		Device_Helios::HeliosPoint* heliosBufferPrev = heliosBuffer;
		heliosBuffer = heliosBuffer2;
		heliosBuffer2 = heliosBufferPrev;
	}

}

GMEXPORT double FreeDacwrapper()
{
	if (!initialized) return -1.0;

	delete etherDreamDevice;
	delete riyaDevice;
	delete heliosDevice;
	delete olscDevice;
	delete etherdreamBuffer;
	delete etherdreamBuffer2;
	delete riyaBuffer;
	delete riyaBuffer2;
	delete olscBuffer;
	delete olscBuffer2;
	delete heliosBuffer;
	delete heliosBuffer2;

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
	else if (dacType == 4)	//Helios
		return (double)heliosDevice->Stop(cardNum);
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