#include "LaserCubeNetwork.h"

LaserCubeNetwork::LaserCubeNetwork()
{
	// This must normally be done but this library incidentally already does this elsewhere.
	//plt_sockStartup();

}

int LaserCubeNetwork::FindDevices(FILE* _logFile) 
{
#ifdef LDN_LOG
	logFile = _logFile;
#endif

	devices.clear();

	struct addrinfo* servinfo;              // Will point to the results
	struct addrinfo hints;                  // Hints about the caller-supported socket types
	std::memset(&hints, 0, sizeof hints);	// Make sure the struct is empty
	hints.ai_flags = AI_PASSIVE;            // Intention to use address with the bind function
	hints.ai_family = AF_INET;              // IPv4

	if (plt_validateMonoTime() != 0)
		return 0;

	std::vector<unsigned long> foundIps;

#ifdef __linux__ 
	//int rcAddrInfo = getaddrinfo(NULL, "45457", &hints, &servinfo);
	struct ifaddrs* ifaddr;
	if (getifaddrs(&ifaddr) == -1) return errno;

	// Walk through all interfaces
	for (struct ifaddrs* ifa = ifaddr; ifa != NULL; ifa = ifa->ifa_next)
	{
#ifdef LDN_LOG
		fprintf(logFile, "Found interface.\n");
#endif
		if (ifa->ifa_addr == NULL) continue;
		if (ifa->ifa_addr->sa_family != AF_INET) continue;

		// Invoke callback on interface
		struct sockaddr_in* ifSockAddr = (struct sockaddr_in*)ifa->ifa_addr;

		FindDevicesOnInterface(ifa->ifa_name, (uint32_t)(ifSockAddr->sin_addr.s_addr), &foundIps);
	}

	// Interface list is dynamically allocated and must be freed
	freeifaddrs(ifaddr);
#else
	int rcAddrInfo = getaddrinfo("", "45457", &hints, &servinfo);
	if (rcAddrInfo != 0)
	{
		fprintf(stderr, "LaserCubeNetwork getaddrinfo failed: %d\n", rcAddrInfo);
		return 0;
	}

	// Walk through all interfaces (servinfo points to a linked list of struct addrinfos)
	for (struct addrinfo* ifa = servinfo; ifa != NULL; ifa = ifa->ai_next)
	{
#ifdef LDN_LOG
		fprintf(logFile, "Found interface.\n");
#endif
		if (ifa->ai_addr == NULL) continue;
		if (ifa->ai_addr->sa_family != AF_INET) continue;

		// Invoke callback on interface
		struct sockaddr_in* ifSockAddr = (struct sockaddr_in*)ifa->ai_addr;

		FindDevicesOnInterface(ifa->ai_canonname, (uint32_t)(ifSockAddr->sin_addr.s_addr), &foundIps);
	}

	// Interface list is dynamically allocated and must be freed
	freeaddrinfo(servinfo);
#endif

	if (devices.size() > 0)
		inited = true;

	return devices.size();
}

