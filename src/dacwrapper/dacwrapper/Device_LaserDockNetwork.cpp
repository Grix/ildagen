#include "Device_LaserDockNetwork.h"

Device_LaserDockNetwork::Device_LaserDockNetwork()
{
	ready = false;

	laserdockDeviceManager = new ldNetworkHardwareManager();
}


Device_LaserDockNetwork::~Device_LaserDockNetwork()
{
	CloseAll();
}


int Device_LaserDockNetwork::Init()
{
	CloseAll();

	ready = true;
	int result = _Initialize();

	if (result <= 0)
		CloseAll();

	return result;
}

bool Device_LaserDockNetwork::OutputFrame(int devNum, int rate, int frameSize, LaserDockPoint* bufferAddress)
{
	if (!ready) return false;

	int thisFrameNum = ++frameNum[devNum];

	std::lock_guard<std::mutex> lock(frameLock[devNum]);

	for (int i = 0; i < 1; i++)
	{
		if (frameNum[devNum] > thisFrameNum) //if newer frame is waiting to be transfered, cancel this one
			break;
		else if (_SendFrame(devNum, (LaserdockSample*)bufferAddress, frameSize, rate))
		{
			return true;
		}
		//std::this_thread::sleep_for(std::chrono::microseconds(100));
	}

	return false;
}

bool Device_LaserDockNetwork::OpenDevice(int devNum)
{
	if (!ready) return false;

	return true;
}

bool Device_LaserDockNetwork::Stop(int devNum)
{
	if (!ready) return false;

	return _Stop(devNum);
}

bool Device_LaserDockNetwork::CloseAll()
{
	if (!ready) return false;

	_FreeAll();
	ready = false;
	return true;
}

void Device_LaserDockNetwork::GetName(int devNum, char* name)
{
	memcpy(name, "LaserCube  ", 12);
	name[11] = (char)((int)(devNum)+48);
	name[12] = '\0';
}

//Previously external. TODO clean up this mess of redundant functions:

int Device_LaserDockNetwork::_Initialize()
{
	if (inited)
		return false; //already inited


	laserdockDevices = laserdockDeviceManager->devices();

	//while (laserdockDevices.size() > LASERDOCK_MAX_DEVICES)
	//	laserdockDevices.pop_back();

	for (unsigned int i = 0; i < laserdockDevices.size(); i++)
	{
		/*if (!laserdockDevices[i]->enable_output())
		{
			laserdockDevices.erase(laserdockDevices.begin() + i);
			i--;
		}
		else
		{*/
			previousRate[i] = 0;
			outputEnabled[i] = true;
		//}
	}
		
	inited = true;

	return laserdockDevices.size();
}

bool Device_LaserDockNetwork::_SendFrame(int devNum, LaserdockSample* data, uint32_t length, uint32_t rate)
{
	if (!inited)
		return false;

	//if (!outputEnabled[devNum]) //enable output if currently disabled
	//	if (!laserdockDevices[devNum]->enable_output())
	//		return false;
	//outputEnabled[devNum] = true;

	if (rate != previousRate[devNum]) //update rate if different from last frame
	{
		uint32_t maxRate;
		if (!laserdockDevices[devNum]->params.device->max_dac_rate(&maxRate))
			return false;
		if (rate > maxRate)
			return false;
		previousRate[devNum] = rate;
		if (!laserdockDevices[devNum]->params.device->set_dac_rate(rate))
			return false;
	}

	return laserdockDevices[devNum]->send(data, length);
}

bool Device_LaserDockNetwork::_Stop(int devNum)
{
	if (!inited)
		return false;

	//disabling then enabling output doesn't always work, this is a workaround

	LaserdockSample blankPoint;
	blankPoint.x = 0x800;
	blankPoint.y = 0x800;
	blankPoint.rg = 0;
	blankPoint.b = 0;
	laserdockDevices[devNum]->send(&blankPoint, 8);

	return true;

	/*if (laserdockDevice->disable_output())
	{
	outputEnabled = false;
	return true;
	}
	else
	return false;*/
}

bool Device_LaserDockNetwork::_FreeAll()
{
	//freeing then reenabling crashes the program, this is a workaround
	if (!inited)
		return false;
	
	inited = false;
	return true;
}