#include "Dmx.h"
#include "artnet/packets.h"

Dmx::Dmx()
{
	//std::thread txThread(&Dmx::TxThread, this);
	//txThread.detach();
}

Dmx::~Dmx()
{
	closed = true;
}

void Dmx::SetEnabled(bool enableArtNet, bool enableSacn)
{
	memset(inputData, 0, sizeof(inputData));

	if (enableArtNet && !artnet_input)
	{
		StartArtnet();
	}
	else if (!enableArtNet)
	{
		if (artnet_input)
		{
			artnet_stop(artnet_input);
			artnet_destroy(artnet_input);
			artnet_input = NULL;
		}
	}

	if (enableSacn && sacnSockfd == -1)
	{
		StartSacn();
	}
	else if (!enableSacn)
	{
		if (sacnSockfd != -1)
		{
			fprintf(stderr, "Closed sACN rx socket\n");
#ifdef WIN32
			shutdown(sacnSockfd, SD_BOTH);
			closesocket(sacnSockfd);
#else
			close(sacnSockfd);
#endif
			std::lock_guard<std::mutex>lock(sacnLock);
			sacnSockfd = -1;
		}
	}
}

void Dmx::SetOutputValue(unsigned int address, unsigned int index, uint8_t value)
{
	if (index >= 512)
		return;

	outputData[address & 0xFF][index] = value;
	isInOutputUse[address & 0xFF] = true;
	sendUpdate[address & 0xFF] = 2;
}

uint8_t Dmx::GetInputValue(unsigned short index)
{
	return inputData[index];
}

void Dmx::SetInterfaceIp(const char* newIp)
{
	if (!newIp || !strcmp(newIp, ""))
		ip[0] = 0;
	else
		strncpy(ip, newIp, 32);

	if (artnet_input)
		StartArtnet(); // Restart to apply
	if (sacnSockfd != -1)
		StartSacn();
}

void Dmx::SetRxUniverse(const int universe)
{
	if (universe < 0 || universe == rxUniverse || universe > 0xFFFF)
		return;

	rxUniverse = universe;

	if (artnet_input)
		StartArtnet(); // Restart to apply
	if (sacnSockfd != -1)
		StartSacn();
}

int Dmx::GetRxUniverse()
{
	return rxUniverse;
}

/*int Dmx::StartArtnetOutput()
{
	std::lock_guard<std::mutex>lock(artnetLock);

	if (artnet_output)
	{
		artnet_stop(artnet_output);
		artnet_destroy(artnet_output);
	}

	artnet_output = artnet_new(ip[0] ? ip : NULL, 0);
	if (artnet_output == NULL) {
		fprintf(stderr, "Failed to create Art-Net node, new\n");
		return -1;
	}

	artnet_set_short_name(artnet_output, "LaserShowGen");
	artnet_set_long_name(artnet_output, "LaserShowGen Artnet Output");
	artnet_set_node_type(artnet_output, ARTNET_SRV);

	// set the first port to input dmx data
	artnet_set_port_type(artnet_output, 0, ARTNET_ENABLE_INPUT, ARTNET_PORT_DMX);
	//artnet_set_subnet_addr(artnet_output, 0);

	// set the universe address of the first port
	int ret = artnet_start(artnet_output);
	if (ret != ARTNET_EOK) {
		fprintf(stderr, "Failed to start Art-Net node, start, %d\n", ret);
		artnet_destroy(artnet_output);
		artnet_output = NULL;
		return ret;
	}

	for (int i = 0; i < MAX_OUTPUT_UNIVERSES; i++)
	{
		isInOutputUse[i] = false;
		sendUpdate[i] = 2;
		nextForcedUpdate[i] = std::chrono::steady_clock::now() + std::chrono::milliseconds(900);
	}
	memset(outputData, 0, 512 * MAX_OUTPUT_UNIVERSES);

	return 0;
}*/

int dmx_handler(artnet_node node, int port, void* d) 
{
	((Dmx*)d)->ArtnetDmxCallback(node, port);

	return 0;
}


int Dmx::StartArtnet()
{
	if (artnet_input)
	{
		artnet_stop(artnet_input);
		artnet_destroy(artnet_input);
		artnet_input = NULL;
	}

	artnet_input = artnet_new(ip[0] ? ip : NULL, 0);
	if (artnet_input == NULL) {
		fprintf(stderr, "Failed to create Art-Net input node: %s\n", artnet_strerror());
		return -1;
	}

	artnet_set_short_name(artnet_input, "LaserShowGen");
	artnet_set_long_name(artnet_input, "LaserShowGen Art-Net Input"); 
	artnet_set_node_type(artnet_input, ARTNET_NODE);
	artnet_set_dmx_handler(artnet_input, dmx_handler, this);
	artnet_set_port_type(artnet_input, 0, ARTNET_ENABLE_OUTPUT, ARTNET_PORT_DMX);
	artnet_set_subnet_addr(artnet_input, (rxUniverse - 1) / 16);
	artnet_set_port_addr(artnet_input, 0, ARTNET_OUTPUT_PORT, (rxUniverse - 1) % 16);
	artnet_start(artnet_input);

	fprintf(stderr, "Started Art-Net rx\n");

	std::thread artnetRxThread(&Dmx::ArtnetRxThread, this);
	artnetRxThread.detach();

	return 0;
}

