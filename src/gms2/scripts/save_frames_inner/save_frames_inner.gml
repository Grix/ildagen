function save_frames_inner(t_file_loc) {
	//exports the frames from the ilda editor into an igf file
	placing_status = 0;

	file_loc = t_file_loc;
	keyboard_clear(keyboard_lastkey);
	keyboard_clear(vk_control);
	mouse_clear(mouse_lastbutton);
	if (string_length(file_loc) < 1 || !is_string(file_loc)) 
	    exit;
    
	if (filename_ext(file_loc) != ".igf")
		file_loc += ".igf";
	    //show_message_new("Warning: Your filename has no .igf extension, and might not be recognized when trying to load it.\n\nIt is recommended to save the file again, with a the text .igf at the end of the name.");
    
	save_buffer = buffer_create(1,buffer_grow,1);

	buffer_write(save_buffer,buffer_u8,52);
	buffer_write(save_buffer,buffer_u32,maxframes);

	for (j = 0; j < maxframes;j++)
	{
	    el_list = ds_list_find_value(frame_list,j);
	    buffer_write(save_buffer,buffer_u32,ds_list_size(el_list));
    
	    for (i = 0; i < ds_list_size(el_list);i++)
	    {
	        ind_list = ds_list_find_value(el_list,i);
			if (!ds_list_exists(ind_list))
			{
				if (!controller.bug_report_suppress)
				{
					controller.bug_report_suppress = true;
					show_message_new("Unexpected error, attempting to salvage data.");
				
					http_post_string(   "https://www.bitlasers.com/lasershowgen/bugreport.php",
				            "bug=OS: " + string(os_type) + " VER: "+string(controller.version) + "\r\n"+"MISSING ind_list in save_frames. el_list id: "+string(is_undefined(ind_list))+", id: "+string(i));
				}
				ind_list = ds_list_create();
				repeat (20)
					ds_list_add(ind_list, 0);
			}
			
	        tempsize = ds_list_size(ind_list);
	        buffer_write(save_buffer,buffer_u32,tempsize);
        
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
	            buffer_write(save_buffer,buffer_u32,ds_list_find_value(ind_list,u+3));
	        }
	    }
	}
	//remove excess size
	buffer_resize(save_buffer,buffer_tell(save_buffer));

	//export
	buffer_save(save_buffer,file_loc);

	var t_time = get_timer();
	while ((get_timer() - t_time) > 4095)
	    j = 0;
    
	if (!controller.warning_disable)
		show_message_new("LaserShowGen frames saved to "+string(file_loc));

	buffer_delete(save_buffer);
	filepath = file_loc;
}

