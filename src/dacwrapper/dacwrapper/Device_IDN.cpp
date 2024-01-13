#include "Device_IDN.h"
#include "idnServerList.h"


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

	for (int i = 0; i < 32; i++)
	{
		contexts[i] = NULL;
	}

	// Scan for IDN-hello servers.

	extern void logError(const char* fmt, ...);

	struct addrinfo* servinfo;              // Will point to the results
	struct addrinfo hints;                  // Hints about the caller-supported socket types
	memset(&hints, 0, sizeof hints);        // Make sure the struct is empty
	hints.ai_flags = AI_PASSIVE;            // Intention to use address with the bind function
	hints.ai_family = AF_INET;              // IPv4
	
	int numDevices = 0;

#ifndef WIN32 
    
    // Find all IDN servers
    unsigned msTimeout = 500;
    IDNSL_SERVER_INFO* firstServerInfo;
    int rcGetList = getIDNServerList(&firstServerInfo, 0, msTimeout);
    if (rcGetList != 0)
    {
        logError("getIDNServerList() failed (error: %d)", rcGetList);
    }
    else
    {
        for (IDNSL_SERVER_INFO* serverInfo = firstServerInfo; serverInfo != 0; serverInfo = serverInfo->next)
        {
            for (unsigned int i = 0; i < serverInfo->addressCount; i++)
            {
                if (serverInfo->addressTable[i].errorFlags == 0 && numDevices < 32)
                {
                    bool found = false;
                    int contextId = 0;
                    for (; contextId < numDevices; contextId++) // Check for duplicate entries
                    {
                        if (contexts[contextId]->serverSockAddr.sin_addr.s_addr == serverInfo->addressTable[i].addr.s_addr) // todo: and name / unit id?
                            found = true;
                    }
                    if (!found)
                    {
                        for (unsigned int j = 0; j < serverInfo->serviceCount && numDevices < 32; j++)
                        {
                            IDNCONTEXT* ctx = new IDNCONTEXT{ 0 };
                            ctx->serverSockAddr.sin_family = AF_INET;
                            ctx->serverSockAddr.sin_port = htons(IDN_PORT);
                            ctx->serverSockAddr.sin_addr.s_addr = serverInfo->addressTable[i].addr.s_addr;
                            ctx->name = std::string(serverInfo->hostName).append(" - ").append(serverInfo->serviceTable[j].serviceName);
                            ctx->serviceId = serverInfo->serviceTable[j].serviceID;

                            contexts[numDevices++] = ctx;
                        }

                    }
                }
            }
        }
        
        freeIDNServerList(firstServerInfo);  // Server list is dynamically allocated and must be freed
    }
	//int rcAddrInfo = getaddrinfo(NULL, "7255", &hints, &servinfo);
	/*struct ifaddrs *ifaddr;
		if(getifaddrs(&ifaddr) == -1) return errno;

		// Walk through all interfaces
		for(struct ifaddrs *ifa = ifaddr; ifa != NULL; ifa = ifa->ifa_next) 
		{
			if(ifa->ifa_addr == NULL) continue;
			if(ifa->ifa_addr->sa_family != AF_INET) continue;

			// Invoke callback on interface
			struct sockaddr_in *ifSockAddr = (struct sockaddr_in *)ifa->ifa_addr;

			// Start check whether address is an IDN-hello server
			std::vector<int>* ipAddrs = idnHelloScan(ifa->ifa_name, (uint32_t)(ifSockAddr->sin_addr.s_addr));
			for (int ipAddr : *ipAddrs)
			{
				bool found = false;
				for (int _ipAddr : allIpAddrs)
				{
				if (_ipAddr == ipAddr)
					found = true;
				}
				if (!found)
				allIpAddrs.push_back(ipAddr);
			}
			delete ipAddrs;
		}

		// Interface list is dynamically allocated and must be freed
		freeifaddrs(ifaddr);*/
