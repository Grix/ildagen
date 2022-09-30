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
	    tempinfolist = ds_list_find_value(objectlist,2);
		if (!ds_list_exists(tempinfolist))
		{
			// ERROR: missing list? try to recreate
			var t_newinfo = ds_list_create();
			ds_list_add(t_newinfo,0);
			ds_list_add(t_newinfo,-1);
			ds_list_add(t_newinfo,1);
			ds_list_add(t_newinfo, create_checkpoint_list(objectlist[| 1]));
			ds_list_replace(objectlist, 2, t_newinfo);
			tempinfolist = t_newinfo;
			
			if (!controller.bug_report_suppress)
			{
				controller.bug_report_suppress = true;
				http_post_string(   "https://www.bitlasers.com/lasershowgen/bugreport.php",
		                    "bug=OS: " + string(os_type) + " VER: "+string(controller.version) + "\r\n"+"MISSING infolist in save_live_project_work. Undefined: "+string(is_undefined(tempinfolist))+", file: "+string(i));
			}
		}
	    buffer_write(save_buffer, buffer_u32, objectlist[| 0]);
	    buffer_write(save_buffer, buffer_u32, buffer_get_size(tempbuffer));
	    buffer_copy(tempbuffer, 0, buffer_get_size(tempbuffer), save_buffer, buffer_tell(save_buffer));
	    buffer_seek(save_buffer, buffer_seek_relative, buffer_get_size(tempbuffer));
	    buffer_write(save_buffer, buffer_u32, ds_list_find_value(tempinfolist,0));
	    buffer_write(save_buffer, buffer_u32, ds_list_find_value(tempinfolist,2));
		buffer_write(save_buffer, buffer_u32, objectlist[| 3]);
		buffer_write(save_buffer, buffer_bool, objectlist[| 4]);
		buffer_write(save_buffer, buffer_bool, objectlist[| 5]);
		buffer_write(save_buffer, buffer_bool, objectlist[| 6]);
		buffer_write(save_buffer, buffer_u8, objectlist[| 7]);
		buffer_write(save_buffer, buffer_bool, 0); // spares
		buffer_write(save_buffer, buffer_bool, 0);
		buffer_write(save_buffer, buffer_bool, 0);
		buffer_write(save_buffer, buffer_u32, 0);
		buffer_write(save_buffer, buffer_u32, 0);
		buffer_write(save_buffer, buffer_u32, 0);
	}
    
	buffer_resize(save_buffer,buffer_tell(save_buffer));

	//export
	buffer_save(save_buffer,file_loc);

	var t_time = get_timer();
	while ((get_timer() - t_time) > 4095)
	    j = 0;
    
	if (!controller.warning_disable)
		show_message_new("LaserShowGen Live grid saved to "+string(file_loc));

	buffer_delete(save_buffer);

	filepath = file_loc;

	global.loading_saveliveproject = 0;
	room_goto(rm_live);

	return 1;

}
