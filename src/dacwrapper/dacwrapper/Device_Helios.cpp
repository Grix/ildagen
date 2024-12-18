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


	for (int i = 0; i < 32; i++)
		frameNum[i] = 0;

	ready = true;

	int result = heliosDevice->OpenDevices();

	if (result <= 0)
		CloseAll();

	if (result > 32)
		result = 32;

	return result;
}

bool Device_Helios::OutputFrame(int cardNum, int rate, int frameSize, HeliosPoint* bufferAddress)
{
	if (!ready) return false;

	int thisFrameNum = ++frameNum[cardNum];

	std::lock_guard<std::mutex> lock(frameLock[cardNum]);

	for (int i = 0; i < 1000; i++)
	{
		if ((frameNum[cardNum] > thisFrameNum)) //if newer frame is waiting to be transfered, cancel this one
			break;
		else if (heliosDevice->GetStatus(cardNum) == 1)
		{
			return (heliosDevice->WriteFrame(cardNum, rate, HELIOS_FLAGS_DEFAULT | HELIOS_FLAGS_SINGLE_MODE, bufferAddress, frameSize) == HELIOS_SUCCESS);
		}
		std::this_thread::sleep_for(std::chrono::microseconds(100));
	}

	return false;
}

bool Device_Helios::OpenDevice(int cardNum)
{
	std::lock_guard<std::mutex> lock(frameLock[cardNum]);
	heliosDevice->SetShutter(cardNum, 1);
	return true;
}

bool Device_Helios::Stop(int cardNum)
{
	if (!ready) return false;
	
	for (int i = 0; i < 20; i++)
	{
		frameNum[cardNum]++;
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