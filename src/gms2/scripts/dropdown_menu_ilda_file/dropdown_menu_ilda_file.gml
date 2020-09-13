function dropdown_menu_ilda_file() {
	ddobj = instance_create_layer(controller.menu_width_start[0]*controller.dpi_multiplier,0,"foreground",obj_dropdown);
	with (ddobj)
	{
		ds_exists(undefined, ds_type_list); //NBNBN TODO todo
	    num = 8;
	    ds_list_add(desc_list,"New");
	    ds_list_add(desc_list,"Save frames (Ctrl-S)"); //todo quicksave
	    ds_list_add(desc_list,"Load frames");
	    ds_list_add(desc_list,"Export frames as ILDA file");
	    ds_list_add(desc_list,"Import ILDA file to editor");
	    ds_list_add(desc_list,"Send frames to timeline mode (I)");
		ds_list_add(desc_list,"Send frames to live mode (L)");
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,1);
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,1);
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,1);
		ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_ilda_clear);
	    ds_list_add(scr_list,dd_ilda_saveframes);
	    ds_list_add(scr_list,dd_ilda_loadframes);
	    ds_list_add(scr_list,dd_ilda_exportilda);
	    ds_list_add(scr_list,dd_ilda_importilda);
	    ds_list_add(scr_list,frames_toseq);
		ds_list_add(scr_list,frames_tolive);
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
