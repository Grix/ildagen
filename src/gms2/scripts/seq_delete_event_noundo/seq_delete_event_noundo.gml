function seq_delete_event_noundo() {
	//delete timeline event object, no undo
	for (k = 0; k < ds_list_size(selected_event_master_list); k++)
	{
	    for (c = 0; c < ds_list_size(layer_list); c++)
	    {
	        layerlisttemp = ds_list_find_value(ds_list_find_value(layer_list,c), 10);
	        if (ds_list_find_index(layerlisttemp,ds_list_find_value(selected_event_master_list,k)) != -1)    
	        {
	            objectlist = ds_list_find_value(selected_event_master_list,k);
				if (!ds_list_exists_pool(objectlist))
				{
					ds_list_delete(selected_event_master_list,k);
					if (k > 0)
						k--;
					break;
				}
	            ds_list_delete(layerlisttemp,ds_list_find_index(layerlisttemp,objectlist));
        
	            selectedx = ds_list_find_value(objectlist,0);
	            selectedlayer = c;
	            ds_list_free_pool(objectlist); objectlist = -1; selected_event_master_list[|k] = -1;
				
	        }
	    }
	}
    
	ds_list_clear(selected_event_master_list);
	clean_redo_list_seq();
	frame_surf_refresh = 1;



}
