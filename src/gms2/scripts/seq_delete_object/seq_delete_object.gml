function seq_delete_object() {
	//delete timeline object
	if ds_list_empty(seqcontrol.somaster_list)
	    exit;
		
	clean_redo_list_seq();
    
	for (k = 0; k < ds_list_size(somaster_list); k++)
	{
		
		add_action_history_ilda("SEQ_delete");
	
		
	    for (c = 0; c < ds_list_size(layer_list); c++)
	    {
	        layerlisttemp = ds_list_find_value(ds_list_find_value(layer_list,c), 1);
	        if (ds_list_find_index(layerlisttemp,ds_list_find_value(somaster_list,k)) != -1)    
	        {
	            objectlist = ds_list_find_value(somaster_list,k);
				if (!ds_list_exists_pool(objectlist))
				{
					ds_list_delete(somaster_list, k);
					if (k > 0)
						k--;
					continue;
				}
            
	            undolisttemp = ds_list_create_pool();
	            ds_list_add(undolisttemp,layerlisttemp);
	            ds_list_add(undolisttemp,objectlist);
	            ds_list_add(undo_list,"d"+string(undolisttemp));
            
	            ds_list_delete(layerlisttemp,ds_list_find_index(layerlisttemp,objectlist));
            
	            if (k == 0)
	            {
	                selectedx = ds_list_find_value(objectlist,0);
	                selectedlayer = c;
	            }
	        }
	    }
	}
    
	ds_list_clear(somaster_list);
	frame_surf_refresh = 1;
	timeline_surf_length = 0;



}
