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
	CloseAll();

	// Initialize driver function context
	context = { 0 };
	context.serverSockAddr.sin_family = AF_INET;
	context.serverSockAddr.sin_port = htons(IDN_PORT);
	context.serverSockAddr.sin_addr.s_addr = helloServerAddr;
	context.usFrameTime = 1000000 / frameRate;
	context.jitterFreeFlag = jitterFreeFlag;
	context.scanSpeed = scanSpeed;
	context.colorShift = colorShift;
	context.startTime = getSystemTimeUS();

	ready = true;
	int result = heliosDevice->OpenDevices();

	if (result <= 0)
		CloseAll();

	return result;
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
		else if (heliosDevice->GetStatus(cardNum) == 1)
		{
			return (heliosDevice->WriteFrame(cardNum, rate, HELIOS_FLAGS_DEFAULT, bufferAddress, frameSize) == HELIOS_SUCCESS);
		}
		std::this_thread::sleep_for(std::chrono::microseconds(100));
	}

	return false;
}

bool Device_IDN::OpenDevice(int cardNum)
{
	std::lock_guard<std::mutex> lock(frameLock[cardNum]);
	
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
		context.fdSocket = socket(AF_INET, SOCK_DGRAM, 0);
		if (context.fdSocket < 0)
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
		if (heliosDevice->Stop(cardNum) == 1)
			return true;
	}

	return false;
}

bool Device_IDN::CloseAll()
{
	if (!ready)
		return false;

	idnSendClose(&context);
	// Free buffer memory
	if (context.bufferPtr) free(context.bufferPtr);

	// Close socket
	if (context.fdSocket >= 0)
	{
#if defined(_WIN32) || defined(WIN32)
		closesocket(context.fdSocket);
#else
		close(ctx.fdSocket);
#endif
	}

	ready = false;
	return true;
}

bool Device_IDN::GetName(int cardNum, char* name)
{
	if (!ready)
		return false;

	return (heliosDevice->GetName(cardNum, name) == 1);
}

bool Device_IDN::SetName(int cardNum, char* name)
{
	if (!ready)
		return false;

	return (heliosDevice->SetName(cardNum, name) == 1);
}

double Device_IDN::GetFirmwareVersion(int cardNum)
{
	if (!ready)
		return false;

	return heliosDevice->GetFirmwareVersion(cardNum);
}