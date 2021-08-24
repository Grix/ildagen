#include "LaserCubeNetwork.h"

LaserCubeNetwork::LaserCubeNetwork()
{
	// This must normally be done but this library incidentally already does this elsewhere.
	//plt_sockStartup();

}

int LaserCubeNetwork::FindDevices(FILE* _logFile) 
{
	logFile = _logFile;

	devices.clear();

	struct addrinfo* servinfo;              // Will point to the results
	struct addrinfo hints;                  // Hints about the caller-supported socket types
	memset(&hints, 0, sizeof hints);        // Make sure the struct is empty
	hints.ai_flags = AI_PASSIVE;            // Intention to use address with the bind function
	hints.ai_family = AF_INET;              // IPv4

	if (plt_validateMonoTime() != 0)
		return 0;

#ifdef __linux__ 
	//int rcAddrInfo = getaddrinfo(NULL, "45457", &hints, &servinfo);
	struct ifaddrs* ifaddr;
	if (getifaddrs(&ifaddr) == -1) return errno;

	// Walk through all interfaces
	for (struct ifaddrs* ifa = ifaddr; ifa != NULL; ifa = ifa->ifa_next)
	{
		fprintf(logFile, "Found interface.\n");
		if (ifa->ifa_addr == NULL) continue;
		if (ifa->ifa_addr->sa_family != AF_INET) continue;

		// Invoke callback on interface
		struct sockaddr_in* ifSockAddr = (struct sockaddr_in*)ifa->ifa_addr;

		FindDevicesOnInterface(ifa->ifa_name, (uint32_t)(ifSockAddr->sin_addr.s_addr));
		//if (FindDevicesOnInterface(ifa->ifa_name, (uint32_t)(ifSockAddr->sin_addr.s_addr));
		//	break;
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
		fprintf(logFile, "Found interface.\n");
		if (ifa->ai_addr == NULL) continue;
		if (ifa->ai_addr->sa_family != AF_INET) continue;

		// Invoke callback on interface
		struct sockaddr_in* ifSockAddr = (struct sockaddr_in*)ifa->ai_addr;

		FindDevicesOnInterface(ifa->ai_canonname, (uint32_t)(ifSockAddr->sin_addr.s_addr));
		//if (FindDevicesOnInterface(ifa->ai_canonname, (uint32_t)(ifSockAddr->sin_addr.s_addr)))
		//	break;
	}

	// Interface list is dynamically allocated and must be freed
	freeaddrinfo(servinfo);
#endif

	if (devices.size() > 0)
		inited = true;

	return devices.size();
}

