with (livecontrol)
{
    if (ds_list_empty(undo_list))
        exit;
        //todo
    undo = ds_list_find_value(undo_list,ds_list_size(undo_list)-1);
    ds_list_delete(undo_list,ds_list_size(undo_list)-1);
    
    if (string_char_at(undo,0) == "c")
    {
        //undo create object (delete)
        undolisttemp = real(string_digits(undo));
		if (!ds_exists(undolisttemp,ds_type_list))
            exit;
        objectlist = ds_list_find_value(undolisttemp,0);
        if (!ds_exists(objectlist,ds_type_list))
        {
            ds_list_destroy(undolisttemp);
            exit;
        }
        ds_list_clear(somaster_list);
        ds_list_add(somaster_list,objectlist);
        seq_delete_object_noundo();
        ds_list_destroy(undolisttemp);
    }
    else if (string_char_at(undo,0) == "d")
    {
        //undo delete object
        undolisttemp = real(string_digits(undo));
		if (!ds_exists(undolisttemp,ds_type_list))
            exit;
        objectlist = ds_list_find_value(undolisttemp,1);
        layerlisttemp = ds_list_find_value(undolisttemp,0);
        if (!ds_exists(layerlisttemp,ds_type_list))
        {
            ds_list_destroy(undolisttemp);
            exit;
        }
            
        ds_list_add(layerlisttemp,objectlist);
        ds_list_destroy(undolisttemp);
    }
    
    frame_surf_refresh = 1;
    selectedlayer = 0;
    selectedx = 0;
}
