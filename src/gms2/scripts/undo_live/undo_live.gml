function undo_live() {
	with (livecontrol)
	{
	    if (ds_list_empty(undo_list))
	        exit;
    
	    undo = ds_list_find_value(undo_list,ds_list_size(undo_list)-1);
	    ds_list_delete(undo_list,ds_list_size(undo_list)-1);
		
		if (!is_struct(undo))
		{
			show_debug_message("UNDO BUG LIVE, NOT A STRUCT: " + string(undo));
			return;
		}
		
		add_action_history_ilda("LIVE_undo_"+string(undo.undo_id));
    
	    if (string_char_at(undo.undo_id,0) == "c")
	    {
	        //undo create object (delete)
	        selectedfile = undo.data;
	
			redolisttemp = ds_list_create_pool();
			ds_list_add(redolisttemp,filelist[| selectedfile]);
			ds_list_add(redolisttemp,selectedfile);
			ds_list_add(redo_list, make_undo("d", redolisttemp));
	
			ds_list_delete(filelist, selectedfile);
	
			selectedfile = -1;
			if (surface_exists(browser_surf))
				surface_free(browser_surf);
			browser_surf = -1;
			playing = 0;
			frame_surf_refresh = 1;
	    }
	    else if (string_char_at(undo.undo_id,0) == "d")
	    {
	        //undo delete object
	        undolisttemp = undo.data;
			if (!ds_list_exists_pool(undolisttemp))
	            exit;
	        objectlist = ds_list_find_value(undolisttemp,0);
	        var t_index = ds_list_find_value(undolisttemp,1);

	        ds_list_insert(filelist,t_index,objectlist);
			
			ds_list_add(redo_list, make_undo("c", t_index));
			
	        ds_list_free_pool(undolisttemp); undolisttemp = -1;
	    }
	
		frame_surf_refresh = 1;
		if (surface_exists(browser_surf))
			surface_free(browser_surf);
		browser_surf = -1;
		frame = 0;
	    playing = 0;
	}

}
