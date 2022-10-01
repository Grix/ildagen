function dropdown_audio_timeline() {
	ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 1;
	    ds_list_add(desc_list,"Adjust audio analysis frequency thresholds");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_seq_adjust_fft_cutoffs);
	    ds_list_add(hl_list,1);
	    event_user(1);
	}

}
