with (livecontrol)
{
    if (ds_list_empty(undo_list))
        exit;
    
    undo = ds_list_find_value(undo_list,ds_list_size(undo_list)-1);
    ds_list_delete(undo_list,ds_list_size(undo_list)-1);
    
    if (string_char_at(undo,0) == "c")
    {
        //undo create object (delete)
        playingfile = real(string_digits(undo));
		live_delete_object_noundo();
    }
    else if (string_char_at(undo,0) == "d")
    {
        //undo delete object
        undolisttemp = real(string_digits(undo));
		if (!ds_exists(undolisttemp,ds_type_list))
            exit;
        objectlist = ds_list_find_value(undolisttemp,0);
        var t_index = ds_list_find_value(undolisttemp,1);

		
        ds_list_insert(filelist,t_index,objectlist);
        ds_list_destroy(undolisttemp);
    }
	
	frame_surf_refresh = 1;
	if (surface_exists(browser_surf))
		surface_free(browser_surf);
	browser_surf = -1;
	frame = 0;
    playing = 0;
}
