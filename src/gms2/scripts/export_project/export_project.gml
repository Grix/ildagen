//exports project into an ilda file
playing = 0;
if (song != 0)
{
    FMODGMS_Chan_PauseChannel(songinstance);
}

file_loc = get_save_filename_ext("*.ild","example.ild","","Select ILDA file location");
if !string_length(file_loc)
    exit;
    
if (filename_ext(file_loc) != ".ild")
    show_message_new("Warning: Your filename has no .ild extension, and might not be recognized by other software.##It is recommended to save the file again, with a the text .ild at the end of the name.");
    
ilda_buffer = buffer_create(1,buffer_grow,1);
global.loadingtimeprev = get_timer();

global.loading_start = startframe;
global.loading_current = global.loading_start;
global.loading_end = endframe;

maxpointstot = 0;    
maxpoints = 0;

//stupid GM can't choose endian type
maxframespost = endframe-startframe;
maxframesa[0] = maxframespost & 255;
maxframespost = maxframespost >> 8;
maxframesa[1] = maxframespost & 255;

c_n = 0;
c_map = ds_map_create();
var env_dataset = 0;

controller.opt_warning_flag = 0;
global.loading_exportproject = 1;
room_goto(rm_loading);