#include "Device_Etherdream_unix.h"
#include <thread>


Device_Etherdream::Device_Etherdream()
{
	ready = false;
	etherdream_lib_start();
}


Device_Etherdream::~Device_Etherdream()
{
	CloseAll();
}

int Device_Etherdream::Init()
{
	CloseAll();

	int openResult = etherdream_dac_count();
	if (openResult > 0)
		ready = true;

	return openResult;
}

bool Device_Etherdream::OpenDevice(int cardNum)
{
	if (!ready) 
		return false;

	frameNum[cardNum] = 0;

	return (etherdream_connect(etherdream_get(cardNum)) == 0);
}

bool Device_Etherdream::CloseDevice(int cardNum)
{
	if (!ready) 
		return false;

	etherdream_disconnect(etherdream_get(cardNum));
    return true;
}

bool Device_Etherdream::CloseAll()
{
	if (!ready) 
		return false;

	for (int i = 0; i < 16; i++)
	{
		etherdream_stop(etherdream_get(i));
		etherdream_disconnect(etherdream_get(i));
	}

	ready = false;

	return true;
}

bool Device_Etherdream::Stop(int cardNum)
{
	if (!ready) return false;
	return (etherdream_stop(etherdream_get(cardNum)) == 0);
}

bool Device_Etherdream::OutputFrame(int cardNum, const struct etherdream_point* data, int numPoints, uint16_t PPS)
{
	if (!ready) return false;

	int thisFrameNum = ++frameNum[cardNum];
    
    struct etherdream* ed = etherdream_get(cardNum);
    const struct etherdream_point* dat = new struct etherdream_point[1];
    int int1 = 2;
    int int2 = 0;
    int int3 = 0;

	std::lock_guard<std::mutex> lock(frameLock[cardNum]);

	for (int i = 0; i < 1000; i++)
	{
		if (frameNum[cardNum] > thisFrameNum) //if newer frame is waiting to be transfered, cancel this one
			break;
		else if (etherdream_is_ready(ed) == 1)
        {
            return etherdream_write(ed, dat, int1, int2, int3);//(etherdream_write(ed, data, numPoints, (int)PPS, -1) == 0);
		}
		std::this_thread::sleep_for(std::chrono::microseconds(100));
	}

	return false;
}

void Device_Etherdream::GetName(int cardNum, char* name)
{
    name = "Etherdream"; //todo add index/name
}
