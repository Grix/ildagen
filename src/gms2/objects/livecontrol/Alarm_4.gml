/// @description clean undo

alarm[4] = 1200;

while (ds_list_size(undo_list) > 20)
{
    if (ds_list_empty(undo_list))
        exit;
    
    undo = ds_list_find_value(undo_list,0);
    ds_list_delete(undo_list,0);
    
    if (string_char_at(undo,0) == "c")
    {
        // nothing to do
    }
    else if (string_char_at(undo,0) == "d")
    {
        //undo delete object
        undolisttemp = real(string_digits(undo));
		if (!ds_exists(undolisttemp,ds_type_list))
            exit;
        objectlist = ds_list_find_value(undolisttemp,0);
        infolist = objectlist[| 2];
        
		if (surface_exists(infolist[| 1]))
		    surface_free(infolist[| 1]);
            
		if (buffer_exists(objectlist[| 1]))
		    buffer_delete(objectlist[| 1]);
                
		ds_list_find_value(objectlist,0);
		ds_list_destroy(infolist);
		ds_list_destroy(objectlist);
            
        ds_list_destroy(undolisttemp);
    }
}

