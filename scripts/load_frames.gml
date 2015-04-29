file_loc = argument0;
if (file_loc == "") or is_undefined(file_loc)
    exit;

FS_file_copy(file_loc,filename_name(file_loc));
    
load_buffer = buffer_load(filename_name(file_loc));
    
idbyte = buffer_read(load_buffer,buffer_u8);
if (idbyte != 0) and (idbyte != 50)
    {
    show_message_async("Unexpected ID byte: "+string(idbyte)+", is this a valid LasershowGen frames file?");
    exit;
    }

//clear
placing_status = 0;
ds_list_clear(free_list);
ds_list_clear(bez_list);
ds_list_clear(semaster_list);

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
if (idbyte == 0)
    {
    maxframes = buffer_read(load_buffer,buffer_s32);
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
    }
else if (idbyte == 50)
    {
    maxframes = buffer_read(load_buffer,buffer_u32);
    for (j = 0; j < maxframes;j++)
        {
        el_list = ds_list_create();
        ds_list_add(frame_list,el_list);
        
        numofelems = buffer_read(load_buffer,buffer_u32);
        for (i = 0; i < numofelems;i++)
            {
            numofinds = buffer_read(load_buffer,buffer_u32);
            ind_list = ds_list_create();
            ds_list_add(el_list,ind_list);
            
            for (u = 0; u < 10; u++)
                {
                ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
                }
            for (u = 10; u < 50; u++)
                {
                ds_list_add(ind_list,buffer_read(load_buffer,buffer_u8));
                }
            for (u = 50; u < numofinds; u += 6)
                {
                ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
                ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
                ds_list_add(ind_list,buffer_read(load_buffer,buffer_u8));
                ds_list_add(ind_list,buffer_read(load_buffer,buffer_u8));
                ds_list_add(ind_list,buffer_read(load_buffer,buffer_u8));
                ds_list_add(ind_list,buffer_read(load_buffer,buffer_u8));
                }
            }
        }
    }
    
buffer_delete(load_buffer);
scope_start = 0;
scope_end = maxframes-1;
