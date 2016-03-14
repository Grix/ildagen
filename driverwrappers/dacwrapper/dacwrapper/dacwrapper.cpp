/*
wrapper for dac libraries,
used in LasershowGen, license: https://raw.githubusercontent.com/Grix/ildagen/master/LICENSE
by Gitle Mikkelsen
rev: 2016-03-13
*/

#include "windows.h"
#include "Device_RIYA.h"

#define GMEXPORT extern "C" __declspec (dllexport)

void* devices[65535];
int devicesIndex = 0;

GMEXPORT double NewRiyaDevice(double riyaDeviceNum)
{
	//awful hack due to GM:S only allowing doubles to be passed
	Device_RIYA* newDevice = new Device_RIYA();
	newDevice->Init((UINT8)(riyaDeviceNum+0.5));
	devices[devicesIndex] = (void*)newDevice;
	double returnValue = (double)devicesIndex;
	devicesIndex++;

	return returnValue;
}

GMEXPORT double RiyaOutputFrame(double deviceId, double scanRate, double bufferSize, double bufferAddress)
{
	Device_RIYA* device = (Device_RIYA*)devices[(int)(deviceId + 0.5)];
	int result = device->OutputFrame((int)(scanRate + 0.5), (int)(bufferSize + 0.5), (int)(bufferAddress + 0.5));
	return (double)result;
}