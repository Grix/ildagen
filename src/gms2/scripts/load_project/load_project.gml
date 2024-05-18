function load_project(argument0) {
	//loads project igp file
	file_loc = argument0;
	if (string_length(file_loc) < 1 || !is_string(file_loc)) 
	    exit;
    
	clear_project();

	//file_copy(file_loc, "temp/temp.igp");
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
    
	idbyte = buffer_read(load_buffer,buffer_u8);
	if (idbyte != 105) and (idbyte != 104) and (idbyte != 103) and (idbyte != 100) and (idbyte != 101) and (idbyte != 102)
	{
	    show_message_new("Unexpected ID byte, is this a valid LaserShowGen project file?");
	    exit;
	}
    
	projectfps = buffer_read(load_buffer,buffer_u8);
	controller.projectfps = projectfps;
	songload = buffer_read(load_buffer,buffer_u8);
	parsingaudioload = buffer_read(load_buffer,buffer_u8);
	startframe = buffer_read(load_buffer,buffer_u32);
	endframe = buffer_read(load_buffer,buffer_u32);
	audioshift = buffer_read(load_buffer,buffer_s32);
	
	if (!playlist_start_next_flag)
		loop = buffer_read(load_buffer,buffer_bool);
	else
		buffer_read(load_buffer,buffer_bool); // skip
	
	controller.use_bpm = buffer_read(load_buffer,buffer_bool);
	if (controller.use_bpm)
	{
		controller.bpm = buffer_read(load_buffer,buffer_u8);
		controller.beats_per_bar = buffer_read(load_buffer,buffer_u8);
		beats_shift = buffer_read(load_buffer,buffer_f32);
	}
	else
	{
		buffer_read(load_buffer,buffer_u8); // skip
		buffer_read(load_buffer,buffer_u8);
		buffer_read(load_buffer,buffer_f32);
	}
	
	volume = buffer_read(load_buffer,buffer_u8);
	if (volume == 0 || volume > 100)
		volume = 100;
		
	length = endframe+50;
	buffer_seek(load_buffer,buffer_seek_start,50);

	maxlayers = buffer_read(load_buffer,buffer_u32);
    
	global.loadingtimeprev = get_timer();

	global.loading_loadproject = 1;

	global.loading_start = 0;
	global.loading_end = maxlayers;
	global.loading_current = global.loading_start;

	room_goto(rm_loading);



}
