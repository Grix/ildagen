global.loadingtimeprev = get_timer();
ilda_cancel();

with(controller)
{
    filename = get_open_filename_ext("ILDA font file|*.ild|All files|*","",program_directory,"Select ILDA font file")
    if string_length(filename)
    {
        file_copy(filename, "temp/temp.ild");
		ild_file = buffer_load("temp/temp.ild");
        file_size = buffer_get_size(ild_file);
    }
    else
    {
        global.loading_importfont = 0;
        return 0;
    }
        
        
    i = 0;
    if !is_wrong($49)
        return 0;i++;
    if !is_wrong($4C)
        return 0;i++; 
    if !is_wrong($44) 
        return 0;i++;
    if !is_wrong($41) 
        return 0;i++;
    if !is_wrong($0)
        return 0;i++;
    if !is_wrong($0)
        return 0;i++;
    if !is_wrong($0)
        return 0;i=0;
    
    
    filename = "";
    
    i = 0;
    format = 0;
        
    ild_list = ds_list_create();
    
    read_ilda_header_first();
    read_ilda_frame();
    
    //todo catch errors
    global.loading_importfont = 1;
    global.loading_start = 0;
    global.loading_end = file_size;
    global.loading_current = global.loading_start;
}
room_goto(rm_loading);
return 1;
