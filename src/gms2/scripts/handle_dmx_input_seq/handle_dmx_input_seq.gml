// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function handle_dmx_input_seq(){

	if (controller.enable_artnet || controller.enable_sacn)
	{
		if (!seqcontrol.masteralpha_dmx_disable)
			seqcontrol.intensity_scale = deadband_highlow(dacwrapper_dmx_getvalue(0)) / 255;
	}

}