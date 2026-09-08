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
		
		if (!is_struct(undo))
		{
			show_debug_message("CLEANUNDO BUG ILD, NOT A STRUCT: " + string(undo));
			return;
		}
		

	    if (undo.undo_id == "")
	    {
	        //nothing
	    }
	    else if (string_char_at(undo.undo_id,0) == "a")
	    {
	        //nothing
		}
	    else if (string_char_at(undo.undo_id,0) == "r")
	    {
	        //nothing
	    }
	    else if (string_char_at(undo.undo_id,0) == "d")
	    {
	        //nothing
	    }
	    else if (string_char_at(undo.undo_id,0) == "v")
	    {
	        if (!ds_list_exists_pool(undo.data))
	            continue;
	        ds_list_free_pool(undo.data);
	    }
	    else if (string_char_at(undo.undo_id,0) == "b")
	    {
	        if (!ds_list_exists_pool(undo.data))
	            continue;
	        ds_list_free_pool(undo.data);
	    }
	    else if (string_char_at(undo.undo_id,0) == "k")
	    {
	        //undo reapply elements
	        if (!ds_list_exists_pool(undo.data))
	            continue;
	        tempundolist = undo.data;
	        for (u = 0;u < ds_list_size(tempundolist);u++)
	        {
	            list = ds_list_find_value(tempundolist,u);
	            if (ds_list_exists_pool(list))
	            {
					ds_list_free_pool(list); list = -1;
				}
	        }
	        ds_list_free_pool(tempundolist);
	    }
	    else if (string_char_at(undo.undo_id,0) == "l")
	    {
	        //undo delete
	        if (!ds_list_exists_pool(undo.data))
	            continue;
	        tempundolist = undo.data;
	        for (u = 0;u < ds_list_size(tempundolist);u++)
	        {
	            list = ds_list_find_value(tempundolist,u);
	            if (ds_list_exists_pool(list))
	            {
					ds_list_free_pool(list); list = -1;
				}
	        }
	        ds_list_free_pool(tempundolist);
	    }
		else if (string_char_at(undo.undo_id,0) == "s")
		{
			if (!ds_list_exists_pool(undo.data))
		        exit;
		    //undo stretch maxframes
		    tempundolist = undo.data;	
	
			for (u = 0; u < ds_list_size(tempundolist); u++)
				ds_list_free_pool(tempundolist[| u]);
			ds_list_free_pool(tempundolist);
	
			refresh_minitimeline_flag = 1;
		}
		else if (string_char_at(undo.undo_id,0) == "c")
	    {
	        if (!ds_list_exists_pool(undo.data))
	            continue;
	        ds_list_free_pool(undo.data);
	    }
	}
}

}