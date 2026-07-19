// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function clean_redo_list(){
while (ds_list_size(redo_list) > 0)
{
    show_debug_message("cleaning redo list");
    var redo = ds_list_find_value(redo_list,0);
    ds_list_delete(redo_list,0);
	
	if (!is_struct(redo))
	{
		show_debug_message("CLEANREDO BUG ILD, NOT A STRUCT: " + string(redo));
		return;
	}

    if (redo.undo_id == "")
    {
        //nothing
    }
    else if (string_char_at(redo.undo_id,0) == "a")
    {
        //nothing
	}
    else if (string_char_at(redo.undo_id,0) == "r")
    {
        //nothing
    }
    else if (string_char_at(redo.undo_id,0) == "d")
    {
        //nothing
    }
    else if (string_char_at(redo.undo_id,0) == "v")
    {
        if (!ds_list_exists_pool(redo.data))
            continue;
        ds_list_free_pool(redo.data);
    }
    else if (string_char_at(redo.undo_id,0) == "b")
    {
        if (!ds_list_exists_pool(redo.data))
            continue;
        ds_list_free_pool(redo.data);
    }
    else if (string_char_at(redo.undo_id,0) == "k")
    {
        //redo reapply elements
        if (!ds_list_exists_pool(redo.data))
            continue;
        tempredolist = redo.data;
        for (u = 0;u < ds_list_size(tempredolist);u++)
        {
            list = ds_list_find_value(tempredolist,u);
            if (ds_list_exists_pool(list))
			{
                ds_list_free_pool(list); list = -1;
			}
        }
        ds_list_free_pool(tempredolist);
    }
    else if (string_char_at(redo.undo_id,0) == "l")
    {
        //redo delete
        if (!ds_list_exists_pool(redo.data))
            continue;
        tempredolist = redo.data;
        for (u = 0;u < ds_list_size(tempredolist);u++)
        {
            list = ds_list_find_value(tempredolist,u);
            if (ds_list_exists_pool(list))
            {
                ds_list_free_pool(list); list = -1;
			}
        }
        ds_list_free_pool(tempredolist);
    }
	else if (string_char_at(redo.undo_id,0) == "s")
	{
		if (!ds_list_exists_pool(redo.data))
	        exit;
	    //redo stretch maxframes
	    tempredolist = redo.data;	
	
		for (u = 0; u < ds_list_size(tempredolist); u++)
			ds_list_free_pool(tempredolist[| u]);
		ds_list_free_pool(tempredolist);
	
		refresh_minitimeline_flag = 1;
	}
	else if (string_char_at(redo.undo_id,0) == "c")
    {
        if (!ds_list_exists_pool(redo.data))
            continue;
        ds_list_free_pool(redo.data);
    }
}

}