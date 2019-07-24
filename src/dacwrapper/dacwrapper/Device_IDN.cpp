#include "Device_IDN.h"


Device_IDN::Device_IDN()
{
	ready = false;
}

Device_IDN::~Device_IDN()
{
	CloseAll();
}

int Device_IDN::Init()
{
	ready = true;

	// todo detect with hello-scan

	return 0;
}

bool Device_IDN::OutputFrame(int cardNum, int rate, int frameSize, IdnPoint* bufferAddress)
{
	if (!ready) return false;

	int thisFrameNum = ++frameNum[cardNum];

	std::lock_guard<std::mutex> lock(frameLock[cardNum]);

	for (int i = 0; i < 1000; i++)
	{
		if ((frameNum[cardNum] > thisFrameNum)) //if newer frame is waiting to be transfered, cancel this one
			break;
		else if (true)//heliosDevice->GetStatus(cardNum) == 1)
		{
			//return (heliosDevice->WriteFrame(cardNum, rate, HELIOS_FLAGS_DEFAULT, bufferAddress, frameSize) == HELIOS_SUCCESS);
			if (idnOpenFrameXYRGB(contexts[cardNum]))
				return false;

			contexts[cardNum]->usFrameTime = 1000000 / (frameSize/rate);
			contexts[cardNum]->scanSpeed = rate;
			contexts[cardNum]->jitterFreeFlag = 1;

			//todo must insert special first two and last two points;
			for (int i = 0; i < frameSize; i++)
			{
				if (idnPutSampleXYRGB(contexts[cardNum], bufferAddress[i].x, bufferAddress[i].x, bufferAddress[i].r, bufferAddress[i].g, bufferAddress[i].b))
					return false;
			}
			if (idnPushFrameXYRGB(contexts[i]))
				return false;
			else
				return true;
		}
		std::this_thread::sleep_for(std::chrono::microseconds(100));
	}

	return false;
}

bool Device_IDN::OpenDevice(int cardNum)
{
	std::lock_guard<std::mutex> lock(frameLock[cardNum]);

	IDNCONTEXT ctx = { 0 };
	ctx.serverSockAddr.sin_family = AF_INET;
	ctx.serverSockAddr.sin_port = htons(IDN_PORT);
	ctx.serverSockAddr.sin_addr.s_addr = helloServerAddr;
	//ctx.usFrameTime = 1000000 / frameRate;
	//ctx.jitterFreeFlag = jitterFreeFlag;
	//ctx.scanSpeed = scanSpeed;
	ctx.colorShift = 0;
	ctx.startTime = getSystemTimeUS();

	contexts[cardNum] = &ctx;
	
	#if defined(_WIN32) || defined(WIN32)
		// Initialize Winsock
		WSADATA wsaData;
		int iResult = WSAStartup(MAKEWORD(2, 2), &wsaData);
		if (iResult != NO_ERROR)
		{
			logError("WSAStartup failed with error: %d", iResult);
			return false;
		}
	#else
		// Initialize time reference and initialize the current time randomly
		if (clock_gettime(CLOCK_MONOTONIC, &tsRef) < 0)
		{
			logError("clock_gettime(CLOCK_MONOTONIC) errno = %d", errno);
			return false;
		}
		currTimeUS = (uint32_t)((tsRef.tv_sec * 1000000ul) + (tsRef.tv_nsec / 1000));
	#endif

	// Open UDP socket
	contexts[cardNum]->fdSocket = socket(AF_INET, SOCK_DGRAM, 0);
	if (contexts[cardNum]->fdSocket < 0)
	{
	#if defined(_WIN32) || defined(WIN32)
			logError("socket() error %d", WSAGetLastError());
	#else
			logError("socket() errno = %d", errno);
	#endif

			return false;
	}

	return true;
}

bool Device_IDN::Stop(int cardNum)
{
	if (!ready) return false;

	for (int i = 0; i < 20; i++)
	{
		frameNum[cardNum]++;
		if (idnSendVoid(contexts[cardNum]) == 0)
			return true;
	}

	return false;
}

bool Device_IDN::CloseAll()
{
	if (!ready)
		return false;

	if (!ready) return false;

	for (int i = 0; i < 16; i++)
	{
		frameNum[i]++;
		if (contexts[i] != NULL)
		{
			idnSendClose(&contexts[i]);

			if (contexts[i]->bufferPtr) free(contexts[i]->bufferPtr);

			// Close socket
			if (contexts[i]->fdSocket >= 0)
			{
#if defined(_WIN32) || defined(WIN32)
				closesocket(contexts[i]->fdSocket);
#else
				close(contexts[i]->fdSocket);
#endif
			}
		}
	}

	ready = false;
	return true;
}

bool Device_IDN::GetName(int cardNum, char* name)
{
	if (!ready)
		return false;

	return "IDN";//(heliosDevice->GetName(cardNum, name) == 1);
}

bool Device_IDN::SetName(int cardNum, char* name)
{
	if (!ready)
		return false;

	return "IDN";//(heliosDevice->SetName(cardNum, name) == 1);
}

double Device_IDN::GetFirmwareVersion(int cardNum)
{
	if (!ready)
		return -1;

	return 0;//heliosDevice->GetFirmwareVersion(cardNum);
}