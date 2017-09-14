//exports every element into an ilda file
ilda_cancel();

ilda_buffer = buffer_create(1,buffer_grow,1);

maxpoints = 0;
maxpointstot = 0;

maxframespost = maxframes;
maxframesa[0] = maxframespost & 255;
maxframespost = maxframespost >> 8;
maxframesa[1] = maxframespost & 255;

c_n = 0;
c_map = ds_map_create();

global.loadingtimeprev = get_timer();

global.loading_exportildahtml5 = 1;

global.loading_start = 0;
global.loading_current = global.loading_start;
global.loading_end = maxframes;

controller.opt_warning_flag = 0;

room_goto(rm_loading);