bool LaserCubeNetwork::FindDevicesOnInterface(const char* ifName, uint32_t adapterIpAddr, std::vector<unsigned long>* foundIps)
{
	pingSocketAddr.sin_family = AF_INET;
	pingSocketAddr.sin_port = htons(LDN_CMD_PORT);
	pingSocketAddr.sin_addr.s_addr = 0xFFFFFFFF;

#ifdef LDN_LOG
	fprintf(logFile, "Interface usable: %s, %d. Scanning...\n", ifName, adapterIpAddr);
#endif

	// Create socket
	pingSocketFd = plt_sockOpen(AF_INET, SOCK_DGRAM, 0);
	if (pingSocketFd < 0)
	{
		fprintf(stderr, "socket() failed (error: %d)", plt_sockGetLastError());
#ifdef LDN_LOG
		fprintf(logFile, "socket() failed (error: %d)\n", plt_sockGetLastError());
#endif
		return false;
	}
	// Allow broadcast on socket
	if (plt_sockSetBroadcast(pingSocketFd) < 0)
	{
		fprintf(stderr, "setsockopt(broadcast) failed (error: %d)", plt_sockGetLastError());
#ifdef LDN_LOG
		fprintf(logFile, "setsockopt(broadcast) failed (error: %d)\n", plt_sockGetLastError());
#endif
		return false;
	}
	// Bind to local interface (any! port)
	// Note: This bind is needed to send the broadcast on the specific (virtual) interface,
	struct sockaddr_in bindSockAddr = { 0 };
	bindSockAddr.sin_family = AF_INET;
	bindSockAddr.sin_port = 0;
	bindSockAddr.sin_addr.s_addr = adapterIpAddr;

	if (bind(pingSocketFd, (struct sockaddr*)&bindSockAddr, sizeof(bindSockAddr)) < 0)
	{
		fprintf(stderr, "bind() failed (error: %d)", plt_sockGetLastError());
#ifdef LDN_LOG
		fprintf(logFile, "bind() failed (error: %d)\n", plt_sockGetLastError());
#endif
		return false;
	}
	// Send ping broadcast
	char packet[1] = { LDN_CMD_GET_FULL_INFO };
	int bytesSent = sendto(pingSocketFd, packet, sizeof(packet), 0, (struct sockaddr*)&pingSocketAddr, sizeof(pingSocketAddr));
	if (bytesSent < 0)
	{
		fprintf(stderr, "sendto() failed (error: %d)", plt_sockGetLastError());
#ifdef LDN_LOG
		fprintf(logFile, "sendto() failed (error: %d)\n", plt_sockGetLastError());
#endif
		return false;
	}
	// Another one just in case
	bytesSent = sendto(pingSocketFd, packet, sizeof(packet), 0, (struct sockaddr*)&pingSocketAddr, sizeof(pingSocketAddr));

#ifdef LDN_LOG
	fprintf(logFile, "Send scan request to %s\n", inet_ntoa(pingSocketAddr.sin_addr));
#endif

	// Receive response(s)

	fd_set rfdsPrm;
	FD_ZERO(&rfdsPrm);
	FD_SET(pingSocketFd, &rfdsPrm);

	unsigned msTimeout = 1000;

	// Remember start time
	uint32_t usStart = plt_getMonoTimeUS();

	while (1)
	{
		// Calculate time left
		uint32_t usNow = plt_getMonoTimeUS();
		uint32_t usElapsed = usNow - usStart;
		uint32_t usLeft = (msTimeout * 1000) - usElapsed;
		if ((int32_t)usLeft <= 0) break;

		// Populate select timeout
		struct timeval tv;
		tv.tv_sec = usLeft / 1000000;
		tv.tv_usec = usLeft % 1000000;

		// Wait for incoming datagrams
		fd_set rfdsResult = rfdsPrm;
		int numReady = select(pingSocketFd + 1, &rfdsResult, 0, 0, &tv);
		if (numReady < 0)
		{
			fprintf(stderr, "select() failed (error: %d)", plt_sockGetLastError());
#ifdef LDN_LOG
			fprintf(logFile, "select() failed (error: %d)", plt_sockGetLastError());
#endif
			continue;
		}
		else if (numReady == 0)
		{
			continue;
		}

		// Receive scan response
		struct sockaddr_in recvSockAddr;
		struct sockaddr* recvAddrPre = (struct sockaddr*)&recvSockAddr;
		socklen_t recvAddrSize = sizeof(recvSockAddr);

		char buffer[100];
		int nBytes = recvfrom(pingSocketFd, (char*)buffer, sizeof(buffer), 0, recvAddrPre, &recvAddrSize);
		if (nBytes < 0 || buffer[0] != LDN_CMD_GET_FULL_INFO || ntohs(recvSockAddr.sin_port) != LDN_CMD_PORT)
		{
			fprintf(stderr, "recvfrom() failed (error: %d)", plt_sockGetLastError());
#ifdef LDN_LOG
			fprintf(logFile, "recvfrom() failed (error: %d)", plt_sockGetLastError());
#endif
			continue;
		}
		//todo extract more info from packet
		bool skip = false;
		#ifdef WIN32
			for (auto foundIp : *foundIps)
			{
				if (foundIp == *(unsigned int*)&buffer[32]/*recvSockAddr.sin_addr.S_un.S_addr*/)
					skip = true;
			}
			if (skip)
				continue;

#ifdef LDN_LOG
			fprintf(logFile, "Found device: %s\n", inet_ntoa(recvSockAddr.sin_addr));
#endif
			foundIps->push_back(*(unsigned int*)&buffer[32]);
            devices.push_back(std::make_unique<LaserCubeNetworkDevice>(*(unsigned int*)&buffer[32], buffer));
        #else
			for (auto foundIp : *foundIps)
			{
				if (foundIp == recvSockAddr.sin_addr.s_addr)
					skip = true;
			}
			if (skip)
				continue;
#ifdef LDN_LOG
			fprintf(logFile, "Found device: %s\n", inet_ntoa(recvSockAddr.sin_addr));
#endif
			foundIps->push_back(recvSockAddr.sin_addr.s_addr);
            devices.push_back(std::make_unique<LaserCubeNetworkDevice>(recvSockAddr.sin_addr.s_addr, buffer));
        #endif
	}

	// Close socket
	if (pingSocketFd >= 0)
	{
		if (plt_sockClose(pingSocketFd))
		{
			fprintf(stderr, "close() failed (error: %d)", plt_sockGetLastError());
#ifdef LDN_LOG
			fprintf(logFile, "close() failed (error: %d)", plt_sockGetLastError());
#endif
		}
	}

	return devices.size() != 0;
}

