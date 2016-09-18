//visual studios 2013, windows 32bit DLL simplified implementation of laserdock libraries

#include "main.h"

bool initialize()
{
	if (inited)
		return false; //already inited

	laserdockDeviceManager = &LaserdockDeviceManager::getInstance();
	laserdockDevice = laserdockDeviceManager->get_next_available_device();

	if (laserdockDevice == NULL)
	{
		delete laserdockDevice;
		return false;
	}

	if (laserdockDevice->status() == LaserdockDevice::INITIALIZED)
	{
		laserdockDevice->enable_output();
		laserdockDevice->get_output(&outputEnabled);
		if (!outputEnabled)
		{
			delete laserdockDevice;
			return false;
		}
		outputEnabled = true;
		inited = true;
		previousRate = 0;
		return true;
	}
	else
	{
		delete laserdockDevice;
		return false;
	}
}

bool sendFrame(uint8_t* data, uint32_t length, uint32_t rate)
{
	if (!inited)
		return false;

	if (!outputEnabled) //enable output if currently disabled
		if (!laserdockDevice->enable_output())
			return false;
	outputEnabled = true;

	if (rate != previousRate) //update rate if different from last frame
	{
		uint32_t maxRate;
		if (!laserdockDevice->max_dac_rate(&maxRate))
			return false;
		if (rate > maxRate)
			return false;
		previousRate = rate;
		if (!laserdockDevice->set_dac_rate(rate))
			return false;
	}

	return laserdockDevice->send(data, length);
}

bool stop()
{
	if (!inited)
		return false;

	//disabling then enabling output doesn't always work, this is a workaround

	LaserdockSample blankPoint;
	blankPoint.x = 0x800;
	blankPoint.y = 0x800;
	blankPoint.rg = 0;
	blankPoint.b = 0;
	laserdockDevice->send((uint8_t*)&blankPoint, 8);

	return true;

	/*if (laserdockDevice->disable_output())
	{
		outputEnabled = false;
		return true;
	}
	else
		return false;*/
}

bool freeAll()
{
	//freeing then reenabling crashes the program, this is a workaround

	/*if (!inited)
		return false;

	delete laserdockDevice;
	inited = false;*/
	return true;
	
}