#else
	
	// Initialize platform sockets
	/*int rcStartup = plt_sockStartup();
	if (rcStartup)
	{
		logError("Socket startup failed (error: %d)", rcStartup);
		break;
	}*/

	// Find all IDN servers
	unsigned msTimeout = 500;
	IDNSL_SERVER_INFO* firstServerInfo;
	int rcGetList = getIDNServerList(&firstServerInfo, 0, msTimeout);
	if (rcGetList != 0)
	{
		logError("getIDNServerList() failed (error: %d)", rcGetList);
	}
	else
	{
		for (IDNSL_SERVER_INFO* serverInfo = firstServerInfo; serverInfo != 0; serverInfo = serverInfo->next)
		{
			for (unsigned int i = 0; i < serverInfo->addressCount; i++)
			{
				if (serverInfo->addressTable[i].errorFlags == 0 && numDevices < 32)
				{
					bool found = false;
					int contextId = 0;
					for (; contextId < numDevices; contextId++) // Check for duplicate entries
					{
						if (contexts[contextId]->serverSockAddr.sin_addr.S_un.S_addr == serverInfo->addressTable[i].addr.S_un.S_addr) // todo: and name / unit id?
							found = true;
					}
					if (!found)
					{
						for (unsigned int j = 0; j < serverInfo->serviceCount && numDevices < 32; j++)
						{
							IDNCONTEXT* ctx = new IDNCONTEXT{ 0 };
							ctx->serverSockAddr.sin_family = AF_INET;
							ctx->serverSockAddr.sin_port = htons(IDN_PORT);
							ctx->serverSockAddr.sin_addr.s_addr = serverInfo->addressTable[i].addr.S_un.S_addr;
							ctx->name = std::string(serverInfo->hostName).append(" - ").append(serverInfo->serviceTable[j].serviceName);
							ctx->serviceId = serverInfo->serviceTable[j].serviceID;

							contexts[numDevices++] = ctx;
						}

					}
				}
			}
		}
		
		freeIDNServerList(firstServerInfo);  // Server list is dynamically allocated and must be freed
	}

#endif

	return numDevices;
}

bool Device_IDN::OutputFrame(int cardNum, int rate, int frameSize, IdnPoint* bufferAddress)
{
	if (!ready) return false;

	int thisFrameNum = ++frameNum[cardNum];

	std::lock_guard<std::mutex> lock(frameLock[cardNum]);

	for (int i = 0; i < 1000; i++)
	{
		if ((frameNum[cardNum] > thisFrameNum)) // if newer frame is waiting to be transfered, cancel this one
			break;
		else if (true) // buffer status check would be here for other dacs
		{
			if (frameSize > 0)
			{
				if (idnOpenFrameXYRGB(contexts[cardNum]))
					return false;

				contexts[cardNum]->usFrameTime = 1000000 / ((double)frameSize / rate);
				contexts[cardNum]->scanSpeed = rate;
				contexts[cardNum]->jitterFreeFlag = 1;

				//idnPutSampleXYRGB(contexts[cardNum], bufferAddress[0].x, bufferAddress[0].y, 0, 0, 0);
				for (int i = 0; i < frameSize; i++)
				{
					if (idnPutSampleXYRGB(contexts[cardNum], bufferAddress[i].x, bufferAddress[i].y, bufferAddress[i].r, bufferAddress[i].g, bufferAddress[i].b))
						return false;
				}
				//idnPutSampleXYRGB(contexts[cardNum], bufferAddress[0].x, bufferAddress[0].y, 0, 0, 0);

				if (idnPushFrameXYRGB(contexts[cardNum]))
					return false;
				else
					return true;
			}
		}
		std::this_thread::sleep_for(std::chrono::microseconds(100));
	}

	return false;
}

bool Device_IDN::OpenDevice(int cardNum)
{
	std::lock_guard<std::mutex> lock(frameLock[cardNum]);

	contexts[cardNum]->bufferLen = 0x4000;
	contexts[cardNum]->bufferPtr = new uint8_t[0x4000];
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
#ifdef __APPLE__
    if (mach_clock_gettime(SYSTEM_CLOCK, &plt_monoRef) < 0)
#else
    if (clock_gettime(CLOCK_MONOTONIC, &plt_monoRef) < 0)
#endif
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

	for (int i = 0; i < 32; i++)
	{
		frameNum[i]++;
		if (contexts[i] != NULL)
		{
			idnSendClose(contexts[i]);

			if (contexts[i]->bufferPtr) 
				delete contexts[i]->bufferPtr;

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
			contexts[i] = NULL;
		}
	}

	ready = false;
	return true;
}

bool Device_IDN::GetName(int cardNum, char* name)
{
	if (!ready)
		return false;

	memcpy(name, "IDN: ", 6);
	//memcpy(name + 4, std::to_string(cardNum + 1).c_str(), (cardNum + 1) > 9 ? 2 : 1); // numbering, not needed

	int length = contexts[cardNum]->name.length();
	if (length > 3) // Empty name has 3 chars
	{
		// Use name of IDN service
		if (length + 5 > 31)
			length = 31 - 5;
		memcpy(name + 5, contexts[cardNum]->name.c_str(), length + 1);
	}
	else
	{
		// Use IP address
		char ip[32];
		inet_ntop(AF_INET, &contexts[cardNum]->serverSockAddr.sin_addr.s_addr, ip, 32);
		memcpy(name + 5, ip, 17);
	}
    name[32] = 0; // Just in case

	return true;
}

bool Device_IDN::SetName(int cardNum, char* name)
{
	if (!ready)
		return false;

	return false; // not supported for this DAC
}

double Device_IDN::GetFirmwareVersion(int cardNum)
{
	if (!ready)
		return -1;

	return 0;//heliosDevice->GetFirmwareVersion(cardNum);
}
