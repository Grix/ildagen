function frames_fromseq() {
	if (os_browser != browser_not_a_browser)
	{
	    show_message_new("Sorry, the timeline is not available in the web version yet");
	    exit;
	}

	if (!verify_serial(true))
	    exit;

	controller.load_buffer = ds_list_find_value(ds_list_find_value(somaster_list,0),1);

	with (controller)
	{
	    buffer_seek(load_buffer,buffer_seek_start,0);
	    idbyte = buffer_read(load_buffer,buffer_u8);
	    if (idbyte != 52)
	    {
	        show_message_new("Unexpected ID byte in frames_fromseq: "+string(idbyte)+", things might get ugly. Contact developer.");
	        exit;
	    }
    
	    //clear
	    clear_all();
    
	    ds_list_clear(frame_list);
    
	    el_idmap = ds_map_create();
    
	    //load
	    maxframes = buffer_read(load_buffer,buffer_u32);
	    for (j = 0; j < maxframes;j++)
	    {
	        el_list = ds_list_create_pool();
	        ds_list_add(frame_list,el_list);
        
	        numofelems = buffer_read(load_buffer,buffer_u32);
	        for (i = 0; i < numofelems;i++)
	        {
	            numofinds = buffer_read(load_buffer,buffer_u32);
	            ind_list = ds_list_create_pool();
	            ds_list_add(el_list,ind_list);
            
	            for (u = 0; u < 9; u++)
	            {
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
	            }
	            el_id_read = buffer_read(load_buffer,buffer_f32);
	            if (ds_map_exists(el_idmap,el_id_read))
	                el_id_real = ds_map_find_value(el_idmap,el_id_read);
	            else
	            {
	                el_id_real = el_id;
	                el_id++;
	                ds_map_add(el_idmap,el_id_read,el_id_real);
	            }
	            ds_list_add(ind_list,el_id_real);
	            for (u = 10; u < 20; u++)
	            {
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_bool));
	            }
	            for (u = 20; u < numofinds; u += 4)
	            {
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_bool));
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_u32));
	            }
	        }
	    }
        
	    scope_start = 0;
	    scope_end = maxframes-1;
	    el_id++;
    
	    ilda_cancel();
	    ds_list_clear(semaster_list);
	    frame = 0;
	    framehr = 0;
		
		add_action_history_ilda("ILDA_frames_fromseq");
		
		clean_redo_list();
    
	    ds_map_destroy(el_idmap);
	}

	if (song != -1) 
		FMODGMS_Chan_PauseChannel(play_sndchannel);
	playing = 0;
	timeline_surf_length = 0;
	frame_surf_refresh = 1;
	room_goto(rm_ilda);



}
