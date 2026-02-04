#pragma once

#include <stdio.h>
#include <thread>
#include <mutex>
#include "artnet/artnet.h"
#include "e131.h"

#define MAX_OUTPUT_UNIVERSES 1

class Dmx
{
public:

	Dmx();

	~Dmx();

	void SetEnabled(bool enableArtNet, bool enableSacn);

	void SetOutputValue(unsigned int address, unsigned int index, uint8_t value);

	uint8_t GetInputValue(unsigned short index);

	void SetInterfaceIp(const char* newIp);

	void SetRxUniverse(const int universe);



	int GetRxUniverse();

private:

	char ip[32] = { 0 };
	artnet_node artnet_input = NULL;
	bool closed = false;
	std::mutex artnetLock, sacnLock;
	uint8_t inputData[513] = { 0 };
	int sacnSockfd = -1;
	int rxUniverse = 1;

	artnet_node artnet_output = NULL;
	int sendUpdate[MAX_OUTPUT_UNIVERSES] = { 0 };
	uint8_t outputData[MAX_OUTPUT_UNIVERSES][513] = { 0 };
	std::chrono::steady_clock::time_point nextForcedUpdate[MAX_OUTPUT_UNIVERSES];
	bool isInOutputUse[MAX_OUTPUT_UNIVERSES] = { 0 };

	int StartArtnet();
	int StartSacn();

	void TxThread();
	void SacnRxThread();
	void RxThread();

};

