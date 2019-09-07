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

	// Scan for IDN-hello servers.

	extern void logError(const char* fmt, ...);

	struct addrinfo* servinfo;              // Will point to the results
	struct addrinfo hints;                  // Hints about the caller-supported socket types
	memset(&hints, 0, sizeof hints);        // Make sure the struct is empty
	hints.ai_flags = AI_PASSIVE;            // Intention to use address with the bind function
	hints.ai_family = AF_INET;              // IPv4

	int rcAddrInfo = getaddrinfo("", "", &hints, &servinfo);
	if (rcAddrInfo != 0) return rcAddrInfo;

	int numDevices = 0;

	// Walk through all interfaces (servinfo points to a linked list of struct addrinfos)
	for (struct addrinfo* ifa = servinfo; ifa != NULL; ifa = ifa->ai_next)
	{
		if (ifa->ai_addr == NULL) continue;
		if (ifa->ai_addr->sa_family != AF_INET) continue;

		// Invoke callback on interface
		struct sockaddr_in* ifSockAddr = (struct sockaddr_in*)ifa->ai_addr;

		// Start check whether address is an IDN-hello server
		std::vector<int>* ipAddrs = idnHelloScan(ifa->ai_canonname, (uint32_t)(ifSockAddr->sin_addr.s_addr));
		for (int ipAddr : *ipAddrs)
		{
			IDNCONTEXT *ctx = new IDNCONTEXT { 0 };
			ctx->serverSockAddr.sin_family = AF_INET;
			ctx->serverSockAddr.sin_port = htons(IDN_PORT);
			ctx->serverSockAddr.sin_addr.s_addr = ipAddr;

			contexts[numDevices++] = ctx;
		}
		delete ipAddrs;
	}

	// Interface list is dynamically allocated and must be freed
	freeaddrinfo(servinfo);

	return numDevices;
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

			contexts[cardNum]->usFrameTime = 1000000 / ((double)frameSize/rate);
			contexts[cardNum]->scanSpeed = rate;
			contexts[cardNum]->jitterFreeFlag = 1;

			//todo must insert special first two and last two points;
			for (int i = 0; i < frameSize; i++)
			{
				if (idnPutSampleXYRGB(contexts[cardNum], bufferAddress[i].x, bufferAddress[i].y, bufferAddress[i].r, bufferAddress[i].g, bufferAddress[i].b))
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

	contexts[cardNum]->colorShift = 0;
	contexts[cardNum]->startTime = plt_getMonoTimeUS();
	
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
        extern struct timespec plt_monoRef;
        extern uint32_t plt_monoTimeUS;
        if (clock_gettime(CLOCK_MONOTONIC, &plt_monoRef) < 0)
		{
			logError("clock_gettime(CLOCK_MONOTONIC) errno = %d", errno);
			return false;
		}
		plt_monoTimeUS = (uint32_t)((plt_monoRef.tv_sec * 1000000ul) + (plt_monoRef.tv_nsec / 1000));
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

			delete contexts[i];
		}
	}

	ready = false;
	return true;
}

bool Device_IDN::GetName(int cardNum, char* name)
{
	if (!ready)
		return false;

	memcpy(name, "IDN", 4);

	return true;//(heliosDevice->GetName(cardNum, name) == 1);
}

bool Device_IDN::SetName(int cardNum, char* name)
{
	if (!ready)
		return false;

	return false;//(heliosDevice->SetName(cardNum, name) == 1);
}

double Device_IDN::GetFirmwareVersion(int cardNum)
{
	if (!ready)
		return -1;

	return 0;//heliosDevice->GetFirmwareVersion(cardNum);
}
