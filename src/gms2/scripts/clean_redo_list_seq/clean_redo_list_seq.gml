// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function clean_redo_list_seq(){
	while (ds_list_size(redo_list) > 0)
	{
	    redo = ds_list_find_value(redo_list,0);
	    ds_list_delete(redo_list,0);
		
		if (!is_struct(redo))
		{
			show_debug_message("CLEANREDO BUG SEQ, NOT A STRUCT: " + string(redo));
			return;
		}

	    if (string_char_at(redo.undo_id,0) == "c")
	    {
	        //redo create object (delete)
	        redolisttemp = redo.data;
	        if (!ds_list_exists_pool(redolisttemp))
	            exit;
	        ds_list_free_pool(redolisttemp); redolisttemp = -1;
	    }
	    else if (string_char_at(redo.undo_id,0) == "s")
	    {
	        //redo split
	        redolisttemp = redo.data;
			if (!ds_list_exists_pool(redolisttemp))
	            exit;
	        ds_list_free_pool(ds_list_find_value(redolisttemp,0));
	        ds_list_free_pool(redolisttemp); redolisttemp = -1;
	    }
		else if (string_char_at(redo.undo_id,0) == "z")
		{
			//redo merge (only in redo now, opposite of split)
			redolisttemp = redo.data;
			if (!ds_list_exists_pool(redolisttemp))
			    exit;
			ds_list_free_pool(ds_list_find_value(redolisttemp,1));
			ds_list_free_pool(ds_list_find_value(redolisttemp,2));
	        ds_list_free_pool(redolisttemp); redolisttemp = -1;
		}
	    else if (string_char_at(redo.undo_id,0) == "d")
	    {
	        //redo delete object
	        redolisttemp = redo.data;
	        if (!ds_list_exists_pool(redolisttemp))
	            exit;
	        var t_objectlist = ds_list_find_value(redolisttemp,1);
		    if (!is_undefined(ds_list_find_value(t_objectlist,3)) && surface_exists(ds_list_find_value(t_objectlist,3)))
		        surface_free(ds_list_find_value(t_objectlist,3));
		    if (buffer_exists(ds_list_find_value(t_objectlist,1)))
				buffer_delete(ds_list_find_value(t_objectlist,1));
	        ds_list_free_pool(t_objectlist); t_objectlist = -1;
	        ds_list_free_pool(redolisttemp); redolisttemp = -1;
	    }
	    else if (string_char_at(redo.undo_id,0) == "r")
	    {
	        //redo resize object
	        redolisttemp = redo.data;
	        if (!ds_list_exists_pool(redolisttemp))
	            exit;
	        ds_list_free_pool(redolisttemp);
	    }
	    else if (string_char_at(redo.undo_id,0) == "m")
	    {
	        //redo move object
	        redolisttemp = redo.data;
	        if (!ds_list_exists_pool(redolisttemp))
	            exit;
	        ds_list_free_pool(redolisttemp);
	    }
	    else if (string_char_at(redo.undo_id,0) == "l")
	    {
	        //redo marker clear
	        redolisttemp = redo.data;
	        if (!ds_list_exists_pool(redolisttemp))
	            exit;
	        ds_list_free_pool(redolisttemp);
	    }
	    else if (string_char_at(redo.undo_id,0) == "e")
	    {
	        //redo envelope data clear
	        redolisttemp = redo.data;
			if (!ds_list_exists_pool(redolisttemp))
	            exit;
			if (!ds_list_exists_pool(ds_list_find_value(redolisttemp,0)))
	            exit;
	        ds_list_free_pool( ds_list_find_value(redolisttemp,0) );
			if (!ds_list_exists_pool(ds_list_find_value(redolisttemp,1)))
	            exit;
	        ds_list_free_pool( ds_list_find_value(redolisttemp,1) );
	        ds_list_free_pool( redolisttemp);
	    }
		else if (string_char_at(redo.undo_id,0) == "a")
		{
			// nothing
		}
		else if (string_char_at(redo.undo_id,0) == "k")
		{
			// nothing
		}
		else if (string_char_at(redo.undo_id,0) == "j")
		{
			// nothing
		}
		else if (string_char_at(redo.undo_id,0) == "h")
		{
		    //redo move marker
		    redolisttemp = redo.data;
			if (!ds_list_exists_pool(redolisttemp))
		        exit;
			ds_list_free_pool(redolisttemp);
		}
		else if (string_char_at(redo.undo_id,0) == "p")
		{
			// nothing
		}
		else if (string_char_at(redo.undo_id,0) == "x")
		{
			// redo delete envelope
			redolisttemp = redo.data;
			if (!ds_list_exists_pool(redolisttemp))
		        exit;
			
			var t_envelope = redolisttemp[| 0];
			if (!ds_list_exists_pool(t_envelope))
		        exit;
			
			ds_list_free_pool(ds_list_find_value(t_envelope,1));
		    ds_list_free_pool(ds_list_find_value(t_envelope,2));
		    ds_list_free_pool(t_envelope);
		
			ds_list_free_pool(redolisttemp);
		}
		else if (string_char_at(redo.undo_id,0) == "q")
		{
			// nothing
		}
		else if (string_char_at(redo.undo_id,0) == "w")
		{
			// nothing
		}
		else if (string_char_at(redo.undo_id,0) == "i")
		{
	        if (!ds_list_exists_pool(redo.data))
	            continue;
	        ds_list_free_pool(redo.data);
	    }
	}
}