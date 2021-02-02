/// @description clean undo

alarm[4] = 1200;
// todo clean marker move
while (ds_list_size(undo_list) > 20)
{
    log("cleaning undo list");
    undo = ds_list_find_value(undo_list,0);
    ds_list_delete(undo_list,0);

    if (string_char_at(undo,0) == "c")
    {
        //undo create object (delete)
        undolisttemp = real(string_digits(undo));
        if (!ds_list_exists(undolisttemp))
            exit;
        ds_list_destroy(undolisttemp);
    }
    else if (string_char_at(undo,0) == "s")
    {
        //undo split
        undolisttemp = real(string_digits(undo));
		if (!ds_list_exists(undolisttemp))
            exit;
        ds_list_destroy(ds_list_find_value(undolisttemp,0));
        ds_list_destroy(undolisttemp);
    }
    else if (string_char_at(undo,0) == "d")
    {
        //undo delete object
        undolisttemp = real(string_digits(undo));
        if (!ds_list_exists(undolisttemp))
            exit;
        objectlist = ds_list_find_value(undolisttemp,1);
        infolist = ds_list_find_value(objectlist, 2);
		if (!is_undefined(infolist))
		{
	        if (!is_undefined(ds_list_find_value(infolist,1)) && surface_exists(ds_list_find_value(infolist,1)))
	            surface_free(ds_list_find_value(infolist,1));
	        ds_list_destroy(infolist);
		}
	    if (buffer_exists(ds_list_find_value(objectlist,1)))
			buffer_delete(ds_list_find_value(objectlist,1));
        ds_list_destroy(objectlist);
        ds_list_destroy(undolisttemp);
    }
    else if (string_char_at(undo,0) == "r")
    {
        //undo resize object
        undolisttemp = real(string_digits(undo));
        if (!ds_list_exists(undolisttemp))
            exit;
        ds_list_destroy(undolisttemp);
    }
    else if (string_char_at(undo,0) == "m")
    {
        //undo move object
        undolisttemp = real(string_digits(undo));
        if (!ds_list_exists(undolisttemp))
            exit;
        ds_list_destroy(undolisttemp);
    }
    else if (string_char_at(undo,0) == "l")
    {
        //undo marker clear
        undolisttemp = real(string_digits(undo));
        if (!ds_list_exists(undolisttemp))
            exit;
        ds_list_destroy(undolisttemp);
    }
    else if (string_char_at(undo,0) == "e")
    {
        //undo envelope data clear
        undolisttemp = real(string_digits(undo));
		if (!ds_list_exists(undolisttemp))
            exit;
		if (!ds_list_exists(ds_list_find_value(undolisttemp,0)))
            exit;
        ds_list_destroy( ds_list_find_value(undolisttemp,0) );
		if (!ds_list_exists(ds_list_find_value(undolisttemp,1)))
            exit;
        ds_list_destroy( ds_list_find_value(undolisttemp,1) );
        ds_list_destroy( undolisttemp);
    }
}


