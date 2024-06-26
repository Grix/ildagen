function seq_copy_object() {
	//copy timeline object
	if (seqcontrol.selectedlayer == -1) or (ds_list_empty(seqcontrol.somaster_list))
	    exit;
		
		
	add_action_history_ilda("SEQ_copy");

	//clean old clipboard
	for (i = 0; i < ds_list_size(copy_list); i++)
	{
	    if (ds_list_exists_pool(ds_list_find_value(copy_list,i)))
	    {
	        if (buffer_exists(ds_list_find_value( ds_list_find_value(copy_list,i), 1)))
	            buffer_delete(ds_list_find_value( ds_list_find_value(copy_list,i), 1));
	        ds_list_free_pool(ds_list_find_value(copy_list,i));
	    }
	}
	ds_list_clear(copy_list);

	for (i = 0; i < ds_list_size(somaster_list); i++)
	{
	    layertemp = 0;
	    objectlist = ds_list_find_value(somaster_list,i);
		if (!ds_list_exists_pool(objectlist))
		{
			ds_list_delete(somaster_list, i);
			if (i > 0)
				i--;
			continue;
		}
	
	    for (c = 0; c < ds_list_size(layer_list); c++)
	    {
	        if (ds_list_find_index( ds_list_find_value(layer_list[| c],1), objectlist) != -1)    
	        {
	            layertemp = c;
	            break;
	        }
	    }
	    copy_list_new = ds_list_create_pool();
		ds_list_add(copy_list_new, objectlist[| 0]);
	    copy_buffer_new = buffer_create(1,buffer_grow,1);
	    buffer_copy(ds_list_find_value(objectlist,1),
	                0,
	                buffer_get_size(ds_list_find_value(objectlist,1)),
	                copy_buffer_new,
	                0);
		ds_list_add(copy_list_new, copy_buffer_new);
		ds_list_add(copy_list_new, objectlist[| 2]);
		ds_list_add(copy_list_new, -1);
		ds_list_add(copy_list_new, objectlist[| 4]);
		ds_list_add(copy_list_new, -1);
		ds_list_add(copy_list_new, layertemp);
	    ds_list_add(copy_list, copy_list_new);
    
	    if (i == 0)
	    {
	        selectedx = ds_list_find_value(objectlist,0) + ds_list_find_value(objectlist,2)+1;
	    }
	}



}
