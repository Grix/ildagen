// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dd_live_slider_reset_value(){
	with (livecontrol)
	{
		if (selected_slider == obj_live_masteralpha)
			masteralpha = 1;
		else if (selected_slider == obj_live_masterred)
			masterred = 1;
		else if (selected_slider == obj_live_mastergreen)
			mastergreen = 1;
		else if (selected_slider == obj_live_masterblue)
			masterblue = 1;
		else if (selected_slider == obj_live_masterhue)
			masterhue = 255;
		else if (selected_slider == obj_live_masterx)
			masterx = 0;
		else if (selected_slider == obj_live_mastery)
			mastery = 0;
		else if (selected_slider == obj_live_masterabsrot)
			masterabsrot = pi;
	}
}