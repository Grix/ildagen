// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dd_seq_slider_toggle_dmx_disable(){

	with (seqcontrol)
	{
		if (selected_slider == obj_tl_intensity_scale)
			seqcontrol.masteralpha_dmx_disable = !seqcontrol.masteralpha_dmx_disable;
	}

}