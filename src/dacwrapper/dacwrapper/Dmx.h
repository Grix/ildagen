#pragma once

#include <stdio.h>
#include <thread>
#include <mutex>
#include "artnet/artnet.h"
#include "e131.h"

#define MAX_UNIVERSES 256

class Dmx
{
public:

	Dmx();

	~Dmx();

	void SetEnabled(bool enableArtNet, bool enableSacn);

	void SetValue(unsigned int address, unsigned int index, uint8_t value);

	void SetInterfaceIp(const char* newIp);

	void SetRxUniverse(const int universe);

	int GetRxUniverse();

private:

	char ip[32] = { 0 };
	artnet_node artnet_output = NULL;
	artnet_node artnet_input = NULL;
	bool closed = false;
	std::mutex artnetLock, sacnLock;
	uint8_t data[MAX_UNIVERSES][512] = { 0 };
	int sendUpdate[MAX_UNIVERSES] = { 0 };
	std::chrono::steady_clock::time_point nextForcedUpdate[MAX_UNIVERSES];
	bool isInUse[MAX_UNIVERSES] = { 0 };
	int sacnSockfd = -1;
	int rxUniverse = 1;

	int StartArtnet();
	int StartSacn();

	void TxThread();
	void SacnRxThread();
	void RxThread();

};

