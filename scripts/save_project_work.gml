for (i = global.loading_current; i < global.loading_end;i++)
    {
    if (get_timer()-global.loadingtimeprev >= 100000)
        {
        global.loading_current = i;
        global.loadingtimeprev = get_timer();
        return 0;
        }
        
    layer = ds_list_find_value(layer_list,i);
    buffer_write(save_buffer,buffer_u32,ds_list_size(layer)-1);
    for (j = 1; j < ds_list_size(layer); j++)
        {
        objectlist = ds_list_find_value(layer,j);
        tempframe = ds_list_find_value(objectlist,0);
        tempbuffer = ds_list_find_value(objectlist,1);
        tempinfolist = ds_list_find_value(objectlist,2);
        buffer_write(save_buffer,buffer_u32,tempframe);
        buffer_write(save_buffer,buffer_u32,buffer_get_size(tempbuffer));
        buffer_copy(tempbuffer,0,buffer_get_size(tempbuffer),save_buffer,buffer_tell(save_buffer));
        buffer_seek(save_buffer,buffer_seek_relative,buffer_get_size(tempbuffer));
        buffer_write(save_buffer,buffer_u32,ds_list_find_value(tempinfolist,0));
        buffer_write(save_buffer,buffer_u32,ds_list_find_value(tempinfolist,2));
        }
        
    //saving envelope info
    var t_env_list = ds_list_find_value(layer,0);
    buffer_write(save_buffer,buffer_u32,ds_list_size(t_env_list));
    for (k = 0; k < ds_list_size(t_env_list); k++)
        {
        var t_env = ds_list_find_value(t_env_list,k);
        buffer_write(save_buffer,buffer_string,ds_list_find_value(t_env,0));
        
        var t_time_list = ds_list_find_value(t_env,1);
        parsinglistsize = ds_list_size(t_time_list);
        buffer_write(save_buffer,buffer_u32,parsinglistsize);
        for (u = 0; u < parsinglistsize; u++)
            {
            buffer_write(save_buffer,buffer_u32,ds_list_find_value(t_time_list,u));
            }
        var t_data_list = ds_list_find_value(t_env,2);
        parsinglistsize = ds_list_size(t_data_list);
        buffer_write(save_buffer,buffer_u32,parsinglistsize);
        for (u = 0; u < parsinglistsize; u++)
            {
            buffer_write(save_buffer,buffer_u8,ds_list_find_value(t_data_list,u));
            }
            
        buffer_write(save_buffer,buffer_u8,ds_list_find_value(t_env,3));
        buffer_write(save_buffer,buffer_u8,ds_list_find_value(t_env,4));
        //reserved:
        repeat (5)
            buffer_write(save_buffer,buffer_u8,0);
        }
    }

//saving audio data
if (song)
    {
    buffer_write(save_buffer,buffer_string,songfile_name);
    songfile_size = buffer_get_size(song_buffer);
    buffer_write(save_buffer,buffer_u32,songfile_size);
    buffer_copy(song_buffer,0,songfile_size,save_buffer,buffer_tell(save_buffer));
    buffer_seek(save_buffer,buffer_seek_relative,songfile_size);
    
    if (!parsingaudio)
        {
        buffer_write(save_buffer,buffer_u32,ds_list_size(audio_list));
        parsinglistsize = ds_list_size(audio_list);
        for (i = 0; i < parsinglistsize; i++)
            {
            buffer_write(save_buffer,buffer_f32,ds_list_find_value(audio_list,i));
            }
        }
    }
    
//saving markers
buffer_write(save_buffer,buffer_u32,ds_list_size(marker_list));
parsinglistsize = ds_list_size(marker_list);
for (i = 0; i < parsinglistsize; i++)
    {
    buffer_write(save_buffer,buffer_u32,ds_list_find_value(marker_list,i));
    }
    
buffer_resize(save_buffer,buffer_tell(save_buffer));

//export
buffer_save(save_buffer,file_loc);
//show_message_async("LasershowGen project saved to "+string(file_loc));

for (i = 0; i < 100;i++){}
buffer_delete(save_buffer);

global.loading_saveproject = 0;
room_goto(rm_seq);
