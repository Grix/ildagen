//loads project igp file
file_loc = argument0;
if !string_length(file_loc) 
    exit;
    
clear_live_project();

//file_copy(file_loc, "temp/temp.igl");
load_buffer = buffer_load(file_loc);

if (load_buffer == -1)
{
	show_message_new("Could not open file");
	exit;
}
    
idbyte = buffer_read(load_buffer,buffer_u8);
if (idbyte != 200)
{
    show_message_new("Unexpected ID byte, is this a valid LaserShowGen live grid file?");
    exit;
}

selectedfile = -1;
frame_surf_refresh = 1;
if (surface_exists(browser_surf))
	surface_free(browser_surf);
browser_surf = -1;
frame = 0;
playing = 0;
    
controller.projectfps = buffer_read(load_buffer,buffer_u8);
buffer_seek(load_buffer,buffer_seek_start,50);
    
global.loadingtimeprev = get_timer();

global.loading_start = 0;
global.loading_end = buffer_read(load_buffer,buffer_u32);

if (global.loading_end >= 10)
{
	if (!verify_serial(1))
	{
		buffer_delete(load_buffer);
		return;
	}
}

global.loading_loadliveproject = 1;
global.loading_current = global.loading_start;

room_goto(rm_loading);
