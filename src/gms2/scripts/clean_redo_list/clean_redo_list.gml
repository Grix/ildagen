// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function clean_redo_list(){
while (ds_list_size(redo_list) > 0)
{
    show_debug_message("cleaning redo list");
    var redo = ds_list_find_value(redo_list,0);
    ds_list_delete(redo_list,0);

    if (is_real(redo))
    {
        //nothing
    }
    else if (string_char_at(redo,0) == "a")
    {
        //nothing
	}
    else if (string_char_at(redo,0) == "r")
    {
        //nothing
    }
    else if (string_char_at(redo,0) == "d")
    {
        //nothing
    }
    else if (string_char_at(redo,0) == "v")
    {
        if (!ds_list_exists(real(string_digits(redo))))
            continue;
        ds_list_destroy(real(string_digits(redo)));
    }
    else if (string_char_at(redo,0) == "b")
    {
        if (!ds_list_exists(real(string_digits(redo))))
            continue;
        ds_list_destroy(real(string_digits(redo)));
    }
    else if (string_char_at(redo,0) == "k")
    {
        //redo reapply elements
        if (!ds_list_exists(real(string_digits(redo))))
            continue;
        tempredolist = real(string_digits(redo));
        for (u = 0;u < ds_list_size(tempredolist);u++)
        {
            list = ds_list_find_value(tempredolist,u);
            if (ds_list_exists(list))
                ds_list_destroy(list);
        }
        ds_list_destroy(tempredolist);
    }
    else if (string_char_at(redo,0) == "l")
    {
        //redo delete
        if (!ds_list_exists(real(string_digits(redo))))
            continue;
        tempredolist = real(string_digits(redo));
        for (u = 0;u < ds_list_size(tempredolist);u++)
        {
            list = ds_list_find_value(tempredolist,u);
            if (ds_list_exists(list))
                ds_list_destroy(list);
        }
        ds_list_destroy(tempredolist);
    }
	else if (string_char_at(redo,0) == "s")
	{
		if (!ds_list_exists(real(string_digits(redo))))
	        exit;
	    //redo stretch maxframes
	    tempredolist = real(string_digits(redo));	
	
		for (u = 0; u < ds_list_size(tempredolist); u++)
			ds_list_destroy(tempredolist[| u]);
		ds_list_destroy(tempredolist);
	
		refresh_minitimeline_flag = 1;
	}
}
}