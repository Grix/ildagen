function save_project_quick() {
	//exports project into igp file

	if (!verify_serial(true))
	    exit;

	playing = 0;
	if (song != -1)
		FMODGMS_Chan_PauseChannel(play_sndchannel);
    
	save_buffer = buffer_create(1,buffer_grow,1);

	if (filepath != "")
		file_loc = filepath;
	else
	{
		file_loc = get_save_filename_ext("LSG Projects|*.igp","example"+string(current_hour) + "" + string(current_minute)+".igp","","Select LaserShowGen project file location");
		keyboard_clear(keyboard_lastkey);
		keyboard_clear(vk_control);
		mouse_clear(mouse_lastbutton);
		if (string_length(file_loc) < 1 || !is_string(file_loc)) 
		    exit;
    
		if (filename_ext(file_loc) != ".igp")
			file_loc += ".igp";
		    //show_message_new("Warning: Your filename has no .igp extension, and might not be recognized by LSG when you try to load it.\n\nIt is recommended to save the file again, with a the text .igp at the end of the name.");
	}

	length = ceil(length);

	global.loadingtimeprev = get_timer();

	global.loading_saveproject = 1;

	global.loading_start = 0;
	global.loading_end = ds_list_size(layer_list);
	global.loading_current = global.loading_start;
    
	buffer_write(save_buffer,buffer_u8,106); //version / ID
	buffer_write(save_buffer,buffer_u8,projectfps); //fps
	buffer_write(save_buffer,buffer_u8,(song != -1)); //audio enabled
	buffer_write(save_buffer,buffer_u8,parsingaudio); //audio still parsing
	buffer_write(save_buffer,buffer_u32,startframe);
	buffer_write(save_buffer,buffer_u32,endframe);
	buffer_write(save_buffer,buffer_s32,audioshift);
	buffer_write(save_buffer,buffer_bool,loop);
	buffer_write(save_buffer,buffer_bool,controller.use_bpm);
	buffer_write(save_buffer,buffer_u8,controller.bpm);
	buffer_write(save_buffer,buffer_u8,controller.beats_per_bar);
	buffer_write(save_buffer,buffer_f32,beats_shift);
	buffer_write(save_buffer,buffer_u8,volume);
	buffer_write(save_buffer,buffer_u8,!masteralpha_dmx_disable);
	repeat (24)
	    buffer_write(save_buffer,buffer_u8,0);
	buffer_write(save_buffer,buffer_u32,ds_list_size(layer_list)); //pos 50

	last_save_time = get_timer();

	room_goto(rm_loading);




}