bool LaserCubeNetwork::OpenDevice(unsigned int deviceNum)
{
	return devices[deviceNum]->OpenDevice();
}

bool LaserCubeNetwork::StopOutput(unsigned int deviceNum)
{
	return devices[deviceNum]->StopOutput();
}

bool LaserCubeNetwork::GetStatus(unsigned int deviceNum, unsigned int requiredFreeBufferSpace)
{
	return devices[deviceNum]->GetStatus(requiredFreeBufferSpace);
}

bool LaserCubeNetwork::SendData(unsigned int deviceNum, LaserCubeNetworkSample* data, size_t count, int rate)
{
	return devices[deviceNum]->SendData(data, count, rate);
}

char* LaserCubeNetwork::GetSerialNumber(unsigned int deviceNum)
{
	return devices[deviceNum]->serialNumber;
}

LaserCubeNetwork::LaserCubeNetworkDevice::LaserCubeNetworkDevice(unsigned long ipAddress, char* infoPacketBuffer)
{
    cmdSocketAddr.sin_family = AF_INET;
    cmdSocketAddr.sin_port = htons(LDN_CMD_PORT);
    cmdSocketAddr.sin_addr.s_addr = ipAddress;

	dataSocketAddr.sin_family = AF_INET;
	dataSocketAddr.sin_port = htons(LDN_DATA_PORT);
	dataSocketAddr.sin_addr.s_addr = ipAddress;

	//if (infoPacketBuffer[2] == 0) //version 0 info packet
	{
		maxBufferSpace = *(unsigned short*)&infoPacketBuffer[21];
		freeBufferSpace = maxBufferSpace;
		for (int i = 0; i < 6; i++)
			sprintf(&serialNumber[i*2], "%02X", (unsigned char)infoPacketBuffer[26 + i]);
	}
}

LaserCubeNetwork::LaserCubeNetworkDevice::~LaserCubeNetworkDevice()
{
	StopOutput();
	std::this_thread::sleep_for(std::chrono::microseconds(1000));
	stopThreads = true;
	std::this_thread::sleep_for(std::chrono::microseconds(20000));
	if (cmdSocketFd >= 0)
	{
		if (plt_sockClose(cmdSocketFd)) 
			fprintf(stderr, "close() failed (error: %d)", plt_sockGetLastError());
		cmdSocketFd = -1;
	}
	if (dataSocketFd >= 0)
	{
		if (plt_sockClose(dataSocketFd))
			fprintf(stderr, "close() failed (error: %d)", plt_sockGetLastError());
		dataSocketFd = -1;
	}
}

