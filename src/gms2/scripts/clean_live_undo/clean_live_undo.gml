// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function clean_live_undo(remaining_count = 0){

with (livecontrol)
{
	while (ds_list_size(undo_list) > remaining_count)
	{
	    if (ds_list_empty(undo_list))
	        exit;
    
	    undo = ds_list_find_value(undo_list,0);
	    ds_list_delete(undo_list,0);
		
		if (!is_struct(undo))
		{
			show_debug_message("CLEANUNDO BUG LIVE, NOT A STRUCT: " + string(undo));
			return;
		}
    
	    if (string_char_at(undo.undo_id,0) == "c")
	    {
	        // nothing to do
	    }
	    else if (string_char_at(undo.undo_id,0) == "d")
	    {
	        //undo delete object
	        undolisttemp = undo.data;
			if (!ds_list_exists_pool(undolisttemp))
	            exit;
	        var t_objectlist = ds_list_find_value(undolisttemp,0);
        
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
            
	        ds_list_free_pool(undolisttemp);
	    }
	}
}


}