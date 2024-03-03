function reverse_timelineobject() {
	//reversing timeline objects
	
	for (i = 0; i < ds_list_size(somaster_list); i++)
	{
		add_action_history_ilda("SEQ_reverse");
	
	    objectlist = somaster_list[| i];
		if (!ds_list_exists_pool(objectlist))
		{
			ds_list_delete(somaster_list, i);
			if (i > 0)
				i--;
			continue;
		}
    
		ds_list_replace(objectlist, 3, -1); //erase screenshot
	
	    el_buffer_new = buffer_create(16,buffer_grow,1);
	    el_buffer_old = objectlist[| 1];
	
	    buffer_seek(el_buffer_old, buffer_seek_start, 0);
	    bufferformat = buffer_read(el_buffer_old, buffer_u8);
		if (bufferformat != 52)
		{
			if (!controller.warning_suppress)
				show_message_new("Error: Unexpected version id reading buffer while reversing object: "+string(bufferformat)+". Things might get ugly. Contact developer.");
			controller.warning_suppress = true;
			exit;
		}
	    maxframes = buffer_read(el_buffer_old,buffer_u32);
        
	    buffer_write(el_buffer_new,buffer_u8, bufferformat);
	    buffer_write(el_buffer_new,buffer_u32, maxframes);
	
		//set up frame buffer
		for (n = 0; n < maxframes; n++) //todo this can be optimized
		{
			buffer_seek(el_buffer_old, buffer_seek_start, 5);
			fetchedframe = maxframes - n - 1;
        
			//skip to correct frame
			for (j = 0; j < fetchedframe; j++)
			{
				//log("skippedto", j)
			    numofel = buffer_read(el_buffer_old,buffer_u32);
			    for (u = 0; u < numofel; u++)
			    {
			        numofdata = buffer_read(el_buffer_old,buffer_u32)-20;
			        buffer_seek(el_buffer_old,buffer_seek_relative,50+numofdata*13/4);
			    }
			}
            
			buffer_maxelements = buffer_read(el_buffer_old,buffer_u32);
			buffer_write(el_buffer_new, buffer_u32, buffer_maxelements);
			for (j = 0; j < buffer_maxelements; j++)
			{
				numofdata = buffer_read(el_buffer_old,buffer_u32);
				buffer_write(el_buffer_new, buffer_u32, numofdata);
				buffer_copy(el_buffer_old, buffer_tell(el_buffer_old), 50+(numofdata-20)*13/4, el_buffer_new, buffer_tell(el_buffer_new));
				buffer_seek(el_buffer_new, buffer_seek_relative, 50+(numofdata-20)*13/4);
				buffer_seek(el_buffer_old, buffer_seek_relative, 50+(numofdata-20)*13/4);
			}
		}
	
		buffer_resize(el_buffer_new, buffer_tell(el_buffer_new));

		objectlist[| 1] = el_buffer_new;
		
		if (ds_list_exists_pool(objectlist[| 5]))
			ds_list_free_pool(objectlist[| 5]);
		ds_list_replace(objectlist, 5, create_checkpoint_list(el_buffer_new));
	
		if (argument_count < 1 || argument[0] == true) // don't save undo if arg1 = false
		{
			ds_list_add(undo_list, "a"+string(objectlist));
		}
	}

	clean_redo_list_seq();
	timeline_surf_length = 0;

}
