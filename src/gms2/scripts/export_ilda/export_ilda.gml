//exports every element into an ilda file

ilda_cancel();

file_loc = get_save_filename_ext("ILDA Files|*.ild","example.ild","","Select ILDA file location");
keyboard_clear(keyboard_lastkey);
mouse_clear(mouse_lastbutton);
if !string_length(file_loc)
    exit;
    
if (filename_ext(file_loc) != ".ild")
	file_loc += ".ild";
    //show_message_new("Warning: Your filename has no .ild extension, and might not be recognized by other software.\n\nIt is recommended to save the file again, with a the text .ild at the end of the name.");
    
if (!verify_numexports())
{   
    show_message_new("You have unfortunately used up all 20 free exports per day. Try again tomorrow or purchase LaserShowGen Pro");
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

c_n = 0;
c_map = ds_map_create();

room_goto(rm_loading);

