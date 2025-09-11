function seq_delete_event() {
	//delete timeline event object
	if ds_list_empty(seqcontrol.selected_event_master_list)
	    exit;
		
	clean_redo_list_seq();
    
	for (k = 0; k < ds_list_size(selected_event_master_list); k++)
	{
		
		add_action_history_ilda("SEQ_delete_event");
	
		
	    for (c = 0; c < ds_list_size(layer_list); c++)
	    {
	        layerlisttemp = ds_list_find_value(ds_list_find_value(layer_list,c), 10);
	        if (ds_list_find_index(layerlisttemp,ds_list_find_value(selected_event_master_list,k)) != -1)    
	        {
	            objectlist = ds_list_find_value(selected_event_master_list,k);
				if (!ds_list_exists_pool(objectlist))
				{
					ds_list_delete(selected_event_master_list, k);
					if (k > 0)
						k--;
					continue;
				}
            
	            undolisttemp = ds_list_create_pool();
	            ds_list_add(undolisttemp,layerlisttemp);
	            ds_list_add(undolisttemp,objectlist);
	            ds_list_add(undo_list,"V"+string(undolisttemp));
            
	            ds_list_delete(layerlisttemp,ds_list_find_index(layerlisttemp,objectlist));
            
	            if (k == 0)
	            {
	                selectedx = ds_list_find_value(objectlist,0);
	                selectedlayer = c;
	            }
	        }
	    }
	}
    
	ds_list_clear(selected_event_master_list);
	frame_surf_refresh = 1;
	timeline_surf_length = 0;



}
