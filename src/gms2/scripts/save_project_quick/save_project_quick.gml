//exports project into igp file

playing = 0;
if (song != -1)
	FMODGMS_Chan_PauseChannel(play_sndchannel);
    
save_buffer = buffer_create(1,buffer_grow,1);

if (filepath != "")
	file_loc = filepath;
else
{
	file_loc = get_save_filename_ext("*.igp","example.igp","","Select LaserShowGen project file location");
	if !string_length(file_loc) 
	    exit;
    
	if (filename_ext(file_loc) != ".igp")
	    show_message_new("Warning: Your filename has no .igp extension, and might not be recognized by other software.\n\nIt is recommended to save the file again, with a the text .igp at the end of the name.");
}

length = ceil(length);

global.loadingtimeprev = get_timer();

global.loading_saveproject = 1;

global.loading_start = 0;
global.loading_end = ds_list_size(layer_list);
global.loading_current = global.loading_start;
    
buffer_write(save_buffer,buffer_u8,104); //version / ID
buffer_write(save_buffer,buffer_u8,projectfps); //fps
buffer_write(save_buffer,buffer_u8,(song != -1)); //audio enabled
buffer_write(save_buffer,buffer_u8,parsingaudio); //audio still parsing
buffer_write(save_buffer,buffer_u32,startframe);
buffer_write(save_buffer,buffer_u32,endframe);
buffer_write(save_buffer,buffer_u32,audioshift);
buffer_write(save_buffer,buffer_bool,loop);
buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_u8,0);
repeat (30)
    buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_u32,ds_list_size(layer_list)); //pos 50


room_goto(rm_loading);
