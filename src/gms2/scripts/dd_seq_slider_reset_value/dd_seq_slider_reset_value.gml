// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dd_seq_slider_reset_value(){
	with (seqcontrol)
	{
		if (selected_slider == obj_tl_intensity_scale)
			intensity_scale = 1;
		else if (selected_slider == obj_volume)
			volume = 100;
	}
}