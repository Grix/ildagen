function save_live_project_work() {
	for (i = global.loading_current; i < global.loading_end;i++)
	{
	    if (get_timer()-global.loadingtimeprev >= 100000)
	    {
	        global.loading_current = i;
	        global.loadingtimeprev = get_timer();
	        return 0;
	    }
        
	    objectlist = ds_list_find_value(filelist, i);
	    tempbuffer = ds_list_find_value(objectlist,1);
	    buffer_write(save_buffer, buffer_u32, objectlist[| 0]);
	    buffer_write(save_buffer, buffer_u32, buffer_get_size(tempbuffer));
	    buffer_copy(tempbuffer, 0, buffer_get_size(tempbuffer), save_buffer, buffer_tell(save_buffer));
	    buffer_seek(save_buffer, buffer_seek_relative, buffer_get_size(tempbuffer));
	    buffer_write(save_buffer, buffer_u32, objectlist[| 2]);
	    buffer_write(save_buffer, buffer_u32, objectlist[| 4]);
		buffer_write(save_buffer, buffer_u32, objectlist[| 6]);
		buffer_write(save_buffer, buffer_bool, objectlist[| 7]);
		buffer_write(save_buffer, buffer_bool, objectlist[| 8]);
		buffer_write(save_buffer, buffer_bool, objectlist[| 9]);
		buffer_write(save_buffer, buffer_u8, objectlist[| 10]);
		buffer_write(save_buffer, buffer_bool, 0); // spares
		buffer_write(save_buffer, buffer_bool, 0);
		buffer_write(save_buffer, buffer_bool, 0);
		buffer_write(save_buffer, buffer_u32, 0);
		buffer_write(save_buffer, buffer_u32, 0);
		buffer_write(save_buffer, buffer_u32, 0);
		buffer_write(save_buffer, buffer_string, objectlist[| 11]);
		var t_thisdaclist = objectlist[| 12];
	    buffer_write(save_buffer,buffer_u8,ds_list_size(t_thisdaclist));
	    for (k = 0; k < ds_list_size(t_thisdaclist); k++)
	    {
	        var t_thisdac = t_thisdaclist[| k];
	        buffer_write(save_buffer, buffer_string, string(t_thisdac[| 1])); //dac name
	        buffer_write(save_buffer, buffer_string, string(t_thisdac[| 2])); //profile name
	    }
	}
    
	buffer_resize(save_buffer,buffer_tell(save_buffer));

	//export
	buffer_save(save_buffer,file_loc);

	var t_time = get_timer();
	while ((get_timer() - t_time) > 4095)
	    j = 0;
    
	if (!controller.warning_disable)
		show_message_new("LaserShowGen grid saved to "+string(file_loc));

	buffer_delete(save_buffer);

	filepath = file_loc;

	global.loading_saveliveproject = 0;
	room_goto(rm_live);

	return 1;

}
