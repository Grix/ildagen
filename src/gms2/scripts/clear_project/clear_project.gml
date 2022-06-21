function clear_project() {
	tlpos = 0;    
	playing = 0;
	frame_surf_refresh = 1;
	timeline_surf_length = 0;
	filepath = "";
	show_is_demo = false;
	remove_audio();
	ds_list_clear(marker_list);
	clean_redo_list_seq();
	clean_seq_undo();
    
	repeat (ds_list_size(layer_list))   
	{
	    ds_list_clear(somaster_list);
	    _layer = ds_list_find_value(layer_list,0);
	    elementlist = _layer[| 1];
	    for (j = 0; j < ds_list_size(elementlist); j++)
	        ds_list_add(somaster_list,ds_list_find_value(elementlist,j));
	    seq_delete_object_noundo();
    
	    envelope_list = ds_list_find_value(_layer,0);
	    num_objects = ds_list_size(envelope_list);
	    repeat (num_objects)   
	    {
	        envelope = ds_list_find_value(envelope_list,0);
	        ds_list_destroy(ds_list_find_value(envelope,1));
	        ds_list_destroy(ds_list_find_value(envelope,2));
	        ds_list_destroy(envelope); envelope = -1;
	        ds_list_delete(envelope_list,0);
	    }
	    ds_list_destroy(envelope_list); envelope_list = -1;
	    ds_list_destroy(_layer); _layer = -1;
	    ds_list_delete(layer_list,0);
	}

	ds_list_clear(somaster_list);
    
	selectedx = 0;
	selectedlayer = 0;
	last_save_time = get_timer();


}
