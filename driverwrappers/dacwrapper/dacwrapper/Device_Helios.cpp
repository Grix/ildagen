#include "Device_Helios.h"


Device_Helios::Device_Helios()
{
	ready = false;
}

Device_Helios::~Device_Helios()
{
	CloseAll();
}

int Device_Helios::Init()
{
	CloseAll();

	heliosDevice = new HeliosDac;
	
	ready = true;
	int result = heliosDevice->OpenDevices();

	if (result <= 0)
		CloseAll();

	return result;
}

bool Device_Helios::OutputFrame(int cardNum, int rate, int frameSize, HeliosPoint* bufferAddress)
{
	if (!ready) return false;

	int thisFrameNum = ++frameNum[cardNum];

	for (int i = 0; i < 128; i++)
	{
		if (frameNum[cardNum] > thisFrameNum) //if newer frame is waiting to be transfered, cancel this one
			break; //CURRENTLY UNUSED BECAUSE OF MUTEX
		else if (heliosDevice->GetStatus(cardNum) == 1)
		{
			if (heliosDevice->WriteFrame(cardNum, rate, HELIOS_FLAGS_DEFAULT, bufferAddress, frameSize) == 1)
			{
				while (heliosDevice->GetStatus(cardNum) == 0);
				return true;
			}
		}
		std::this_thread::sleep_for(std::chrono::milliseconds(1));
	}

	return false;
}

bool Device_Helios::OpenDevice(int cardNum)
{
	//init already opened all devices
	return true;
}

bool Device_Helios::Stop(int cardNum)
{
	if (!ready) return false;
	
	for (int i = 0; i < 20; i++)
	{
		if (heliosDevice->Stop(cardNum) == 1)
			return true;
	}

	return false;
}

bool Device_Helios::CloseAll()
{
	if (!ready)
		return false;

	delete heliosDevice;
	ready = false;
	return true;
}

bool Device_Helios::GetName(int cardNum, char* name)
{
	if (!ready)
		return false;

	return (heliosDevice->GetName(cardNum, name) == 1);
}

bool Device_Helios::SetName(int cardNum, char* name)
{
	if (!ready)
		return false;

	return (heliosDevice->SetName(cardNum, name) == 1);
}

double Device_Helios::GetFirmwareVersion(int cardNum)
{
	if (!ready)
		return false;

	return heliosDevice->GetFirmwareVersion(cardNum);
}