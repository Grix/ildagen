function dropdown_audio_timeline() {
	ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 8;
		
	    ds_list_add(desc_list,"Adjust audio analysis frequency thresholds");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_seq_adjust_fft_cutoffs);
	    ds_list_add(hl_list,1);
		ds_list_add(desc_list,"Add marker here");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_seq_addmarker);
	    ds_list_add(hl_list,1);
	    ds_list_add(desc_list,"Clear all markers");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_seq_clearmarker);
	    ds_list_add(hl_list,!ds_list_empty(seqcontrol.marker_list));
		ds_list_add(desc_list,"Set start of show here");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_seq_set_startframe);
	    ds_list_add(hl_list,1);
	    ds_list_add(desc_list,"Set end of show here");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_seq_set_endframe);
	    ds_list_add(hl_list,1);
		ds_list_add(desc_list,"Add jump point (keyboard shortcut)...");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,add_timeline_jump_point);
	    ds_list_add(hl_list,1);
		ds_list_add(desc_list,"Add jump point (MIDI shortcut)...");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,add_timeline_jump_point_midi);
	    ds_list_add(hl_list,1);
	    ds_list_add(desc_list,"Clear all jump points");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,clear_timeline_jump_points);
	    ds_list_add(hl_list,!(ds_list_empty(seqcontrol.jump_button_list) && ds_list_empty(seqcontrol.jump_button_list_midi)));
	    event_user(1);
	}

}