bool LaserCubeNetwork::LaserCubeNetworkDevice::OpenDevice()
{
	//for (int i = 0; i < 300; i++)
	//	freeBufferSpaceLastFrames[i] = maxBufferSpace;

	cmdSocketFd = plt_sockOpen(AF_INET, SOCK_DGRAM, 0);
	if (cmdSocketFd < 0)
	{
		fprintf(stderr, "laserdock network cmd socket open failed (error: %d)", plt_sockGetLastError());
		return false;
	}

	dataSocketFd = plt_sockOpen(AF_INET, SOCK_DGRAM, 0);
	if (dataSocketFd < 0)
	{
		fprintf(stderr, "laserdock network data socket open failed (error: %d)", plt_sockGetLastError());
		return false;
	}

	struct timeval tv;
	tv.tv_usec = 500000;
	setsockopt(cmdSocketFd, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv, sizeof(tv));

	/*std::thread receiveResponseHandlerThread(&LaserCubeNetwork::LaserCubeNetworkDevice::ReceiveUdpHandler, this);
	receiveResponseHandlerThread.detach();*/
	std::thread warmupHandlerThread(&LaserCubeNetwork::LaserCubeNetworkDevice::WarmupHandler, this);
	warmupHandlerThread.detach();
	std::thread frameHandlerThread(&LaserCubeNetwork::LaserCubeNetworkDevice::FrameHandler, this);
	frameHandlerThread.detach();
	//std::thread periodicCommandHandlerThread(&LaserCubeNetwork::LaserCubeNetworkDevice::PeriodicCommandUdpHandler, this);
	//periodicCommandHandlerThread.detach();
	//std::thread logHandlerThread(&LaserCubeNetwork::LaserCubeNetworkDevice::LogHandler, this);
	//logHandlerThread.detach();

	char val = 1;
	SendCommand(LDN_CMD_ENABLE_BUFFER_SIZE_RESPONSE_ON_DATA, &val);
	SendCommand(LDN_CMD_CLEAR_RINGBUFFER, 0, 0);
	SendCommand(LDN_CMD_SET_OUTPUT, &val);
	int rate = 30000;
	if (SendCommand(LDN_CMD_SET_RATE, (char*)&rate, 4))
		currentRate = rate;

	// todo try to presend some frames until replies with buffer size is stable
    
    return true;
}

bool LaserCubeNetwork::LaserCubeNetworkDevice::GetStatus(unsigned int requiredFreeBufferSpace)
{
	return (freeBufferSpace > requiredFreeBufferSpace);
}

bool LaserCubeNetwork::LaserCubeNetworkDevice::SendData(LaserCubeNetwork::LaserCubeNetworkSample* data, size_t count, int rate)
{
	if (count > 5000) // not supported by lasercube
		return true;

	//if (!isWarmedUp)
	//	return true;

	//fprintf(stderr, "REQUEST FRAME");

	// Update rate
	if (abs(rate - currentRate) > 3)
	{
		if (SendCommand(LDN_CMD_SET_RATE, (char*)&rate, 4))
			currentRate = rate;
	}

	FrameInfo* newFrame = new FrameInfo();
	newFrame->numPoints = count;
	newFrame->rate = rate;
	std::memcpy(newFrame->dataBuffer, data, sizeof(LaserCubeNetwork::LaserCubeNetworkSample) * count);
	std::lock_guard<std::mutex> lock(frameLock);
	localBufferSize += count;
	frameQueue.push(newFrame);
	isStopped = false;
	
	/*if (!outputEnabled)
	{
		char on = 1;
		outputEnabled = SendCommand(LDN_CMD_SET_OUTPUT, &on);
	}*/

	return true;
}

bool LaserCubeNetwork::LaserCubeNetworkDevice::SendCommand(unsigned char command, char* data, int dataLength)
{
	char buffer[8] = { (char)command };
	if (data != 0)
		std::memcpy(buffer + 1, data, dataLength);
	int sentBytes = 0;
	for (int i = 0; i < commandRepeatCount; i++)
		sentBytes = sendto(cmdSocketFd, buffer, 1 + dataLength, 0, (const sockaddr*)&cmdSocketAddr, sizeof(cmdSocketAddr));

	return (sentBytes == 1 + dataLength);
}

bool LaserCubeNetwork::LaserCubeNetworkDevice::StopOutput()
{
	std::lock_guard<std::mutex> lock(frameLock);
	while (frameQueue.size() > 0)
		frameQueue.pop();
	outputEnabled = false;
	localBufferSize = 0;
	SendCommand(LDN_CMD_CLEAR_RINGBUFFER, 0, 0);
	char off = 0;
	isStopped = true;
	return true;// SendCommand(LDN_CMD_SET_OUTPUT, &off);
}

