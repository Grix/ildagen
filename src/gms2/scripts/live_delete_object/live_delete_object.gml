function live_delete_object() {
	with (livecontrol)
	{
		undolisttemp = ds_list_create_pool();
		ds_list_add(undolisttemp,filelist[| selectedfile]);
		ds_list_add(undolisttemp,selectedfile);
		ds_list_add(undo_list,"d"+string(undolisttemp));
		
		add_action_history_ilda("LIVE_deleteobject");
	
		ds_list_delete(filelist, selectedfile);
	
		selectedfile = -1;
		if (surface_exists(browser_surf))
			surface_free(browser_surf);
		browser_surf = -1;
		playing = 0;
		frame_surf_refresh = 1;
		clean_redo_live();
	}


}
