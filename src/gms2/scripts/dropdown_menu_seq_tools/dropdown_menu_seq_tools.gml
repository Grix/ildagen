function dropdown_menu_seq_tools() {
	ddobj = instance_create_layer(seqcontrol.menu_width_start[2]*controller.dpi_multiplier,0,"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 8;
	    ds_list_add(desc_list,"Insert timeline marker");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_seq_addmarker);
	    ds_list_add(hl_list,1);
	    ds_list_add(desc_list,"Clear timeline markers");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_seq_clearmarker);
	    ds_list_add(hl_list,!ds_list_empty(seqcontrol.marker_list));
	    ds_list_add(desc_list,"Load audio");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,load_audio);
	    ds_list_add(hl_list,1);
	    ds_list_add(desc_list,"Remove audio");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,remove_audio);
	    ds_list_add(hl_list,1);
		ds_list_add(desc_list,"Add jump point (keyboard shortcut)...");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,add_timeline_jump_point);
	    ds_list_add(hl_list,1);
		ds_list_add(desc_list,"Add jump point (MIDI key)...");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,add_timeline_jump_point_midi);
	    ds_list_add(hl_list,1);
	    ds_list_add(desc_list,"Clear all jump points");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,clear_timeline_jump_points);
	    ds_list_add(hl_list,!ds_list_empty(seqcontrol.jump_button_list));
	    ds_list_add(hl_list,1);
	    ds_list_add(desc_list,"Change BPM");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_change_bpm);
	    ds_list_add(hl_list,controller.use_bpm);
	    event_user(1);
	}



}
