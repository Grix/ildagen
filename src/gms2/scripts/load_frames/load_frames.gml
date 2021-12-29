function load_frames(argument0) {
	file_loc = argument0;
	if (string_length(file_loc) < 1 || !is_string(file_loc)) 
	    exit;
    
	//file_copy(file_loc, "temp/temp.igf");
	load_buffer = buffer_load(file_loc);

	if (load_buffer == -1)
	{
		show_message_new("Could not open file at path: "+file_loc);
		exit;
	}
	
	if (buffer_get_size(load_buffer) == 0)
	{
		show_message_new("File is empty, is this a valid LaserShowGen file?");
		exit;
	}

	buffer_seek(load_buffer,buffer_seek_start,0);
	idbyte = buffer_read(load_buffer,buffer_u8);
	if (idbyte != 0) and (idbyte != 50) and (idbyte != 51) and (idbyte != 52)
	{
	    show_message_new("Unexpected ID byte: "+string(idbyte)+", is this a valid LaserShowGen frames file?");
	    exit;
	}

	clear_all();

	ds_list_clear(frame_list);

	el_idmap = ds_map_create();

	//load
	if (idbyte == 0)
	{
	    maxframes = buffer_read(load_buffer,buffer_s32);
	    for (j = 0; j < maxframes;j++)
	    {
	        el_list = ds_list_create();
	        ds_list_add(frame_list,el_list);
        
	        numofelems = buffer_read(load_buffer,buffer_s32);
	        for (i = 0; i < numofelems;i++)
	        {
	            numofinds = buffer_read(load_buffer,buffer_s32);
	            ind_list = ds_list_create();
	            ds_list_add(el_list,ind_list);
	            for (u = 0; u < 50; u++)
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_s32));
	            for (u = 50; u < numofinds; u+=6)
	            {
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_s32));
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_s32));
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_s32));
	                ds_list_add(ind_list,make_colour_rgb(buffer_read(load_buffer,buffer_s32),
	                                                    buffer_read(load_buffer,buffer_s32),
	                                                    buffer_read(load_buffer,buffer_s32)));
	            }
	            repeat (30) ds_list_delete(ind_list,19);
	        }
	    }
	}
	else if (idbyte == 50)
	{
	    maxframes = buffer_read(load_buffer,buffer_u32);
	    for (j = 0; j < maxframes;j++)
	    {
	        el_list = ds_list_create();
	        ds_list_add(frame_list,el_list);
        
	        numofelems = buffer_read(load_buffer,buffer_u32);
	        for (i = 0; i < numofelems;i++)
	        {
	            numofinds = buffer_read(load_buffer,buffer_u32);
	            ind_list = ds_list_create();
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
	            for (u = 10; u < 50; u++)
	            {
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_u8));
	            }
	            for (u = 50; u < numofinds; u += 6)
	            {
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_u8));
	                ds_list_add(ind_list,make_colour_rgb(buffer_read(load_buffer,buffer_u8),
	                                                    buffer_read(load_buffer,buffer_u8),
	                                                    buffer_read(load_buffer,buffer_u8)));
	            }
	            repeat (30) ds_list_delete(ind_list,19);
	        }
	    }
	}
	else if (idbyte == 51)
	{
	    maxframes = buffer_read(load_buffer,buffer_u32);
	    for (j = 0; j < maxframes;j++)
	    {
	        el_list = ds_list_create();
	        ds_list_add(frame_list,el_list);
        
	        numofelems = buffer_read(load_buffer,buffer_u32);
	        for (i = 0; i < numofelems;i++)
	        {
	            numofinds = buffer_read(load_buffer,buffer_u32);
	            ind_list = ds_list_create();
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
	            for (u = 10; u < 50; u++)
	            {
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_bool));
	            }
	            for (u = 50; u < numofinds; u += 6)
	            {
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
	                ds_list_add(ind_list,buffer_read(load_buffer,buffer_bool));
	                ds_list_add(ind_list,make_colour_rgb(buffer_read(load_buffer,buffer_u8),
	                                                    buffer_read(load_buffer,buffer_u8),
	                                                    buffer_read(load_buffer,buffer_u8)));
	            }
	            repeat (30) ds_list_delete(ind_list,19);
	        }
	    }
	}
	else if (idbyte == 52)
	{
	    maxframes = buffer_read(load_buffer,buffer_u32);
	    for (j = 0; j < maxframes;j++)
	    {
	        el_list = ds_list_create();
	        ds_list_add(frame_list,el_list);
        
	        numofelems = buffer_read(load_buffer,buffer_u32);
	        for (i = 0; i < numofelems;i++)
	        {
	            numofinds = buffer_read(load_buffer,buffer_u32);
	            ind_list = ds_list_create();
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
	}    
    
	ds_map_destroy(el_idmap);
    
	el_id++;
	buffer_delete(load_buffer);
	scope_start = 0;
	scope_end = maxframes-1;
	ilda_cancel();
	ds_list_clear(semaster_list);
	frame = 0;
	framehr = 0;
	//filepath = file_loc;


}
