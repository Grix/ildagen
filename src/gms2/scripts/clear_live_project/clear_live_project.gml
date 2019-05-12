/*while (ds_list_size(undo_list))
{
    undo = ds_list_find_value(undo_list,0);
    ds_list_delete(undo_list,0);

    if (string_char_at(undo,0) == "c")
    {
        //undo create object (delete)
        undolisttemp = real(string_digits(undo));
        if (!ds_exists(undolisttemp,ds_type_list))
            exit;
        ds_list_destroy(undolisttemp);
    }
    if (string_char_at(undo,0) == "d")
    {
        //undo delete object
        undolisttemp = real(string_digits(undo));
        if (!ds_exists(undolisttemp,ds_type_list))
            exit;
        objectlist = ds_list_find_value(undolisttemp,1);
		if (!ds_exists(objectlist,ds_type_list))
		{
			exit;
		}
        infolist = ds_list_find_value(objectlist, 2);
        if (surface_exists(ds_list_find_value(infolist,1)))
            surface_free(ds_list_find_value(infolist,1));
        if (buffer_exists(ds_list_find_value(objectlist,1)))
            buffer_delete(ds_list_find_value(objectlist,1));
        ds_list_destroy(infolist);
        ds_list_destroy(objectlist);
        ds_list_destroy(undolisttemp);
    }
    else if (string_char_at(undo,0) == "r")
    {
        //undo resize object
        undolisttemp = real(string_digits(undo));
        if (!ds_exists(undolisttemp,ds_type_list))
            exit;
        ds_list_destroy(undolisttemp);
    }
    else if (string_char_at(undo,0) == "m")
    {
        //undo move object
        undolisttemp = real(string_digits(undo));
        if (!ds_exists(undolisttemp,ds_type_list))
            exit;
        ds_list_destroy(undolisttemp);
    }
    else if (string_char_at(undo,0) == "l")
    {
        //undo marker clear
        undolisttemp = real(string_digits(undo));
        if (!ds_exists(undolisttemp,ds_type_list))
            exit;
        ds_list_destroy(undolisttemp);
    }
}
ds_list_destroy(undo_list);*/
undo_list = ds_list_create();
    
repeat (ds_list_size(filelist))
{
    playingfile = 0;
	live_delete_object_noundo();
}

playingfile = -1;
frame_surf_refresh = 1;
if (surface_exists(browser_surf))
	surface_free(browser_surf);
browser_surf = -1;
frame = 0;
playing = 0;
filepath = "";