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

	if (enabled && !artnet_output)
	{
		StartArtnet();
	}
	else if (!enabled)
	{
		if (artnet_output)
		{
			artnet_stop(artnet_output);
			artnet_destroy(artnet_output);
			artnet_output = NULL;
		}
	}
}

void Dmx::SetValue(unsigned int address, unsigned int index, uint8_t value)
{
	if (index >= 512)
		return;

	data[address & 0xFF][index] = value;
	isInUse[address & 0xFF] = true;
	sendUpdate[address & 0xFF] = 2;
}

void Dmx::SetInterfaceIp(const char* newIp)
{
	if (!newIp || !strcmp(newIp, ""))
		ip[0] = 0;
	else
		strncpy(ip, newIp, 32);

	if (artnet_output)
		StartArtnet(); // Restart to apply
}

int Dmx::StartArtnet()
{
	std::lock_guard<std::mutex>lock(lock);

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

	for (int i = 0; i < MAX_UNIVERSES; i++)
	{
		isInUse[i] = false;
		sendUpdate[i] = 2;
		nextForcedUpdate[i] = std::chrono::steady_clock::now() + std::chrono::milliseconds(900);
	}
	memset(data, 0, 512 * MAX_UNIVERSES);

	return 0;
}

void Dmx::TxThread()
{
	while (!closed)
	{
		std::this_thread::sleep_for(std::chrono::milliseconds(18));

		std::lock_guard<std::mutex>lock(lock);

		if (artnet_output)
		{
			auto now = std::chrono::steady_clock::now();

			for (int i = 0; i < MAX_UNIVERSES; i++)
			{
				if (isInUse[i] && (sendUpdate[i] > 0 || nextForcedUpdate[i] > now))
				{
					artnet_send_dmx(artnet_output, i, 512, data[i]);

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
