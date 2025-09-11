/// @function seq_add_dmx_interpolate_event(position, layerlist, universe_id, word_index, value);
function seq_add_dmx_interpolate_event(position, layerlist, universe_id, word_index, value)
{
	
	/*if (seqcontrol.selectedlayer = -1) or (ds_list_empty(seqcontrol.layer_list) or (seqcontrol.selectedx < 0))
	{
	    show_message_new("No timeline position marked, enter timeline mode and select a position by clicking on a layer first.");
	    exit;
	}*/
	
	with (seqcontrol)
	{
	    if (song != -1)
			FMODGMS_Chan_PauseChannel(play_sndchannel);
	    playing = 0;
		
		selectedlayerlist = ds_list_find_value(layer_list,selectedlayer);
		
		var t_eventlist = ds_list_create_pool();
		
		ds_list_add(t_eventlist, position);
		ds_list_add(t_eventlist, 0);
		
		if (controller.use_bpm)
			ds_list_add(t_eventlist, (controller.bpm / 60) * controller.projectfps); // one beat
		else
			ds_list_add(t_eventlist, 32);
		
		ds_list_add(t_eventlist, universe_id);
		ds_list_add(t_eventlist, word_index);
		ds_list_add(t_eventlist, value);
		ds_list_add(t_eventlist, -1);
		ds_list_add(t_eventlist, 0);
		ds_list_add(t_eventlist, -1);
		ds_list_add(t_eventlist, 0);
		ds_list_add(t_eventlist, -1);
		ds_list_add(t_eventlist, string(word_index));
		
		if (ds_list_exists(layerlist) && ds_list_exists(layerlist[| 10]))
			ds_list_add(layerlist[| 10], t_eventlist);
		else
			ds_list_destroy(t_eventlist);
			
		undolisttemp = ds_list_create_pool();
		ds_list_add(undolisttemp,t_eventlist);
		ds_list_add(undo_list,"v"+string(undolisttemp));
			
		frame_surf_refresh = 1;
		timeline_surf_length = 0;
		
	}
	
}