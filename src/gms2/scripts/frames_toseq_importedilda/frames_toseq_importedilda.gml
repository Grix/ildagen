function frames_toseq_importedilda() {
	//converts newly imported ilda in ild_list to sequencer object
	if (seqcontrol.selectedlayer = -1) or (!ds_list_empty(seqcontrol.somaster_list)) or (ds_list_empty(seqcontrol.layer_list))
	{
	    show_message_new("No timeline position marked, select a position by clicking on a layer first");
	    exit;
	}
    
	with (seqcontrol)
	{
	    if (song != -1)
			FMODGMS_Chan_PauseChannel(play_sndchannel);
	    playing = 0;
	}
    
	//todo check for overlaps
    
	save_buffer = buffer_create(1,buffer_grow,1);
	buffer_seek(save_buffer,buffer_seek_start,0);

	buffer_write(save_buffer,buffer_u8,52);
	buffer_write(save_buffer,buffer_u32,ds_list_size(ild_list));

	var t_checkpointlist = ds_list_create_pool();

	for (j = 0; j < ds_list_size(ild_list);j++)
	{
		if (j % 100 == 0 && j != 0)
			ds_list_add(t_checkpointlist, buffer_tell(save_buffer));
	
	    buffer_write(save_buffer,buffer_u32,1);

	    ind_list = ds_list_find_value(ild_list,j);
	    tempsize = ds_list_size(ind_list);
	    buffer_write(save_buffer,buffer_u32,tempsize);
    
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
	    ds_list_free_pool(ind_list); ild_list[| j] = -1;
	}
	//remove excess size
	buffer_resize(save_buffer,buffer_tell(save_buffer));

	//send to sequencer
	with (seqcontrol)
	{
	    selectedlayerlist = ds_list_find_value(layer_list,selectedlayer);
    
	    objectlist = ds_list_create_pool();
	    ds_list_add(objectlist, selectedx);
	    ds_list_add(objectlist, controller.save_buffer);
	    ds_list_add(objectlist, ds_list_size(controller.ild_list)-1);
	    ds_list_add(objectlist, -1);
	    ds_list_add(objectlist, ds_list_size(controller.ild_list));
		ds_list_add(objectlist, t_checkpointlist);
        
	    ds_list_add(selectedlayerlist[| 1],objectlist);
    
	    selectedx += ds_list_size(controller.ild_list);
    
		add_action_history_ilda("SEQ_frames_toseq_importedilda");
	
	    undolisttemp = ds_list_create_pool();
	    ds_list_add(undolisttemp,objectlist);
	    ds_list_add(undo_list,"c"+string(undolisttemp));
	
		timeline_surf_length = 0;
		clean_redo_list_seq();
		frame_surf_refresh = 1;
		show_is_demo = false;
	}
    
	ds_list_free_pool(ild_list); ild_list = -1;



}
