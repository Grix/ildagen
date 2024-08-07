// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function clean_redo_live(){
	
	while (ds_list_size(redo_list) > 0)
	{
	    if (ds_list_empty(redo_list))
	        exit;
    
	    redo = ds_list_find_value(redo_list,0);
	    ds_list_delete(redo_list,0);
    
	    if (string_char_at(redo,0) == "c")
	    {
	        // nothing to do
	    }
	    else if (string_char_at(redo,0) == "d")
	    {
	        //redo delete object
	        redolisttemp = real(string_digits(redo));
			if (!ds_list_exists_pool(redolisttemp))
	            exit;
	        var t_objectlist = ds_list_find_value(redolisttemp,0);
        
			if (surface_exists(t_objectlist[| 3]))
			    surface_free(t_objectlist[| 3]);
            
			if (buffer_exists(t_objectlist[| 1]))
			    buffer_delete(t_objectlist[| 1]);
			
			var t_dac_list = t_objectlist[| 12];
			num_objects = ds_list_size(t_dac_list);
			repeat (num_objects)  
			    ds_list_free_pool(ds_list_find_value(t_dac_list,0));
			ds_list_free_pool(t_dac_list);
			
			ds_list_free_pool(t_objectlist);
            
	        ds_list_free_pool(redolisttemp);
	    }
	}
	
}