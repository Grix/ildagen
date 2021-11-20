// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function clean_ilda_undo(remaining_count = 0){

with (controller)
{
	while (ds_list_size(undo_list) > remaining_count)
	{
	    show_debug_message("cleaning undo list");
	    undo = ds_list_find_value(undo_list,0);
	    ds_list_delete(undo_list,0);

	    if (is_real(undo))
	    {
	        //nothing
	    }
	    else if (string_char_at(undo,0) == "a")
	    {
	        //nothing
		}
	    else if (string_char_at(undo,0) == "r")
	    {
	        //nothing
	    }
	    else if (string_char_at(undo,0) == "d")
	    {
	        //nothing
	    }
	    else if (string_char_at(undo,0) == "v")
	    {
	        if (!ds_list_exists(real(string_digits(undo))))
	            continue;
	        ds_list_destroy(real(string_digits(undo)));
	    }
	    else if (string_char_at(undo,0) == "b")
	    {
	        if (!ds_list_exists(real(string_digits(undo))))
	            continue;
	        ds_list_destroy(real(string_digits(undo)));
	    }
	    else if (string_char_at(undo,0) == "k")
	    {
	        //undo reapply elements
	        if (!ds_list_exists(real(string_digits(undo))))
	            continue;
	        tempundolist = real(string_digits(undo));
	        for (u = 0;u < ds_list_size(tempundolist);u++)
	        {
	            list = ds_list_find_value(tempundolist,u);
	            if (ds_list_exists(list))
	                ds_list_destroy(list);
	        }
	        ds_list_destroy(tempundolist);
	    }
	    else if (string_char_at(undo,0) == "l")
	    {
	        //undo delete
	        if (!ds_list_exists(real(string_digits(undo))))
	            continue;
	        tempundolist = real(string_digits(undo));
	        for (u = 0;u < ds_list_size(tempundolist);u++)
	        {
	            list = ds_list_find_value(tempundolist,u);
	            if (ds_list_exists(list))
	                ds_list_destroy(list);
	        }
	        ds_list_destroy(tempundolist);
	    }
		else if (string_char_at(undo,0) == "s")
		{
			if (!ds_list_exists(real(string_digits(undo))))
		        exit;
		    //undo stretch maxframes
		    tempundolist = real(string_digits(undo));	
	
			for (u = 0; u < ds_list_size(tempundolist); u++)
				ds_list_destroy(tempundolist[| u]);
			ds_list_destroy(tempundolist);
	
			refresh_minitimeline_flag = 1;
		}
	}
}

}