int Dmx::StartSacn()
{
	if (sacnSockfd != -1)
	{
		closed = true;
		fprintf(stderr, "Closed sACN rx socket\n");
#ifdef WIN32
		shutdown(sacnSockfd, SD_BOTH);
		closesocket(sacnSockfd);
#else
		close(sacnSockfd);
#endif
		std::this_thread::sleep_for(std::chrono::milliseconds(10)); // todo close and join thread properly
		sacnSockfd = -1;
		closed = false;
	}

	// create a socket for E1.31
	if ((sacnSockfd = e131_socket()) < 0)
	{
		fprintf(stderr, "ERROR: Failed to start sACN: e131_socket, %d\n", sacnSockfd);
		sacnSockfd = -1;
		return -1;
	}

	// bind the socket to the default E1.31 port
	int ret = e131_bind(sacnSockfd, E131_DEFAULT_PORT);
	if (ret < 0)
	{
		fprintf(stderr, "ERROR: Failed to start sACN: e131_bind, %d\n", ret);
		sacnSockfd = -1;
		return -1;
	}

	// join the socket to multicast group for universe 1 on the default network interface
	if (ip[0])
		ret = e131_multicast_join_iface(sacnSockfd, rxUniverse, 0);
	if (ret < 0)
		ret = e131_multicast_join_ifaddr(sacnSockfd, rxUniverse, ip);
	if (ret < 0)
	{
		fprintf(stderr, "ERROR: Failed to start sACN: e131_multicast_join_iface/ifaddr, %d\n", ret);
		sacnSockfd = -1;
		return -1;
	}

	fprintf(stderr, "Started sACN rx socket\n");

	std::thread sacnRxThread(&Dmx::SacnRxThread, this);
	sacnRxThread.detach();

	return 0;
}

void Dmx::TxThread()
{
	while (!closed)
	{
		std::this_thread::sleep_for(std::chrono::milliseconds(10));

		std::lock_guard<std::mutex>lock(artnetLock);

		if (artnet_output)
		{
			auto now = std::chrono::steady_clock::now();

			for (int i = 0; i < MAX_OUTPUT_UNIVERSES; i++)
			{
				if (isInOutputUse[i] && (sendUpdate[i] > 0 || nextForcedUpdate[i] > now))
				{
					artnet_send_dmx(artnet_output, i, 512, outputData[i]);

					if (sendUpdate[i] > 0)
						sendUpdate[i]--;
					nextForcedUpdate[i] = now + std::chrono::milliseconds(900);
				}
			}
		}
	}

	// Cleanup
	if (artnet_output)
	{
		artnet_stop(artnet_output);
		artnet_destroy(artnet_output);
	}
}

void Dmx::SacnRxThread()
{
	e131_packet_t packet;
	e131_error_t error;
	uint8_t last_seq = 0x00;

	fprintf(stderr, "Starting sACN rx thread\n");

	while (!closed)
	{
		std::this_thread::sleep_for(std::chrono::milliseconds(10));

		int socket = sacnSockfd;

		if (socket != -1)
		{
			int ret = e131_recv(socket, &packet);

			if (ret < 0)
			{
#ifdef WIN32
				int error = WSAGetLastError();
#else
				int error = errno;
#endif
				fprintf(stderr, "Warning: Failed sACN rx: e131_recv, %d %d\n", ret, error);
				continue;
			}
			if ((error = e131_pkt_validate(&packet)) != E131_ERR_NONE)
			{
				fprintf(stderr, "Warning:e131_pkt_validate: %s\n", e131_strerror(error));
				continue;
			}
			if (e131_pkt_discard(&packet, last_seq))
			{
				fprintf(stderr, "Warning: sACN packet out of order received\n");
				last_seq = packet.frame.seq_number;
				continue;
			}
#ifndef NDEBUG
			//e131_pkt_dump(stderr, &packet);
#endif
			if (ntohs(packet.frame.universe) == GetRxUniverse() && !e131_get_option(&packet, E131_OPT_PREVIEW))
			{
				size_t channel = ntohs(packet.dmp.first_addr)-1;
				if (channel < 0)
					channel = 0;
				unsigned int increment = ntohs(packet.dmp.addr_inc);
				for (size_t pos = 0, total = min(ntohs(packet.dmp.prop_val_cnt), 513); pos < total; pos++, channel += increment)
					inputData[channel] = packet.dmp.prop_val[pos];
			}

			last_seq = packet.frame.seq_number;
		}
	}
}

void Dmx::ArtnetRxThread()
{
	while (artnet_input && !closed)
	{
		artnet_read(artnet_input, 1);
		int length;
		uint8_t* data = artnet_read_dmx(artnet_input, 0, &length);
		if (data == NULL)
			continue;
		for (int i = 0; i < length; i++)
			inputData[i] = data[i];
	}
}

int Dmx::ArtnetDmxCallback(artnet_node node, int port)
{
	if (port == 0) 
	{
		int len;
		uint8_t* data;
		data = artnet_read_dmx(node, port, &len);
		memcpy(inputData, data, len);
	}

	//fprintf(stderr, "artnet %d - %d\n", packet->data.admx.universe, packet->data.admx.data[0]);

	return 0;
}
