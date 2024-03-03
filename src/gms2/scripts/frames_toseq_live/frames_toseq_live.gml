function frames_toseq_live() {
	//sends live mode file to a timeline object
	if (livecontrol.selectedfile < 0 || livecontrol.selectedfile > ds_list_size(livecontrol.filelist)-1)
		exit;
	
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

	//todo check for overlaps
	
	var t_file = livecontrol.filelist[| livecontrol.selectedfile];
	
	seqcontrol.selectedlayerlist = seqcontrol.layer_list[| seqcontrol.selectedlayer];
    
	if (ds_list_empty(seqcontrol.somaster_list) or (ds_list_size(seqcontrol.somaster_list) > 1))
	{
		if (seqcontrol.selectedx >= 0)
		{
		    var t_objectlist = ds_list_create_pool();
		    ds_list_add(t_objectlist,seqcontrol.selectedx);
			var t_buffer = buffer_create(buffer_get_size(t_file[| 1]), buffer_fixed, 1);
			buffer_copy(t_file[| 1], 0, buffer_get_size(t_file[| 1]), t_buffer, 0);
		    ds_list_add(t_objectlist, t_buffer);
		    ds_list_add(t_objectlist, t_file[| 4]-1);
		    ds_list_add(t_objectlist, -1);
		    ds_list_add(t_objectlist, t_file[| 4]);
			ds_list_add(t_objectlist, create_checkpoint_list(t_buffer));
    
		    ds_list_add(seqcontrol.selectedlayerlist[| 1], t_objectlist);
    
		    seqcontrol.selectedx += t_file[| 4];
		
			add_action_history_ilda("SEQ_frames_toseq_fromlive");
		
			undolisttemp = ds_list_create_pool();
			ds_list_add(undolisttemp,t_objectlist);
			ds_list_add(seqcontrol.undo_list,"c"+string(undolisttemp));
		}
	}
	else
	{
		
		var t_objectlist = ds_list_find_value(seqcontrol.somaster_list, 0);
		if (!ds_list_exists_pool(t_objectlist))
		{
			ds_list_delete(seqcontrol.somaster_list, 0);
			{
				show_message_new("No timeline position marked, enter timeline mode and select a position by clicking on a layer first.");
				room_goto(rm_seq);
				exit;
			}
		}
		if (buffer_exists(ds_list_find_value(t_objectlist,1)))
			buffer_delete(ds_list_find_value(t_objectlist,1));
			
		var t_buffer = buffer_create(buffer_get_size(t_file[| 1]), buffer_fixed, 1);
		buffer_copy(t_file[| 1], 0, buffer_get_size(t_file[| 1]), t_buffer, 0);
			
	    ds_list_replace(t_objectlist, 1, t_buffer);
		
		 if (surface_exists(ds_list_find_value(t_objectlist, 3)))
	        surface_free(ds_list_find_value(t_objectlist, 3));
			
		if (t_objectlist[| 2] == t_objectlist[| 4]-1)
			ds_list_replace(t_objectlist, 2, t_file[| 4]-1);
		ds_list_replace(t_objectlist, 3, -1);
		ds_list_replace(t_objectlist, 4, t_file[| 4]);
		
		if (ds_list_exists_pool(t_objectlist[| 5]))
			ds_list_free_pool(t_objectlist[| 5]);
		ds_list_replace(t_objectlist, 5, create_checkpoint_list(t_buffer));
		
		add_action_history_ilda("SEQ_frames_toseq_fromlive_replace");
		
		clean_seq_undo();
	}
    
	with (seqcontrol)
	{
		timeline_surf_length = 0;
		clean_redo_list_seq();
		frame_surf_refresh = 1;
		show_is_demo = false;
		
	    if (song != -1) 
			FMODGMS_Chan_PauseChannel(play_sndchannel);
	    playing = 0;
		timeline_surf_length = 0;
		show_is_demo = false;
	}
    
	room_goto(rm_seq);



}
