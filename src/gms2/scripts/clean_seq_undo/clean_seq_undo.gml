// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function clean_seq_undo(remaining_count = 0){
	
with (seqcontrol)
{
// todo clean marker move
	while (ds_list_size(undo_list) > remaining_count)
	{
	    log("cleaning undo list");
	    undo = ds_list_find_value(undo_list,0);
	    ds_list_delete(undo_list,0);

	    if (string_char_at(undo,0) == "c")
	    {
	        //undo create object (delete)
	        undolisttemp = real(string_digits(undo));
	        if (!ds_list_exists_pool(undolisttemp))
	            exit;
	        ds_list_free_pool(undolisttemp);
	    }
	    else if (string_char_at(undo,0) == "s")
	    {
	        //undo split
	        undolisttemp = real(string_digits(undo));
			if (!ds_list_exists_pool(undolisttemp))
	            exit;
	        ds_list_free_pool(ds_list_find_value(undolisttemp,0));
	        ds_list_free_pool(undolisttemp);
	    }
		else if (string_char_at(undo,0) == "z")
		{
			//undo merge (only in redo now, opposite of split)
			undolisttemp = real(string_digits(undo));
			if (!ds_list_exists_pool(undolisttemp))
			    exit;
			ds_list_free_pool(ds_list_find_value(undolisttemp,1));
			ds_list_free_pool(ds_list_find_value(undolisttemp,2));
	        ds_list_free_pool(undolisttemp);
		}
	    else if (string_char_at(undo,0) == "d")
	    {
	        //undo delete object
	        undolisttemp = real(string_digits(undo));
	        if (!ds_list_exists_pool(undolisttemp))
	            exit;
	        var t_objectlist = ds_list_find_value(undolisttemp,1);
		    if (!is_undefined(ds_list_find_value(t_objectlist,3)) && surface_exists(ds_list_find_value(t_objectlist,3)))
		        surface_free(ds_list_find_value(t_objectlist,3));
		    if (buffer_exists(ds_list_find_value(t_objectlist,1)))
				buffer_delete(ds_list_find_value(t_objectlist,1));
	        ds_list_free_pool(t_objectlist);
	        ds_list_free_pool(undolisttemp);
	    }
	    else if (string_char_at(undo,0) == "r")
	    {
	        //undo resize object
	        undolisttemp = real(string_digits(undo));
	        if (!ds_list_exists_pool(undolisttemp))
	            exit;
	        ds_list_free_pool(undolisttemp);
	    }
	    else if (string_char_at(undo,0) == "m")
	    {
	        //undo move object
	        undolisttemp = real(string_digits(undo));
	        if (!ds_list_exists_pool(undolisttemp))
	            exit;
	        ds_list_free_pool(undolisttemp);
	    }
	    else if (string_char_at(undo,0) == "l")
	    {
	        //undo marker clear
	        undolisttemp = real(string_digits(undo));
	        if (!ds_list_exists_pool(undolisttemp))
	            exit;
	        ds_list_free_pool(undolisttemp);
	    }
	    else if (string_char_at(undo,0) == "e")
	    {
	        //undo envelope data clear
	        undolisttemp = real(string_digits(undo));
			if (!ds_list_exists_pool(undolisttemp))
	            exit;
			if (!ds_list_exists_pool(ds_list_find_value(undolisttemp,0)))
	            exit;
	        ds_list_free_pool( ds_list_find_value(undolisttemp,0) );
			if (!ds_list_exists_pool(ds_list_find_value(undolisttemp,1)))
	            exit;
	        ds_list_free_pool( ds_list_find_value(undolisttemp,1) );
	        ds_list_free_pool( undolisttemp);
	    }
		else if (string_char_at(undo,0) == "a")
		{
			// nothing
		}
		else if (string_char_at(undo,0) == "k")
		{
			// nothing
		}
		else if (string_char_at(undo,0) == "j")
		{
			// nothing
		}
		else if (string_char_at(undo,0) == "h")
		{
		    //undo move marker
		    undolisttemp = real(string_digits(undo));
			if (!ds_list_exists_pool(undolisttemp))
		        exit;
			ds_list_free_pool(undolisttemp);
		}
		else if (string_char_at(undo,0) == "p")
		{
			// nothing
		}
		else if (string_char_at(undo,0) == "x")
		{
			// undo delete envelope
			undolisttemp = real(string_digits(undo));
			if (!ds_list_exists_pool(undolisttemp))
		        exit;
			
			var t_envelope = undolisttemp[| 0];
			if (!ds_list_exists_pool(t_envelope))
		        exit;
			
			ds_list_free_pool(ds_list_find_value(t_envelope,1));
		    ds_list_free_pool(ds_list_find_value(t_envelope,2));
		    ds_list_free_pool(t_envelope);
		
			ds_list_free_pool(undolisttemp);
		}
		else if (string_char_at(undo,0) == "q")
		{
			// nothing
		}
		else if (string_char_at(undo,0) == "w")
		{
			// nothing
		}
		else if (string_char_at(undo,0) == "i")
		{
	        if (!ds_list_exists_pool(real(string_digits(undo))))
	            continue;
	        ds_list_free_pool(real(string_digits(undo)));
	    }
	}
}

}