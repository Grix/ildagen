/*
wrapper for dac libraries,
used in LasershowGen, license: https://raw.githubusercontent.com/Grix/ildagen/master/LICENSE
by Gitle Mikkelsen
rev: 2016-03-13
*/

//#include "windows.h"
#include "Device_RIYA.h"

#define GMEXPORT extern "C" __declspec (dllexport)

void* devices[1000]; //todo used linked list or something instead
int devicesIndex = 2;

GMEXPORT double NewRiyaDevice(double riyaDeviceNum)
{
	//awful hack due to GM:S only allowing doubles to be passed
	Device_RIYA* newDevice = new Device_RIYA();
	int result = newDevice->Init((UINT8)(riyaDeviceNum + 0.5));
	if (result <= 0)
	{
		delete newDevice;
		return (double)result;
	}	

	devices[devicesIndex] = (void*)newDevice;
	double returnValue = (double)devicesIndex;
	devicesIndex++;

	return returnValue;
}

GMEXPORT double RiyaOutputFrame(double deviceId, double scanRate, double bufferSize, UINT8* bufferAddress)
{
	Device_RIYA* device = (Device_RIYA*)devices[(int)(deviceId + 0.5)];
	return (double)device->OutputFrame((int)(scanRate + 0.5), (int)(bufferSize + 0.5), bufferAddress);
}

GMEXPORT double RiyaClose(double deviceId)
{
	Device_RIYA* device = (Device_RIYA*)devices[(int)(deviceId + 0.5)];
	delete device;
	return 1.0;
}

GMEXPORT double RiyaGetID(double deviceId)
{
	//function doesn't work
	Device_RIYA* device = (Device_RIYA*)devices[(int)(deviceId + 0.5)];
	return (double)device->GetID();
}