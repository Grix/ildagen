function dropdown_menu_live_edit() {
	ddobj = instance_create_layer(livecontrol.menu_width_start[1]*controller.dpi_multiplier,0,"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 5;
	    ds_list_add(desc_list,"Undo ("+get_ctrl_string()+"+Z)");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,undo_live);
	    ds_list_add(hl_list,ds_list_size(livecontrol.undo_list));
		ds_list_add(desc_list,"Redo ("+get_ctrl_string()+"+Y)");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,redo_live);
	    ds_list_add(hl_list,ds_list_size(livecontrol.redo_list));
	    ds_list_add(desc_list,"Delete (Del)");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,live_delete_object);
	    ds_list_add(hl_list,ds_list_size(livecontrol.selectedfile != -1));
	    ds_list_add(desc_list,"Send selected frames to editor mode");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_live_fromlive);
	    ds_list_add(hl_list,ds_list_size(livecontrol.selectedfile != -1));
		ds_list_add(desc_list,"Toggle stop other files at play");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dropdown_menu_live_stop_at_play);
	    ds_list_add(hl_list,livecontrol.stop_at_play);
	    event_user(1);
	}



}
