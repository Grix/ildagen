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
    ds_list_clear(el_list);
    }
    

framepoints = 0;
frame = 0;
framehr = 0;
maxframes = 1;
scope_start = 0;
scope_end = maxframes-1;
refresh_miniaudio_flag = 1;

frame_surf_refresh = 1;
