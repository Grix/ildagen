function clear_project() {
	tlpos = 0;    
	playing = 0;
	frame_surf_refresh = 1;
	timeline_surf_length = 0;
	filepath = "";
	remove_audio();
	ds_list_clear(marker_list);
	clean_redo_list_seq();

	while (ds_list_size(undo_list) > 0)
	{
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
		else if (string_char_at(undo,0) == "z")
		{
			//undo merge (only in redo now, opposite of split)
			undolisttemp = real(string_digits(undo));
			if (!ds_list_exists(undolisttemp))
			    exit;
			ds_list_destroy(ds_list_find_value(undolisttemp,1));
			ds_list_destroy(ds_list_find_value(undolisttemp,2));
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
			if (!ds_list_exists(undolisttemp))
		        exit;
			ds_list_destroy(undolisttemp);
		}
		else if (string_char_at(undo,0) == "p")
		{
			// nothing
		}
		else if (string_char_at(undo,0) == "x")
		{
			// undo delete envelope
			undolisttemp = real(string_digits(undo));
			if (!ds_list_exists(undolisttemp))
		        exit;
			
			var t_envelope = undolisttemp[| 0];
			if (!ds_list_exists(t_envelope))
		        exit;
			
			ds_list_destroy(ds_list_find_value(t_envelope,1));
		    ds_list_destroy(ds_list_find_value(t_envelope,2));
		    ds_list_destroy(t_envelope);
		
			ds_list_destroy(undolisttemp);
		}
		else if (string_char_at(undo,0) == "q")
		{
			// nothing
		}
		else if (string_char_at(undo,0) == "w")
		{
			// nothing
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



}
