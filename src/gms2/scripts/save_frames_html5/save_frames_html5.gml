function save_frames_html5() {
	//exports every element into an ilda file
	placing_status = 0;
    
	save_buffer = buffer_create(1,buffer_grow,1);
	buffer_seek(save_buffer,buffer_seek_start,0);

	buffer_write(save_buffer,buffer_u8,52);
	buffer_write(save_buffer,buffer_s32,maxframes);

	for (j = 0; j < maxframes;j++)
	{
	    el_list = ds_list_find_value(frame_list,j);
	    buffer_write(save_buffer,buffer_u32,ds_list_size(el_list));
    
	    for (i = 0; i < ds_list_size(el_list);i++)
	    {
	        ind_list = ds_list_find_value(el_list,i);
	        buffer_write(save_buffer,buffer_u32,ds_list_size(ind_list));
	        tempsize = ds_list_size(ind_list);
        
	        for (u = 0; u < 10; u++)
	        {
	            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u));
	        }
	        for (u = 10; u < 20; u++)
	        {
	            buffer_write(save_buffer,buffer_bool,ds_list_find_value(ind_list,u));
	        }
	        for (u = 20; u < tempsize; u += 4)
	        {
	            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u));
	            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u+1));
	            buffer_write(save_buffer,buffer_bool,ds_list_find_value(ind_list,u+2));
	            buffer_write(save_buffer,buffer_u32,ds_list_find_value(ind_list,u+4));
	        }
	    }
	}

	//export
	buffersize = buffer_tell(save_buffer);

	filesaver_clearArray();

	error = 0;
	for (i = 0;i < buffersize;i++)
	{
	    if (!filesaver_toArray(i,buffer_peek(save_buffer,i,buffer_u8)))
	    {
	        if (!error) show_message_new("Error filling file with data, may not save correctly!");
	        error = 1;
	    }
	}
	filesaver_save(file_loc);

	var t_time = get_timer();
	while ((get_timer() - t_time) > 4095)
	    j = 0;
    
	if (!controller.warning_disable)
		show_message_new("LaserShowGen frames saved to "+string(file_loc));

	buffer_delete(save_buffer);



}
