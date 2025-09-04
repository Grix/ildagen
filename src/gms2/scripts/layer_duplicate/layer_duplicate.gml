function layer_duplicate() {
	var t_layer = ds_list_find_value(layer_list,selectedlayer);
	
	newlayer = ds_list_create_pool();
	ds_list_add(layer_list,newlayer);
	
	var t_new_envelope_list = ds_list_create_pool();
	var t_i;
	for (t_i = 0; t_i < ds_list_size(t_layer[| 0]); t_i++)
	{
		var t_new_envelope = ds_list_create_pool();
		ds_list_add(t_new_envelope, t_layer[| 0][| t_i][| 0]);
		
		var t_new_time_list = ds_list_create_pool();
		ds_list_copy(t_new_time_list, t_layer[| 0][| t_i][| 1]);
		ds_list_add(t_new_envelope, t_new_time_list);
		
		var t_new_data_list = ds_list_create_pool();
		ds_list_copy(t_new_data_list, t_layer[| 0][| t_i][| 2]);
		ds_list_add(t_new_envelope, t_new_data_list);
		
		ds_list_add(t_new_envelope, t_layer[| 0][| t_i][| 3]);
		ds_list_add(t_new_envelope, t_layer[| 0][| t_i][| 4]);
		
		ds_list_add(t_new_envelope_list, t_new_envelope);
	}
	ds_list_add(newlayer, t_new_envelope_list);
	
	var t_new_element_list = ds_list_create_pool();
	for (t_i = 0; t_i < ds_list_size(t_layer[| 1]); t_i++)
	{
		var t_new_element = ds_list_create_pool();
		ds_list_add(t_new_element, t_layer[| 1][| t_i][| 0]);
		
		var t_framebuffer = buffer_create(buffer_get_size(t_layer[| 1][| t_i][| 1]), buffer_grow, 1);
		buffer_copy(t_layer[| 1][| t_i][| 1], 0, buffer_get_size(t_layer[| 1][| t_i][| 1]), t_framebuffer, 0);
		ds_list_add(t_new_element, t_framebuffer);
		ds_list_add(t_new_element, t_layer[| 1][| t_i][| 2]);
		ds_list_add(t_new_element, -1);
		ds_list_add(t_new_element, t_layer[| 1][| t_i][| 4]);
		ds_list_add(t_new_element, create_checkpoint_list(t_framebuffer));
		
		
		ds_list_add(t_new_element_list, t_new_element);
	}
	ds_list_add(newlayer, t_new_element_list);
	ds_list_add(newlayer, t_layer[| 2]); 
	ds_list_add(newlayer, t_layer[| 3]);
	ds_list_add(newlayer, t_layer[| 4] + " (Copy)");
	controller.el_id++;
	var t_new_dac_list = ds_list_create_pool();
	for (t_i = 0; t_i < ds_list_size(t_layer[| 5]); t_i++)
	{
		var t_new_dac = ds_list_create_pool();
		ds_list_copy(t_new_dac, t_layer[| 5][| t_i]);
		ds_list_add(t_new_dac_list, t_new_dac);
	}
	ds_list_add(newlayer,t_new_dac_list);
	ds_list_add(newlayer,t_layer[| 6]); 
	ds_list_add(newlayer,t_layer[| 7]);
	ds_list_add(newlayer,t_layer[| 8]); 
	ds_list_add(newlayer,t_layer[| 9]);
	
	var t_new_event_list = ds_list_create_pool();
	for (t_i = 0; t_i < ds_list_size(t_layer[| 10]); t_i++)
	{
		var t_new_event = ds_list_create_pool();
		ds_list_copy(t_new_event, t_layer[| 10][| t_i]);
		ds_list_add(t_new_event_list, t_new_event);
	}

	var t_new_undo_list = ds_list_create_pool();
	ds_list_add(t_new_undo_list, newlayer);
	ds_list_add(t_new_undo_list, selectedlayer);
	ds_list_add(undo_list, "g"+string(t_new_undo_list));
	
	add_action_history_ilda("SEQ_duplicatelayer");
	
	timeline_surf_length = 0;
	clean_redo_list_seq();
	update_dac_list_isused();

}
