//exports every element into an ilda file

ilda_cancel();

file_loc = get_save_filename_ext("*.ild","example.ild","","Select ILDA file location");
if !string_length(file_loc)
    exit;
    
if (!verify_numexports())
{   
    show_message_async("You have unfortunately used up all 10 free exports per day. Try again tomorrow or buy LasershowGen Full");
    exit;
}

ilda_buffer = buffer_create(1,buffer_grow,1);    
    
global.loadingtimeprev = get_timer();

global.loading_exportilda = 1;

global.loading_start = 0;
global.loading_current = global.loading_start;
global.loading_end = maxframes;

maxpoints = 0;
maxpointstot = 0;

maxframespost = maxframes;
maxframesa[0] = maxframespost & 255;
maxframespost = maxframespost >> 8;
maxframesa[1] = maxframespost & 255;

controller.opt_warning_flag = 0;

c_n = 0;
c_map = ds_map_create();

room_goto(rm_loading);

