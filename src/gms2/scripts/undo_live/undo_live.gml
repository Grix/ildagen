function undo_live() {
	with (livecontrol)
	{
	    if (ds_list_empty(undo_list))
	        exit;
    
	    undo = ds_list_find_value(undo_list,ds_list_size(undo_list)-1);
	    ds_list_delete(undo_list,ds_list_size(undo_list)-1);
    
	    if (string_char_at(undo,0) == "c")
	    {
	        //undo create object (delete)
	        selectedfile = real(string_digits(undo));
	
			redolisttemp = ds_list_create_pool();
			ds_list_add(redolisttemp,filelist[| selectedfile]);
			ds_list_add(redolisttemp,selectedfile);
			ds_list_add(redo_list,"d"+string(redolisttemp));
	
			ds_list_delete(filelist, selectedfile);
	
			selectedfile = -1;
			if (surface_exists(browser_surf))
				surface_free(browser_surf);
			browser_surf = -1;
			playing = 0;
			frame_surf_refresh = 1;
	    }
	    else if (string_char_at(undo,0) == "d")
	    {
	        //undo delete object
	        undolisttemp = real(string_digits(undo));
			if (!ds_list_exists_pool(undolisttemp))
	            exit;
	        objectlist = ds_list_find_value(undolisttemp,0);
	        var t_index = ds_list_find_value(undolisttemp,1);

	        ds_list_insert(filelist,t_index,objectlist);
			
			ds_list_add(redo_list, "c"+string(t_index));
			
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
