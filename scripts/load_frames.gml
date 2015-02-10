file_loc = argument0;
if (file_loc == "") or is_undefined(file_loc)
    exit;

if (fastload)
    {
    load_buffer = buffer_load(file_loc);
    }
else
    load_buffer = buffer_load_alt(file_loc);
    
if (buffer_read(load_buffer,buffer_u8) != 0)
    {
    show_message_async("Unexpected byte, is this a valid ildaGen frames file?");
    exit;
    }

//clear
placing_status = 0;
ds_list_clear(free_list);
ds_list_clear(bez_list);
selectedelement = -1;

for (j = 0;j < ds_list_size(frame_list);j++)
    {
    el_list = ds_list_find_value(frame_list,j);
    for (i = 0;i < ds_list_size(el_list);i++)
        {
        list_id = ds_list_find_value(el_list,i);
        ds_list_destroy(list_id);
        }
    ds_list_destroy(el_list);
    }
ds_list_clear(frame_list);
    

framepoints = 0;
framehr = 0;
frame = 0;
maxframes = 1;

frame_surf_refresh = 1;
refresh_miniaudio_flag = 1;

//load
maxframes = buffer_read(load_buffer,buffer_s32);
show_debug_message(maxframes)
for (j = 0; j < maxframes;j++)
    {
    el_list = ds_list_create();
    ds_list_add(frame_list,el_list);
    
    numofelems = buffer_read(load_buffer,buffer_s32);
    for (i = 0; i < numofelems;i++)
        {
        numofinds = buffer_read(load_buffer,buffer_s32);
        ind_list = ds_list_create();
        ds_list_add(el_list,ind_list);
        for (u = 0; u < numofinds; u++)
            {
            ds_list_add(ind_list,buffer_read(load_buffer,buffer_s32));
            }
        }
    }
    
scope_start = 0;
scope_end = maxframes-1;
