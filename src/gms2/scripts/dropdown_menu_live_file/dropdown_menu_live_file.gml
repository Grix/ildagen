function dropdown_menu_live_file() {
	ddobj = instance_create_layer(livecontrol.menu_width_start[0]*controller.dpi_multiplier,0,"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 9;
	    ds_list_add(desc_list,"New grid");
	    ds_list_add(desc_list,"Save grid (Ctrl-S)");
		ds_list_add(desc_list,"Save grid as...");
	    ds_list_add(desc_list,"Load grid");
	    ds_list_add(desc_list,"Import ILDA file");
	    ds_list_add(desc_list,"Import LaserShowGen frames file");
		ds_list_add(desc_list,"Import folder");
	    ds_list_add(desc_list,"Send frames from editor mode (L)");
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,1);
	    ds_list_add(sep_list,0);
		ds_list_add(sep_list,0);
	    ds_list_add(sep_list,1);
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_live_clearproject);
	    ds_list_add(scr_list,dd_live_saveproject_quick);
		ds_list_add(scr_list,dd_live_saveproject);
	    ds_list_add(scr_list,dd_live_loadproject);
	    ds_list_add(scr_list,dd_live_importilda);
	    ds_list_add(scr_list,dd_live_loadframes);
	    ds_list_add(scr_list,dd_live_loadfolder);
	    ds_list_add(scr_list,dd_live_tolive);
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
