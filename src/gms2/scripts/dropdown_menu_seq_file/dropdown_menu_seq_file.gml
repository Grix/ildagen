function dropdown_menu_seq_file() {
	ddobj = instance_create_layer(controller.menu_width_start[0],0,"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 9;
	    ds_list_add(desc_list,"New Project");
	    ds_list_add(desc_list,"Save project (Ctrl-S)");
		ds_list_add(desc_list,"Save project as...");
	    ds_list_add(desc_list,"Load project...");
		ds_list_add(desc_list,"Load demo show");
	    ds_list_add(desc_list,"Export project as ILDA file...");
	    ds_list_add(desc_list,"Import ILDA file to timeline...");
	    ds_list_add(desc_list,"Import LaserShowGen frames file to timeline...");
	    ds_list_add(desc_list,"Send frames from editor mode to timeline (I)");
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,1);
	    ds_list_add(sep_list,0);
		ds_list_add(sep_list,0);
		ds_list_add(sep_list,0);
	    ds_list_add(sep_list,1);
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,1);
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_seq_clearproject);
	    ds_list_add(scr_list,dd_seq_saveproject_quick);
		ds_list_add(scr_list,dd_seq_saveproject);
	    ds_list_add(scr_list,dd_seq_loadproject);
		ds_list_add(scr_list,dd_seq_loaddemoproject);
	    ds_list_add(scr_list,dd_seq_exportilda);
	    ds_list_add(scr_list,dd_seq_importilda);
	    ds_list_add(scr_list,dd_seq_importframes);
	    ds_list_add(scr_list,dd_seq_toseq);
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
