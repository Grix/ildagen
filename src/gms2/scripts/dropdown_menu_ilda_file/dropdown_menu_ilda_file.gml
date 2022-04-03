function dropdown_menu_ilda_file() {
	ddobj = instance_create_layer(controller.menu_width_start[0]*controller.dpi_multiplier,0,"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 11;
	    ds_list_add(desc_list,"New ("+get_ctrl_string()+" + N)");
	    ds_list_add(desc_list,"Save frames ("+get_ctrl_string()+" + S)");
	    ds_list_add(desc_list,"Save frames as...");
	    ds_list_add(desc_list,"Load frames... ("+get_ctrl_string()+" + O)");
	    ds_list_add(desc_list,"Export frames as ILDA file...");
	    ds_list_add(desc_list,"Import ILDA file to editor... ("+get_ctrl_string()+" + I)");
	    ds_list_add(desc_list,"Send frames to timeline mode (I)");
		ds_list_add(desc_list,"Send frames to live mode (L)");
		ds_list_add(desc_list,"Load Timeline Mode project...");
		ds_list_add(desc_list,"Load Live Mode grid...");
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,1);
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,1);
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,1);
		ds_list_add(sep_list,0);
		ds_list_add(sep_list,1);
		ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_ilda_clear);
	    ds_list_add(scr_list,save_frames_quick);
	    ds_list_add(scr_list,dd_ilda_saveframes);
	    ds_list_add(scr_list,dd_ilda_loadframes);
	    ds_list_add(scr_list,dd_ilda_exportilda);
	    ds_list_add(scr_list,dd_ilda_importilda);
	    ds_list_add(scr_list,frames_toseq);
		ds_list_add(scr_list,frames_tolive);
		ds_list_add(scr_list,dd_ilda_loadseq);
		ds_list_add(scr_list,dd_ilda_loadlive);
	    ds_list_add(hl_list,1);
	    ds_list_add(hl_list,1);
	    ds_list_add(hl_list,1);
	    ds_list_add(hl_list,1);
	    ds_list_add(hl_list,1);
	    ds_list_add(hl_list,1);
	    ds_list_add(hl_list,1);
		ds_list_add(hl_list,1);
		ds_list_add(hl_list,1);
		ds_list_add(hl_list,1);
	    ds_list_add(desc_list,"Exit");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,exit_confirm);
	    ds_list_add(hl_list,1);
	    event_user(1);
	}



}
