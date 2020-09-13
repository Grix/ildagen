function save_live_project_quick() {
	//exports project into igp file

	playing = 0;
    
	save_buffer = buffer_create(1,buffer_grow,1);

	if (filepath != "")
		file_loc = filepath;
	else
	{
		file_loc = get_save_filename_ext("LSG Live Grid|*.igl","example.igl","","Select LaserShowGen Live grid file location");
		keyboard_clear(keyboard_lastkey);
		mouse_clear(mouse_lastbutton);
		if !string_length(file_loc) 
		    exit;
    
		if (filename_ext(file_loc) != ".igl")
			file_loc += ".igl";
		    //show_message_new("Warning: Your filename has no .igl extension, and might not be recognized by other software.\n\nIt is recommended to save the file again, with a the text .igl at the end of the name.");
	}

	global.loadingtimeprev = get_timer();

	global.loading_saveliveproject = 1;

	global.loading_start = 0;
	global.loading_end = ds_list_size(filelist);
	global.loading_current = global.loading_start;
    
	buffer_write(save_buffer,buffer_u8,201); //version / ID
	buffer_write(save_buffer,buffer_u8,controller.projectfps); //fps
	buffer_write(save_buffer,buffer_u8,0);
	buffer_write(save_buffer,buffer_u8,0);
	buffer_write(save_buffer,buffer_u8,0);
	buffer_write(save_buffer,buffer_u8,0);
	buffer_write(save_buffer,buffer_u8,0);
	buffer_write(save_buffer,buffer_u8,0);
	buffer_write(save_buffer,buffer_u8,0);
	buffer_write(save_buffer,buffer_u8,0);
	buffer_write(save_buffer,buffer_u8,0);
	buffer_write(save_buffer,buffer_u8,0);
	buffer_write(save_buffer,buffer_u32,0);
	buffer_write(save_buffer,buffer_u8,0);
	buffer_write(save_buffer,buffer_u8,0);
	buffer_write(save_buffer,buffer_u8,0);
	buffer_write(save_buffer,buffer_u8,0);
	repeat (30)
	    buffer_write(save_buffer,buffer_u8,0);
	buffer_write(save_buffer,buffer_u32,ds_list_size(filelist)); //pos 50


	room_goto(rm_loading);



}
