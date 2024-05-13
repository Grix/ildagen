// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dd_live_slider_change_midi_shortcut(){
	with (livecontrol)
	{
		if (selected_slider == obj_live_masteralpha)
			masteralpha_midi_shortcut = -1;
		else if (selected_slider == obj_live_masterred)
			masterred_midi_shortcut = -1;
		else if (selected_slider == obj_live_mastergreen)
			mastergreen_midi_shortcut = -1;
		else if (selected_slider == obj_live_masterblue)
			masterblue_midi_shortcut = -1;
		else if (selected_slider == obj_live_masterhue)
			masterhue_midi_shortcut = -1;
		else if (selected_slider == obj_live_masterx)
			masterx_midi_shortcut = -1;
		else if (selected_slider == obj_live_mastery)
			mastery_midi_shortcut = -1;
		else if (selected_slider == obj_live_masterabsrot)
			masterabsrot_midi_shortcut = -1;
		else if (selected_slider == obj_bpm_adjust)
			speed_adjusted_midi_shortcut = -1;
	}
}