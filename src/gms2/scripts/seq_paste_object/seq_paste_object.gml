function seq_paste_object() {
	//paste timeline object
	if (!ds_list_exists_pool(copy_list)) or (!ds_list_empty(seqcontrol.somaster_list)) or (ds_list_empty(seqcontrol.layer_list)) or (seqcontrol.selectedlayer = -1)
	    exit;
		
	clean_redo_list_seq();
    
	if (ds_list_size(copy_list) != 0)
	{
		add_action_history_ilda("SEQ_paste");
		
	    ds_list_clear(somaster_list);
		
		if (selectedx > endframe)
			endframe = selectedx;
		pos_ref = endframe+500;
	    layer_ref = ds_list_size(layer_list)-1;
		for (i = 0; i < ds_list_size(copy_list); i++)
	    {
			var t_pos_ref = copy_list[| i][| 0];
	        var t_layer_ref = copy_list[| i][| 6];
			
			if (t_pos_ref < pos_ref)
				pos_ref = t_pos_ref;
			if (t_layer_ref < layer_ref)
				layer_ref = t_layer_ref;
		}
    
	    for (i = 0; i < ds_list_size(copy_list); i++)
	    {
			var t_copy_list_old = copy_list[| i];
			postemp = t_copy_list_old[| 0];
			layertemp = t_copy_list_old[| 6];
			
	        copy_buffer_new = buffer_create(1,buffer_grow,1);
	        buffer_copy(t_copy_list_old[| 1],
	                    0,
	                    buffer_get_size(t_copy_list_old[| 1]),
	                    copy_buffer_new,
	                    0);
        
	        layerlisttemp = ds_list_find_value(layer_list[| clamp(selectedlayer+layertemp-layer_ref,0,ds_list_size(layer_list)-1)], 1);
	        new_objectlist = ds_list_create_pool();
	        new_pos = selectedx + postemp - pos_ref;
	        if (new_pos < 0) new_pos = 0;
	        ds_list_add(new_objectlist,new_pos);
	        ds_list_add(new_objectlist,copy_buffer_new);
	        ds_list_add(new_objectlist,t_copy_list_old[| 2]);
	        ds_list_add(new_objectlist,-1);
	        ds_list_add(new_objectlist,t_copy_list_old[| 4]);
	        ds_list_add(new_objectlist,create_checkpoint_list(copy_buffer_new));
	        ds_list_add(layerlisttemp,new_objectlist);
        
	        undolisttemp = ds_list_create_pool();
	        ds_list_add(undolisttemp,new_objectlist);
	        ds_list_add(undo_list,"c"+string(undolisttemp));
        
	        if (i == 0)
	            selectedxbump = (ds_list_find_value(copy_list_new,2)+1);
	    }
        
	    selectedx += selectedxbump;
	    frame_surf_refresh = 1;
		timeline_surf_length = 0;
	}

	// todo check for collisions and reposition

}
