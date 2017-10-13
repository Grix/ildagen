tlpos = 0;    
playing = 0;
frame_surf_refresh = 1;
timeline_surf_length = 0;
filepath = "";
remove_audio();
ds_list_clear(marker_list);

while (ds_list_size(undo_list))
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
ds_list_destroy(undo_list);
undo_list = ds_list_create();
    
repeat (ds_list_size(layer_list))   
{
    ds_list_clear(somaster_list);
    _layer = ds_list_find_value(layer_list,0);
    elementlist = _layer[| 1];
    for (j = 0; j < ds_list_size(elementlist); j++)
        ds_list_add(somaster_list,ds_list_find_value(elementlist,j));
    seq_delete_object_noundo();
    
    envelope_list = ds_list_find_value(_layer,0);
    num_objects = ds_list_size(envelope_list);
    repeat (num_objects)   
    {
        envelope = ds_list_find_value(envelope_list,0);
        ds_list_destroy(ds_list_find_value(envelope,1));
        ds_list_destroy(ds_list_find_value(envelope,2));
        ds_list_destroy(envelope);
        ds_list_delete(envelope_list,0);
    }
    ds_list_destroy(envelope_list);
    ds_list_destroy(_layer);
    ds_list_delete(layer_list,0);
}

ds_list_clear(somaster_list);
    
selectedx = 0;
selectedlayer = 0;
