//reversing timeline objects
for (i = 0; i < ds_list_size(somaster_list); i++)
{
    objectlist = somaster_list[| i];
	if (!ds_exists(objectlist,ds_type_list))
	{
		ds_list_delete(somaster_list, i);
		if (i > 0)
			i--;
		continue;
	}
    
	ds_list_replace(objectlist[| 2], 1, -1); //erase screenshot
	
    el_buffer_new = buffer_create(16,buffer_grow,1);
    el_buffer_old = objectlist[| 1];
	
    buffer_seek(el_buffer, buffer_seek_start, 0);
    bufferformat = buffer_read(el_buffer_old, buffer_u8);
	if (bufferformat != 52)
	{
		show_message_new("Error: Unexpected version id reading buffer while stretching object: "+string(bufferformat)+". Things might get ugly. Contact developer.");
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
		        buffer_seek(el_buffer_old,buffer_seek_relative,50+numofdata*3.25);
		    }
		}
            
		buffer_maxelements = buffer_read(el_buffer_old,buffer_u32);
		buffer_write(el_buffer_new, buffer_u32, buffer_maxelements);
		for (j = 0; j < buffer_maxelements; j++)
		{
			numofdata = buffer_read(el_buffer_old,buffer_u32);
			buffer_write(el_buffer_new, buffer_u32, numofdata);
			buffer_copy(el_buffer_old, buffer_tell(el_buffer_old), 50+(numofdata-20)*3.25, el_buffer_new, buffer_tell(el_buffer_new));
			buffer_seek(el_buffer_new, buffer_seek_relative, 50+(numofdata-20)*3.25);
			buffer_seek(el_buffer_old, buffer_seek_relative, 50+(numofdata-20)*3.25);
		}
	}
	
	buffer_resize(el_buffer_new, buffer_tell(el_buffer_new));

	objectlist[| 1] = el_buffer_new;
	
	//todo add undo
}

timeline_surf_length = 0;

