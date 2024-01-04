function dropdown_live_file() {
	ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 8;
	    ds_list_add(desc_list,"Delete (Del)");
	    ds_list_add(desc_list,"Open in frame editor");
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,live_delete_object);
	    ds_list_add(scr_list,dd_live_toilda);
	    ds_list_add(hl_list,1);
	    ds_list_add(hl_list,1);
		var label = "Toggle looping ";
		if (ds_list_find_value(livecontrol.filelist[| livecontrol.selectedfile], 7))
			label += "off (O)";
		else
			label += "on (O)";
		ds_list_add(desc_list,label);
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,live_toggle_loop);
	    ds_list_add(hl_list,1);
		var label = "Toggle exclusive ";
		if (ds_list_find_value(livecontrol.filelist[| livecontrol.selectedfile], 8))
			label += "off (X)";
		else
			label += "on (X)";
		ds_list_add(desc_list,label);
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,live_toggle_exclusive);
	    ds_list_add(hl_list,1);
		var label = "";
		if (ds_list_find_value(livecontrol.filelist[| livecontrol.selectedfile], 9))
			label += "Set restart at play (R)";
		else
			label += "Set resume at play (R)";
		ds_list_add(desc_list,label);
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,live_toggle_resume);
	    ds_list_add(hl_list,1);
		var label = "";
		if (ds_list_find_value(livecontrol.filelist[| livecontrol.selectedfile], 10))
			label += "Set toggle playing (H)";
		else
			label += "Set push to play (H)";
		ds_list_add(desc_list,label);
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,live_toggle_hold);
	    ds_list_add(hl_list,1);
		ds_list_add(desc_list,"Change keyboard shortcut...");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,live_change_shortcut);
	    ds_list_add(hl_list,1);
		ds_list_add(desc_list,"Set name...");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,live_change_tile_name);
	    ds_list_add(hl_list,1);
	
	    event_user(1);
	}



}
