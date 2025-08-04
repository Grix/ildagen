#include "Dmx.h"

Dmx::Dmx()
{
	std::thread txThread(&Dmx::TxThread, this);
	txThread.detach();
}

Dmx::~Dmx()
{
	closed = true;
}

void Dmx::SetEnabled(bool enabled)
{
	std::lock_guard<std::mutex>lock(lock);

	if (enabled && !artnet)
	{
		StartArtnet();
	}
	else if (!enabled)
	{
		if (artnet)
		{
			artnet_stop(artnet);
			artnet_destroy(artnet);
			artnet = NULL;
		}
	}
}

void Dmx::SetValue(unsigned int port, unsigned int address, uint8_t value)
{
	if (address < 512)
		data[port % 16][address] = value;

	sendUpdate[port % 16] = 2;
}

void Dmx::SetInterfaceIp(const char* newIp)
{
	if (!newIp || !strcmp(newIp, ""))
		ip[0] = 0;
	else
		strncpy(ip, newIp, 32);
}

int Dmx::StartArtnet()
{
	if (artnet)
	{
		artnet_stop(artnet);
		artnet_destroy(artnet);
	}

	artnet = artnet_new(ip[0] ? ip : NULL, 0);
	if (artnet == NULL) {
		fprintf(stderr, "Failed to create Art-Net node, new\n");
		return 1;
	}

	artnet_set_short_name(artnet, "LaserShowGen");
	artnet_set_long_name(artnet, "LaserShowGen Artnet Output");
	artnet_set_node_type(artnet, ARTNET_SRV);

	// set the first port to input dmx data
	artnet_set_port_type(artnet, 0, ARTNET_ENABLE_INPUT, ARTNET_PORT_DMX);
	//artnet_set_subnet_addr(artnet, 0);

	// set the universe address of the first port
	int ret = artnet_start(artnet);
	if (ret != ARTNET_EOK) {
		fprintf(stderr, "Failed to start Art-Net node, start, %d\n", ret);
		artnet_destroy(artnet);
		artnet = NULL;
		return ret;
	}

	for (int i = 0; i < MAX_UNIVERSES; i++)
	{
		isInUse[i] = false;
		sendUpdate[i] = 2;
		nextForcedUpdate[i] = std::chrono::steady_clock::now() + std::chrono::milliseconds(900);
	}
	memset(data, 0, 512 * MAX_UNIVERSES);
}

void Dmx::TxThread()
{
	while (!closed)
	{
		std::this_thread::sleep_for(std::chrono::milliseconds(18));

		std::lock_guard<std::mutex>lock(lock);

		if (artnet)
		{
			auto now = std::chrono::steady_clock::now();

			for (int i = 0; i < MAX_UNIVERSES; i++)
			{
				if (sendUpdate[i] > 0 || nextForcedUpdate[i] > now)
				{
					artnet_send_dmx(artnet, i, 512, data[i]);

					if (sendUpdate[i] > 0)
						sendUpdate[i]--;
					nextForcedUpdate[i] = now + std::chrono::milliseconds(900);
				}
			}
		}
	}

	// Cleanup
	if (artnet)
	{
		artnet_stop(artnet);
		artnet_destroy(artnet);
	}
}
