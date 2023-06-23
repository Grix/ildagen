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
	/*with (seqcontrol)
	{
	    _layer = ds_list_find_value(layer_list,selectedlayer);
	    for (j = 1; j < ds_list_size(_layer); j += 3)
	    {
	        infolist = ds_list_find_value(_layer,j+2);
	        frametime = ds_list_find_value(_layer,j);
	        if (selectedx+controller.maxframes = clamp(frametime,tlx,tlx+tlzoom)) 
	        {
	            //frametime-tlx
	            //frametime-tlx+ds_list_find_value(infolist,0);
	        }
	    }
	}*/
	
	var t_file = livecontrol.filelist[| livecontrol.selectedfile];
	
	seqcontrol.selectedlayerlist = seqcontrol.layer_list[| seqcontrol.selectedlayer];
    
	if (ds_list_empty(seqcontrol.somaster_list) or (ds_list_size(seqcontrol.somaster_list) > 1))
	{
		if (seqcontrol.selectedx >= 0)
		{
		    var t_objectlist = ds_list_create();
		    ds_list_add(t_objectlist,seqcontrol.selectedx);
			var t_buffer = buffer_create(buffer_get_size(t_file[| 1]), buffer_fixed, 1);
			buffer_copy(t_file[| 1], 0, buffer_get_size(t_file[| 1]), t_buffer, 0);
		    ds_list_add(t_objectlist, t_buffer);
    
		    var t_info = ds_list_create();
		    ds_list_add(t_info, t_file[| 2][| 0]);
		    ds_list_add(t_info, -1);
		    ds_list_add(t_info, t_file[| 2][| 2]);
			ds_list_add(t_info, create_checkpoint_list(t_buffer));
		    ds_list_add(t_objectlist,t_info);
    
		    ds_list_add(seqcontrol.selectedlayerlist[| 1], t_objectlist);
    
		    seqcontrol.selectedx += t_file[| 2][| 2];
		
			undolisttemp = ds_list_create();
			ds_list_add(undolisttemp,t_objectlist);
			ds_list_add(seqcontrol.undo_list,"c"+string(undolisttemp));
		}
	}
	else
	{
		
		var t_objectlist = ds_list_find_value(seqcontrol.somaster_list, 0);
		if (!ds_list_exists(t_objectlist))
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
		
		var t_infolist = ds_list_find_value(t_objectlist,2);
		
		 if (surface_exists(ds_list_find_value(t_infolist, 1)))
	        surface_free(ds_list_find_value(t_infolist, 1));
			
		if (t_infolist[| 0] == t_infolist[| 2]-1)
			ds_list_replace(t_infolist, 0, t_file[| 2][| 0]);
		ds_list_replace(t_infolist, 1, -1);
		ds_list_replace(t_infolist, 2, t_file[| 2][| 2]);
		
		if (ds_list_exists(t_infolist[| 3]))
			ds_list_destroy(t_infolist[| 3]);
		ds_list_replace(t_infolist, 3, create_checkpoint_list(t_buffer));
		
		
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
