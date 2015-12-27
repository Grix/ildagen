//loads project igp file
file_loc = argument0;
if (file_loc == "") or is_undefined(file_loc)
    exit;
    
clear_project();

load_buffer = buffer_load(file_loc);
    
idbyte = buffer_read(load_buffer,buffer_u8);
if (idbyte != 100) and (idbyte != 101) and (idbyte != 102)
    {
    show_message_async("Unexpected ID byte, is this a valid LasershowGen project file?");
    exit;
    }
    
projectfps = buffer_read(load_buffer,buffer_u8);
songload = buffer_read(load_buffer,buffer_u8);
parsingaudioload = buffer_read(load_buffer,buffer_u8);
startframe = buffer_read(load_buffer,buffer_u32);
endframe = buffer_read(load_buffer,buffer_u32);
audioshift = buffer_read(load_buffer,buffer_u32);
length = endframe+50;
buffer_seek(load_buffer,buffer_seek_start,50);

if (idbyte == 101) or (idbyte == 102)
    {
    maxlayers = buffer_read(load_buffer,buffer_u32);
    }
else if (idbyte == 100) //old, need to remake buffers
    {
    maxlayers = buffer_read(load_buffer,buffer_u32);
    }
    
global.loadingtimeprev = get_timer();

global.loading_loadproject = 1;

global.loading_start = 0;
global.loading_end = maxlayers;
global.loading_current = global.loading_start;

room_goto(rm_loading);
