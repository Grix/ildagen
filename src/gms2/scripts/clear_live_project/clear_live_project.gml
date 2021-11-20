function clear_live_project() {
	
	clean_live_undo();
	clean_redo_live();
    
	repeat (ds_list_size(filelist))
	{
	    selectedfile = 0;
		live_delete_object_noundo();
	}

	selectedfile = -1;
	frame_surf_refresh = 1;
	if (surface_exists(browser_surf))
		surface_free(browser_surf);
	browser_surf = -1;
	frame = 0;
	playing = 0;
	filepath = "";

}
