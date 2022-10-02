#include "Device_LaserDockNetwork.h"

Device_LaserDockNetwork::Device_LaserDockNetwork()
{
	ready = false;

	//laserdockDeviceManager = new ldNetworkHardwareManager();
}


Device_LaserDockNetwork::~Device_LaserDockNetwork()
{
	CloseAll();
}


int Device_LaserDockNetwork::Init()
{
	CloseAll();

#ifdef LDN_LOG
	char filename[100];
#ifdef WIN32
	sprintf(filename, "C:\\Users\\gitle\\LSG_LDWIFI_log.txt");
#else
	sprintf(filename, "/tmp/LSG_LDWIFI_log.txt");
#endif
	logFile = fopen(filename, "a");
	fprintf(logFile, "Inited LaserDock Network.\n");
#endif

	ready = true;
	int result = _Initialize();

	if (result <= 0)
		CloseAll();

	return result;
}

bool Device_LaserDockNetwork::OutputFrame(int devNum, int rate, int frameSize, LaserCubeNetwork::LaserCubeNetworkSample* bufferAddress)
{
	if (!ready) return false;

	int thisFrameNum = ++frameNum[devNum];

	std::lock_guard<std::mutex> lock(frameLock[devNum]);

	return _SendFrame(devNum, bufferAddress, frameSize, rate);

	/*for (int i = 0; i < 500; i++)
	{
		//if (frameNum[devNum] > thisFrameNum) //if newer frame is waiting to be transfered, cancel this one
		//	break;
		//else if (_SendFrame(devNum, bufferAddress, frameSize, rate))
		{
			//fprintf(stderr, "SENT FRAME REQUEST %d\n", thisFrameNum);
			return true;
		}
		//else
			//fprintf(stderr, "FAILED FRAME REQUEST %d\n", thisFrameNum);
		std::this_thread::sleep_for(std::chrono::microseconds(100));
	}

	return false;*/
}

bool Device_LaserDockNetwork::OpenDevice(int devNum)
{
	if (!ready) return false;

	return true;
}

bool Device_LaserDockNetwork::TryOpenFromIp(char* hostname)
{
	if (!inited)
	{
		ready = true;
		inited = true;

		// todo
		return false;
	}
}

bool Device_LaserDockNetwork::Stop(int devNum)
{
	if (!ready) return false;

	return _Stop(devNum);
}

bool Device_LaserDockNetwork::CloseAll()
{
	if (!ready) return false;

#ifdef LDN_LOG
	if (logFile != 0)
		fclose(logFile);
#endif

	_FreeAll();
	ready = false;
	return true;
}

void Device_LaserDockNetwork::GetName(int devNum, char* name)
{
	memcpy(name, "LaserCube ", 10);
	memcpy(name + 10, deviceController.GetSerialNumber(devNum), 12);
	name[22] = '\0';
}

//Previously external. TODO clean up this mess of redundant functions:

int Device_LaserDockNetwork::_Initialize()
{
	if (inited)
		return false; //already inited

	int numDevices = deviceController.FindDevices(logFile);

	for (unsigned int i = 0; i < numDevices; i++)
	{
		/*if (!laserdockDevices[i]->enable_output())
		{
			laserdockDevices.erase(laserdockDevices.begin() + i);
			i--;
		}
		else
		{*/
		deviceController.OpenDevice(i);
		previousRate[i] = 0;
		//}
	}
		
	inited = true;

	return numDevices;
}

bool Device_LaserDockNetwork::_SendFrame(int devNum, LaserCubeNetwork::LaserCubeNetworkSample* data, uint32_t length, uint32_t rate)
{
	if (!inited)
		return false;

	/*if (rate != previousRate[devNum]) //update rate if different from last frame
	{
		uint32_t maxRate;
		//if (!laserdockDevices[devNum]->params.device->max_dac_rate(&maxRate))
		//	return false;
		//if (rate > maxRate)
		//	return false;
		previousRate[devNum] = rate;
		//if (!laserdockDevices[devNum]->params.device->set_dac_rate(rate))
		//	return false;
	}*/

	return deviceController.SendData(devNum, data, length, rate);
}

bool Device_LaserDockNetwork::_Stop(int devNum)
{
	if (!inited)
		return false;

	//disabling then enabling output doesn't always work, this is a workaround
	/*LaserCubeNetwork::LaserCubeNetworkSample blankPoint;
	blankPoint.x = 0x800;
	blankPoint.y = 0x800;
	blankPoint.r = 0;
	blankPoint.g = 0;
	blankPoint.b = 0;
	deviceController.SendData(devNum, &blankPoint, 1);*/

	deviceController.StopOutput(devNum);

	return true;
}

bool Device_LaserDockNetwork::_FreeAll()
{
	//freeing then reenabling crashes the program, this is a workaround
	if (!inited)
		return false;
	
	inited = false;
	return true;
}