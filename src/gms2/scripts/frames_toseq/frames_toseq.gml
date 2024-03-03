function frames_toseq() {
	//sends editor frames to a timeline object
	if (os_browser != browser_not_a_browser)
	{
	    show_message_new("Sorry, the timeline is not available in the web version");
	    exit;
	}

	if (seqcontrol.selectedlayer = -1) or (ds_list_empty(seqcontrol.layer_list))
	{
	    show_message_new("No timeline position marked, enter timeline mode and select a position by clicking on a layer first.");
	    exit;
	}

	ilda_cancel();
	frame = 0;
	framehr = 0;
    
	//todo check for overlaps

	save_buffer = buffer_create(16,buffer_grow,1);

	buffer_write(save_buffer,buffer_u8,52);
	buffer_write(save_buffer,buffer_u32,maxframes);

	var t_checkpointlist = ds_list_create_pool();

	for (j = 0; j < maxframes;j++)
	{
		if (j % 100 == 0 && j != 0)
			ds_list_add(t_checkpointlist, buffer_tell(save_buffer));
	
	    el_list = ds_list_find_value(frame_list,j);
	    buffer_write(save_buffer,buffer_u32,ds_list_size(el_list));
    
	    for (i = 0; i < ds_list_size(el_list);i++)
	    {
	        ind_list = ds_list_find_value(el_list,i);
	        buffer_write(save_buffer,buffer_u32,ds_list_size(ind_list));
	        tempsize = ds_list_size(ind_list);
        
	        for (u = 0; u < 10; u++)
	        {
	            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u));
	        }
	        for (u = 10; u < 20; u++)
	        {
	            buffer_write(save_buffer,buffer_bool,ds_list_find_value(ind_list,u));
	        }
	        for (u = 20; u < tempsize; u += 4)
	        {
	            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u));
	            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u+1));
	            buffer_write(save_buffer,buffer_bool,ds_list_find_value(ind_list,u+2));
	            buffer_write(save_buffer,buffer_u32,ds_list_find_value(ind_list,u+3));
	        }
	    }
	}
	//remove excess size
	buffer_resize(save_buffer, buffer_tell(save_buffer));

	//send to sequencer
	with (seqcontrol)
	{
	    selectedlayerlist = ds_list_find_value(layer_list,selectedlayer);
        
	    if (ds_list_empty(somaster_list) or (ds_list_size(somaster_list) > 1))
	    {
	        objectlist = ds_list_create_pool();
	        ds_list_add(objectlist, selectedx);
	        ds_list_add(objectlist, controller.save_buffer);
	        ds_list_add(objectlist, controller.maxframes-1);
	        ds_list_add(objectlist, -1);
	        ds_list_add(objectlist, controller.maxframes);
			ds_list_add(objectlist, t_checkpointlist);
			
	        ds_list_add(selectedlayerlist[| 1], objectlist);
        
	        ds_list_add(somaster_list,objectlist);
        
	        selectedx += controller.maxframes;
			
			add_action_history_ilda("SEQ_frames_toseq");
			
			undolisttemp = ds_list_create_pool();
			ds_list_add(undolisttemp,objectlist);
			ds_list_add(undo_list,"c"+string(undolisttemp));
	    }
	    else
	    {
	        objectlist = ds_list_find_value(somaster_list,0);
			if (!ds_list_exists_pool(objectlist))
			{
				ds_list_delete(somaster_list, 0);
				{
				    show_message_new("No timeline position marked, enter timeline mode and select a position by clicking on a layer first.");
				    room_goto(rm_seq);
					exit;
				}
			}
	        if (buffer_exists(ds_list_find_value(objectlist,1)))
				buffer_delete(ds_list_find_value(objectlist,1));
	        ds_list_replace(objectlist,1,controller.save_buffer);
        
	        if (surface_exists(ds_list_find_value(objectlist,3)))
	            surface_free(ds_list_find_value(objectlist,3));
	        ds_list_replace(objectlist,3,-1);
			
			if (objectlist[| 2] == objectlist[| 4]-1)
				ds_list_replace(objectlist, 2, controller.maxframes-1);
	        ds_list_replace(objectlist, 4, controller.maxframes);
			if (ds_list_exists_pool(objectlist[| 5]))
				ds_list_free_pool(objectlist[| 5]);
			ds_list_replace(objectlist, 5, create_checkpoint_list(controller.save_buffer));
			
			add_action_history_ilda("SEQ_frames_toseq_replace");
        
			clean_seq_undo();
	    }
        
	}
    
	with (seqcontrol)
	{
	    if (song != -1) 
			FMODGMS_Chan_PauseChannel(play_sndchannel);
	    playing = 0;
		timeline_surf_length = 0;
		show_is_demo = false;
	}
    
	room_goto(rm_seq);



}
