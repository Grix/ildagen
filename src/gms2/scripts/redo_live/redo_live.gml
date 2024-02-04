function redo_live() {
	with (livecontrol)
	{
	    if (ds_list_empty(redo_list))
	        exit;
    
	    redo = ds_list_find_value(redo_list,ds_list_size(redo_list)-1);
	    ds_list_delete(redo_list,ds_list_size(redo_list)-1);
    
	    if (string_char_at(redo,0) == "c")
	    {
	        //redo create object (delete)
	        selectedfile = real(string_digits(redo));
	
			undolisttemp = ds_list_create_pool();
			ds_list_add(undolisttemp,filelist[| selectedfile]);
			ds_list_add(undolisttemp,selectedfile);
			ds_list_add(undo_list,"d"+string(undolisttemp));
	
			ds_list_delete(filelist, selectedfile);
	
			selectedfile = -1;
			if (surface_exists(browser_surf))
				surface_free(browser_surf);
			browser_surf = -1;
			playing = 0;
			frame_surf_refresh = 1;
	    }
	    else if (string_char_at(redo,0) == "d")
	    {
	        //redo delete object
	        redolisttemp = real(string_digits(redo));
			if (!ds_list_exists_pool(redolisttemp))
	            exit;
	        objectlist = ds_list_find_value(redolisttemp,0);
	        var t_index = ds_list_find_value(redolisttemp,1);

	        ds_list_insert(filelist,t_index,objectlist);
			
			ds_list_add(undo_list, "c"+string(t_index));
			
	        ds_list_free_pool(redolisttemp);
	    }
	
		frame_surf_refresh = 1;
		if (surface_exists(browser_surf))
			surface_free(browser_surf);
		browser_surf = -1;
		frame = 0;
	    playing = 0;
	}

}