void LaserCubeNetwork::LaserCubeNetworkDevice::ReceiveUdpHandler()
{
	char buffer[1500];
	while (!stopThreads)
	{
		// Request info packet
		//SendCommand(LDN_CMD_GET_FULL_INFO, 0, 0);

		// Handle response udp packets
		struct sockaddr* recvAddrPre = (struct sockaddr*)&dataSocketAddr;
		socklen_t recvAddrSize = sizeof(dataSocketAddr);
		int numBytes = recvfrom(dataSocketFd, buffer, sizeof(buffer), 0, recvAddrPre, &recvAddrSize);
		if (numBytes > 0)
		{
			if (buffer[0] == (char)LDN_CMD_GET_RINGBUFFER_EMPTY_SAMPLE_COUNT)
			{
				freeBufferSpace = *(unsigned short*)(&buffer[2]);
				previousBufferSpaceTime = std::chrono::system_clock::now();


				//std::unique_lock<std::mutex> lock(frameLock, std::try_to_lock);
				/*if (lock.owns_lock())
				{
					//auto currentTime = std::chrono::system_clock::now();
					//freeBufferSpace += std::chrono::duration_cast<std::chrono::microseconds>(currentTime - previousBufferSpaceTime).count() / 1000000.0 * currentRate;
					//fprintf(stderr, "UPDATE BUFFER SIZE: expected %d, got: %d\n", freeBufferSpace, *(unsigned short*)(&buffer[2]));

					// REMOVED FOR NOW DUE TO CAUSING DROPOUTS, todo investigate
					//freeBufferSpace = *(unsigned short*)(&buffer[2]);
					//previousBufferSpaceTime = std::chrono::system_clock::now();
				}
				else
				{
					//fprintf(stderr, "FAILED TO ACQUIRE BUFFER SIZE LOCK\n");
				}*/
			}
		}

		std::this_thread::sleep_for(std::chrono::microseconds(10));
	}
}


void LaserCubeNetwork::LaserCubeNetworkDevice::PeriodicCommandUdpHandler()
{
	while (!stopThreads)
	{
		//SendCommand(LDN_CMD_GET_RINGBUFFER_EMPTY_SAMPLE_COUNT, 0, 0);

		std::this_thread::sleep_for(std::chrono::milliseconds(200));
	}
}

void LaserCubeNetwork::LaserCubeNetworkDevice::WarmupHandler()
{
	FrameInfo frame;
	frame.numPoints = 140;

	for (int i = 0; i < 140; i++)
	{
		frame.dataBuffer[i].x = 0x8000;
		frame.dataBuffer[i].y = 0x8000;
		frame.dataBuffer[i].r = 0;
		frame.dataBuffer[i].g = 0;
		frame.dataBuffer[i].b = 0;
	}

	char buffer[1500] = { (char)LDN_CMD_SAMPLE_DATA, 0x00, (char)(messageNumber++ % 255), (char)(frameNumber % 255) };
	char buffer2[1500];

	while (!stopThreads)
	{
		if (isStopped)
		{
			//char on = 1;
			//outputEnabled = SendCommand(LDN_CMD_SET_OUTPUT, &on);

			fprintf(stderr, "TRANSMIT FRAME (WARMUP): %d, remote buf: %d, local buf: %d\n", frameNumber, (maxBufferSpace - freeBufferSpace), localBufferSize);

			int dataLeft = 140;
			int pointsToSend = dataLeft;
			std::memcpy(buffer + 4, &frame.dataBuffer[frame.numPoints - dataLeft], pointsToSend * sizeof(LaserCubeNetworkSample));
			int sentBytes = sendto(dataSocketFd, buffer, 4 + pointsToSend * sizeof(LaserCubeNetworkSample), 0, (const sockaddr*)&dataSocketAddr, sizeof(dataSocketAddr));
			auto timeStart = std::chrono::system_clock::now();
			dataLeft -= pointsToSend;
			std::this_thread::sleep_for(std::chrono::microseconds(10));

			struct timeval tv;
			tv.tv_sec = 0;
			tv.tv_usec = 2000;

			bool noMoreReplies = false;

			while (!noMoreReplies)
			{
				fd_set readfds;
				FD_ZERO(&readfds);
				FD_SET(dataSocketFd, &readfds);

				struct sockaddr* recvAddrPre = (struct sockaddr*)&dataSocketAddr;
				socklen_t recvAddrSize = sizeof(dataSocketAddr);
				int ret = select(dataSocketFd + 1, &readfds, NULL, NULL, &tv);
				if (ret > 0)
				{
					if (recvfrom(dataSocketFd, buffer2, sizeof(buffer2), 0, recvAddrPre, &recvAddrSize) >= 0)
					{
						freeBufferSpace = *(unsigned short*)(&buffer2[2]);
						previousBufferSpaceTime = std::chrono::system_clock::now();
						fprintf(stderr, "RECEIVE SIZE (WARMUP): %d, remote buf: %d, local buf: %d\n", frameNumber, (maxBufferSpace - freeBufferSpace), localBufferSize);
						//warmupCounter++;
					}
					else
						noMoreReplies = true;
				}
				else
					noMoreReplies = true;
			}

			std::this_thread::sleep_until(timeStart + std::chrono::microseconds(1000 + (int)(140.0 / currentRate * 1000000.0)));

			//StopOutput();
			//isWarmedUp = true;
		}
		std::this_thread::sleep_for(std::chrono::microseconds(10));
	}
}