bool LaserCubeNetwork::FindDevicesOnInterface(const char* ifName, uint32_t adapterIpAddr)
{
	pingSocketAddr.sin_family = AF_INET;
	pingSocketAddr.sin_port = htons(LDN_CMD_PORT);
	pingSocketAddr.sin_addr.s_addr = 0xFFFFFFFF;


	fprintf(logFile, "Interface usable: %s, %s. Scanning...\n", ifName, inet_ntoa(*((in_addr*)&adapterIpAddr)));

	// Create socket
	pingSocketFd = plt_sockOpen(AF_INET, SOCK_DGRAM, 0);
	if (pingSocketFd < 0)
	{
		fprintf(stderr, "socket() failed (error: %d)", plt_sockGetLastError());
		fprintf(logFile, "socket() failed (error: %d)\n", plt_sockGetLastError());
		return false;
	}
	// Allow broadcast on socket
	if (plt_sockSetBroadcast(pingSocketFd) < 0)
	{
		fprintf(stderr, "setsockopt(broadcast) failed (error: %d)", plt_sockGetLastError());
		fprintf(logFile, "setsockopt(broadcast) failed (error: %d)\n", plt_sockGetLastError());
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
		fprintf(logFile, "bind() failed (error: %d)\n", plt_sockGetLastError());
		return false;
	}
	// Send ping broadcast
	char packet[1] = { LDN_CMD_GET_FULL_INFO };
	int bytesSent = sendto(pingSocketFd, packet, sizeof(packet), 0, (struct sockaddr*)&pingSocketAddr, sizeof(pingSocketAddr));
	if (bytesSent < 0)
	{
		fprintf(stderr, "sendto() failed (error: %d)", plt_sockGetLastError());
		fprintf(logFile, "sendto() failed (error: %d)\n", plt_sockGetLastError());
		return false;
	}
	// Another one just in case
	bytesSent = sendto(pingSocketFd, packet, sizeof(packet), 0, (struct sockaddr*)&pingSocketAddr, sizeof(pingSocketAddr));

	fprintf(logFile, "Send scan request to %s\n", inet_ntoa(pingSocketAddr.sin_addr));

	// Receive response(s)

	fd_set rfdsPrm;
	FD_ZERO(&rfdsPrm);
	FD_SET(pingSocketFd, &rfdsPrm);

	unsigned msTimeout = 1000;

	// Remember start time
	uint32_t usStart = plt_getMonoTimeUS();

	std::vector<unsigned long> foundIps;

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
			fprintf(logFile, "select() failed (error: %d)", plt_sockGetLastError());
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
			fprintf(logFile, "recvfrom() failed (error: %d)", plt_sockGetLastError());
			continue;
		}
		//todo extract more info from packet
		bool skip = false;
		#ifdef WIN32
			for (auto foundIp : foundIps)
			{
				if (foundIp == recvSockAddr.sin_addr.S_un.S_addr)
					skip = true;
			}
			if (skip)
				continue;

			fprintf(logFile, "Found device: %s\n", recvSockAddr.sin_addr);
			foundIps.push_back(recvSockAddr.sin_addr.S_un.S_addr);
            devices.push_back(std::make_unique<LaserCubeNetworkDevice>(recvSockAddr.sin_addr.S_un.S_addr, buffer));
        #else
			for (auto foundIp : foundIps)
			{
				if (foundIp == recvSockAddr.sin_addr.s_addr)
					skip = true;
			}
			if (skip)
				continue;
			fprintf(logFile, "Found device: %s\n", recvSockAddr.sin_addr);
			foundIps.push_back(recvSockAddr.sin_addr.s_addr);
            devices.push_back(std::make_unique<LaserCubeNetworkDevice>(recvSockAddr.sin_addr.s_addr, buffer));
        #endif
	}

	// Close socket
	if (pingSocketFd >= 0)
	{
		if (plt_sockClose(pingSocketFd))
		{
			fprintf(stderr, "close() failed (error: %d)", plt_sockGetLastError());
			fprintf(logFile, "close() failed (error: %d)", plt_sockGetLastError());
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

LaserCubeNetwork::LaserCubeNetworkDevice::LaserCubeNetworkDevice(unsigned long ipAddress, char* infoPacketBuffer)
{
    cmdSocketAddr.sin_family = AF_INET;
    cmdSocketAddr.sin_port = htons(LDN_CMD_PORT);
    cmdSocketAddr.sin_addr.s_addr = ipAddress;

	dataSocketAddr.sin_family = AF_INET;
	dataSocketAddr.sin_port = htons(LDN_DATA_PORT);
	dataSocketAddr.sin_addr.s_addr = ipAddress;

	if (infoPacketBuffer[2] == 0) //version 0 info packet
	{
		maxBufferSpace = *(unsigned short*)&infoPacketBuffer[21];
		freeBufferSpace = maxBufferSpace;
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

	std::thread receiveResponseHandlerThread(&LaserCubeNetwork::LaserCubeNetworkDevice::ReceiveUdpHandler, this);
	receiveResponseHandlerThread.detach();
	std::thread frameHandlerThread(&LaserCubeNetwork::LaserCubeNetworkDevice::FrameHandler, this);
	frameHandlerThread.detach();
	//std::thread periodicCommandHandlerThread(&LaserCubeNetwork::LaserCubeNetworkDevice::PeriodicCommandUdpHandler, this);
	//periodicCommandHandlerThread.detach();
	//std::thread logHandlerThread(&LaserCubeNetwork::LaserCubeNetworkDevice::LogHandler, this);
	//logHandlerThread.detach();

	char val = 1;
	SendCommand(LDN_CMD_ENABLE_BUFFER_SIZE_RESPONSE_ON_DATA, &val);
	SendCommand(LDN_CMD_CLEAR_RINGBUFFER, 0, 0);
    
    return true;
}

bool LaserCubeNetwork::LaserCubeNetworkDevice::GetStatus(unsigned int requiredFreeBufferSpace)
{
	return (freeBufferSpace > requiredFreeBufferSpace);
}

bool LaserCubeNetwork::LaserCubeNetworkDevice::SendData(LaserCubeNetworkSample* data, size_t count, int rate)
{
	if (count > 5000) // not supported by lasercube
		return true;

	//if (freeBufferSpace * 0.7 < count || frameQueue.size() > 10)
	//	return false;

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
	memcpy(newFrame->dataBuffer, data, sizeof(LaserCubeNetworkSample) * count);
	std::lock_guard<std::mutex> lock(frameLock);
	localBufferSize += count;
	frameQueue.push(newFrame);
	
	if (!outputEnabled)
	{
		char on = 1;
		outputEnabled = SendCommand(LDN_CMD_SET_OUTPUT, &on);
	}

	return true;
}

bool LaserCubeNetwork::LaserCubeNetworkDevice::SendCommand(unsigned char command, char* data, int dataLength)
{
	char buffer[8] = { (char)command };
	if (data != 0)
		memcpy(buffer + 1, data, dataLength);
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
	return SendCommand(LDN_CMD_SET_OUTPUT, &off);
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
				std::unique_lock<std::mutex> lock(frameLock, std::try_to_lock);
				if (lock.owns_lock())
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
				}
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

void LaserCubeNetwork::LaserCubeNetworkDevice::FrameHandler()
{
	// Send new point data when queued
	previousBufferSpaceTime = std::chrono::system_clock::now();

	while (!stopThreads)
	{
		if (frameQueue.size() > 0)
		{
			{
				std::lock_guard<std::mutex> lock(frameLock);
				auto currentTime = std::chrono::system_clock::now();
				freeBufferSpace += std::chrono::duration_cast<std::chrono::microseconds>(currentTime - previousBufferSpaceTime).count() / 1000000.0 * currentRate;
				if (freeBufferSpace > maxBufferSpace)
					freeBufferSpace = maxBufferSpace;
				previousBufferSpaceTime = currentTime;
				//fprintf(stderr, "ADJUST BUFFER SIZE, to: %d\n", freeBufferSpace);
			}

			if ((maxBufferSpace - freeBufferSpace) + localBufferSize > currentRate * 0.15) // too much data buffered
			{
				std::lock_guard<std::mutex> lock(frameLock);
				FrameInfo* frame = frameQueue.front();
				localBufferSize -= frame->numPoints;
				//fprintf(stderr, "SKIP FRAME, remote buf: %d, local buf: %d\n", (maxBufferSpace - freeBufferSpace), localBufferSize);
				frameQueue.pop();
				delete frame;
			}
			else if ((maxBufferSpace - freeBufferSpace) + localBufferSize > currentRate * 0.05) // buffering ~50ms of data before playing
			{
				//fprintf(stderr, "TRANSMIT FRAME: %d, remote buf: %d, local buf: %d\n", frameNumber, (maxBufferSpace - freeBufferSpace), localBufferSize);

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
						memcpy(buffer + 4, &frame->dataBuffer[frame->numPoints - dataLeft], pointsToSend * sizeof(LaserCubeNetworkSample));
						int sentBytes = sendto(dataSocketFd, buffer, 4 + pointsToSend * sizeof(LaserCubeNetworkSample), 0, (const sockaddr*)&dataSocketAddr, sizeof(dataSocketAddr));
						dataLeft -= pointsToSend;
						freeBufferSpace -= pointsToSend;
						localBufferSize -= pointsToSend;
						std::this_thread::sleep_for(std::chrono::microseconds(100));
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
				std::this_thread::sleep_for(std::chrono::microseconds(4000));
			}
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

