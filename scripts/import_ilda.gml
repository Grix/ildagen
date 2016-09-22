global.loadingtimeprev = get_timer();
ilda_cancel();

with(controller)
    {
    if (read_ilda_init(argument0) == 0) exit;
    //todo catch errors
    
    global.loading_importilda = 1;
    global.loading_start = 0;
    global.loading_end = file_size;
    global.loading_current = global.loading_start;
    }
room_goto(rm_loading);
