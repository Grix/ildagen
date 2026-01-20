#pragma once

#include <stdio.h>
#include <thread>
#include <mutex>
#include "artnet/artnet.h"

#define MAX_UNIVERSES 256

class Dmx
{
public:

	Dmx();

	~Dmx();

	void SetEnabled(bool enabled);

	void SetValue(unsigned int address, unsigned int index, uint8_t value);

	void SetInterfaceIp(const char* newIp);

private:

	char ip[32] = { 0 };
	artnet_node artnet_output = NULL;
	artnet_node artnet_input = NULL;
	bool closed = false;
	std::mutex lock;
	uint8_t data[MAX_UNIVERSES][512] = { 0 };
	int sendUpdate[MAX_UNIVERSES] = { 0 };
	std::chrono::steady_clock::time_point nextForcedUpdate[MAX_UNIVERSES];
	bool isInUse[MAX_UNIVERSES] = { 0 };

	int StartArtnet();

	void TxThread();

};

