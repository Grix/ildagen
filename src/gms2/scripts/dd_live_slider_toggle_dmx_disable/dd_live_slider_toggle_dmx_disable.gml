// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dd_live_slider_toggle_dmx_disable(){
	with (livecontrol)
	{
		if (selected_slider == obj_live_masteralpha)
			masteralpha_dmx_disable = !masteralpha_dmx_disable;
		else if (selected_slider == obj_live_masterred)
			masterred_dmx_disable = !masterred_dmx_disable;
		else if (selected_slider == obj_live_mastergreen)
			mastergreen_dmx_disable = !mastergreen_dmx_disable;
		else if (selected_slider == obj_live_masterblue)
			masterblue_dmx_disable = !masterblue_dmx_disable;
		else if (selected_slider == obj_live_masterhue)
			masterhue_dmx_disable = !masterhue_dmx_disable;
		else if (selected_slider == obj_live_masterx)
			masterx_dmx_disable = !masterx_dmx_disable;
		else if (selected_slider == obj_live_mastery)
			mastery_dmx_disable = !mastery_dmx_disable;
		else if (selected_slider == obj_live_masterabsrot)
			masterabsrot_dmx_disable = !masterabsrot_dmx_disable;
		else if (selected_slider == obj_bpm_adjust)
			speed_adjusted_dmx_disable = !speed_adjusted_dmx_disable;
	}
}