void LaserCubeNetwork::LaserCubeNetworkDevice::FrameHandler()
{
	// Send new point data when queued
	previousBufferSpaceTime = std::chrono::system_clock::now();
	bool firstRun = true;

	while (!stopThreads)
	{

		if (frameQueue.size() > 0)
		{
			if (skipNextFrame/* && ((forceSendExceptAtZero % 2) != 0)*/)// && skipAllowedAt0)//(maxBufferSpace - freeBufferSpace) > currentRate * 0.15) // too much data buffered
			{
				std::lock_guard<std::mutex> lock(frameLock);
				FrameInfo* frame = frameQueue.front();
				localBufferSize -= frame->numPoints;
				//fprintf(stderr, "SKIP FRAME, remote buf: %d, local buf: %d\n", (maxBufferSpace - freeBufferSpace), localBufferSize);
				frameQueue.pop();
				delete frame;

				skipNextFrame = false;
			}
		}


		if (frameQueue.size() > 0)
		{

			if (((maxBufferSpace - freeBufferSpace) + localBufferSize > currentRate * 0.07) /* || ((forceSendExceptAtZero % 2) != 0)*/) // buffering ~50ms of data before playing
			{
				//fprintf(stderr, "TRANSMIT FRAME: %d, remote buf: %d, local buf: %d, local queue: %d\n", frameNumber, (maxBufferSpace - freeBufferSpace), localBufferSize, frameQueue.size());

				auto timeStart = std::chrono::system_clock::now();

				{
					std::lock_guard<std::mutex> lock(frameLock);
					FrameInfo* frame = frameQueue.front();
					frameNumber++;
					int dataLeft = frame->numPoints;

					/*while (freeBufferSpace < dataLeft)
					{
						std::this_thread::sleep_for(std::chrono::microseconds(1000));
						auto currentTime = std::chrono::system_clock::now();
						freeBufferSpace += std::chrono::duration_cast<std::chrono::microseconds>(currentTime - previousBufferSpaceTime).count() / 1000000.0 * currentRate;
						if (freeBufferSpace > maxBufferSpace)
							freeBufferSpace = maxBufferSpace;
						previousBufferSpaceTime = currentTime;
					}*/

					while (dataLeft > 0)
					{
						auto sendTime = std::chrono::system_clock::now();
						char buffer[1500] = { (char)LDN_CMD_SAMPLE_DATA, 0x00, (char)(messageNumber++ % 255), (char)(frameNumber % 255) };
						int pointsToSend = dataLeft > 140 ? 140 : dataLeft;
						std::memcpy(buffer + 4, &frame->dataBuffer[frame->numPoints - dataLeft], pointsToSend * sizeof(LaserCubeNetworkSample));
						int sentBytes = sendto(dataSocketFd, buffer, 4 + pointsToSend * sizeof(LaserCubeNetworkSample), 0, (const sockaddr*)&dataSocketAddr, sizeof(dataSocketAddr));
						dataLeft -= pointsToSend;
						freeBufferSpace -= pointsToSend;
						localBufferSize -= pointsToSend;
						std::this_thread::sleep_for(std::chrono::microseconds(10));

						if (firstRun)
						{
							previousBufferSpaceTime = std::chrono::system_clock::now();
							firstRun = false;
						}

						int numReplies = 0;
						while (numReplies < 2)
						{
							struct timeval tv;
							tv.tv_sec = 0;
							tv.tv_usec = (numReplies == 0) ? 1000 : 100;

							fd_set readfds;
							FD_ZERO(&readfds);
							FD_SET(dataSocketFd, &readfds);

							struct sockaddr* recvAddrPre = (struct sockaddr*)&dataSocketAddr;
							socklen_t recvAddrSize = sizeof(dataSocketAddr);
							char buffer2[1500];
							int ret = select(dataSocketFd + 1, &readfds, NULL, NULL, &tv);
							if (ret > 0)
							{
								if (recvfrom(dataSocketFd, buffer2, sizeof(buffer2), 0, recvAddrPre, &recvAddrSize) >= 0)
								{
									//if (dataLeft == 0)
									{
										freeBufferSpace = *(unsigned short*)(&buffer2[2]);
										previousBufferSpaceTime = std::chrono::system_clock::now();
										//fprintf(stderr, "RECEIVE SIZE: %d, remote buf: %d, local buf: %d\n", frameNumber, (maxBufferSpace - freeBufferSpace), localBufferSize);

										if ((maxBufferSpace - freeBufferSpace) > currentRate * 0.12)
										{
											//skipNextFrame = true;
											skipCounter++;
										}
										else
											skipCounter -= 10;

										//bool validSkipTest = true;

										numReplies++;
										/*if (numReplies > 1)
										{
											isReplyQueueDone = false;
											//validSkipTest = false; // Wait until pacakge queue is done and count is up to date before deciding to skip
											skipNextFrame = false;
										}
										else if (isReplyQueueDone)
										{
											//validSkipTest = false; // Wait until pacakge queue is done and count is up to date before deciding to skip
											skipNextFrame = false;
										}*/

										/*if (validSkipTest)
										{
											freeBufferSpaceLastFrames[skipTestCounter++] = freeBufferSpace;
										}*/
									}
								}
								else
									break;
							}
							else
								break;
						}

						/*limitLeeway -= std::chrono::microseconds(4010);
						auto now = std::chrono::system_clock::now();
						limitLeeway += std::chrono::duration_cast<std::chrono::microseconds>(now - previousLeewayRefreshTime);
						previousLeewayRefreshTime = now;
						if (limitLeeway.count() > 10000)
							limitLeeway = std::chrono::microseconds(10000);
						else if (limitLeeway.count() <= 0)
							std::this_thread::sleep_for(std::chrono::milliseconds(10)); // max ~20 packets per 10 ms*/
					}
					frameQueue.pop();
					delete frame;
				}

				/*if (skipTestCounter >= 100)
				{
					skipTestCounter = 0;
					int cumulativeFreeSpace = 0;
					for (int i = 0; i < 100; i++)
						cumulativeFreeSpace += freeBufferSpaceLastFrames[i];
					cumulativeFreeSpace /= 100;
					if ((maxBufferSpace - cumulativeFreeSpace) > currentRate * 0.14)
					{
						skipNextFrame = true;
					}
				}*/
				
				std::this_thread::sleep_until(timeStart + std::chrono::microseconds(8000));
			}

			//forceSendToggle = !forceSendToggle;
			//forceSendExceptAtZero = (forceSendExceptAtZero + 1) % 5;
			if (skipCounter > 100)
			{
				skipNextFrame = true;
				skipCounter = 0;
			}
			else if (skipCounter < 0)
				skipCounter = 0;
			//else fprintf(stderr, "NOT ENOUGH BUFFER: %d, remote buf: %d, local buf: %d\n", frameNumber, (maxBufferSpace - freeBufferSpace), localBufferSize);
		}
		std::this_thread::sleep_for(std::chrono::microseconds(500));
	}
}

void LaserCubeNetwork::LaserCubeNetworkDevice::LogHandler()
{
	// logging for debug. Not used in release
	auto startTime = std::chrono::system_clock::now();
	std::ofstream myfile;
	myfile.open("C:\\Users\\gitle\\AppData\\Roaming\\LaserShowGen\\lclog.csv");
	myfile << "time,num_free,num_queued, rate" << std::endl;
	while (!stopThreads)
	{
		try
		{
			std::this_thread::sleep_for(std::chrono::microseconds(5000));
			myfile << std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::system_clock::now() - startTime).count() << "," << freeBufferSpace << "," << localBufferSize << "," << currentRate << std::endl;
		}
		catch (std::exception e) {};
	}
	myfile.close();
}

