for (i = global.loading_current; i < global.loading_end;i++)
{
    if (get_timer()-global.loadingtimeprev >= 100000)
    {
        global.loading_current = i;
        global.loadingtimeprev = get_timer();
        return 0;
    }
        
    //layer objects
    _layer = ds_list_find_value(layer_list,i);
    buffer_write(save_buffer,buffer_u32,ds_list_size(_layer[| 1]));
    for (j = 0; j < ds_list_size(_layer[| 1]); j++)
    {
        objectlist = ds_list_find_value(_layer[| 1],j);
		if (!ds_exists(objectlist, ds_type_list))
		{
			ds_list_delete(_layer[| 1], j);
			if (j > 0)
				j--;
			continue;
		}
        tempframe = ds_list_find_value(objectlist,0);
        tempbuffer = ds_list_find_value(objectlist,1);
        tempinfolist = ds_list_find_value(objectlist,2);
        buffer_write(save_buffer, buffer_u32, tempframe);
        buffer_write(save_buffer, buffer_u32, buffer_get_size(tempbuffer));
        buffer_copy(tempbuffer, 0, buffer_get_size(tempbuffer), save_buffer, buffer_tell(save_buffer));
        buffer_seek(save_buffer, buffer_seek_relative, buffer_get_size(tempbuffer));
        buffer_write(save_buffer, buffer_u32, ds_list_find_value(tempinfolist,0));
        buffer_write(save_buffer, buffer_u32, ds_list_find_value(tempinfolist,2));
    }
        
    //saving envelope info
    var t_env_list = ds_list_find_value(_layer,0);
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
    
    //layer vars
    buffer_write(save_buffer,buffer_u8,_layer[| 2]); //muted
    buffer_write(save_buffer,buffer_u8,_layer[| 3]); //hidden
    buffer_write(save_buffer,buffer_string,_layer[| 4]); //name
	buffer_write(save_buffer,buffer_f32,_layer[| 6]); //preview x offset
	buffer_write(save_buffer,buffer_f32,_layer[| 7]); //preview y offset
	buffer_write(save_buffer,buffer_f32,_layer[| 8]); //preview angle offset
	buffer_write(save_buffer,buffer_f32,_layer[| 9]); //preview fov offset
    repeat (12)
        buffer_write(save_buffer,buffer_u32,0); //reserved
    
    var t_thisdaclist = _layer[| 5];
    buffer_write(save_buffer,buffer_u8,ds_list_size(t_thisdaclist));
    for (k = 0; k < ds_list_size(t_thisdaclist); k++)
    {
        var t_thisdac = t_thisdaclist[| k];
        buffer_write(save_buffer, buffer_string, string(t_thisdac[| 1])); //dac name
        buffer_write(save_buffer, buffer_string, string(t_thisdac[| 2])); //profile name
    }
}

//saving audio data
if (song != -1)
{
    buffer_write(save_buffer, buffer_string, songfile_name);
    songfile_size = buffer_get_size(song_buffer);
    buffer_write(save_buffer, buffer_u32, songfile_size);
    buffer_copy(song_buffer, 0, songfile_size, save_buffer, buffer_tell(save_buffer));
    buffer_seek(save_buffer, buffer_seek_relative, songfile_size);
    
    if (!parsingaudio)
    {
        var t_buffersize = buffer_get_size(audio_buffer);
	    buffer_write(save_buffer,buffer_u32,t_buffersize);
	    buffer_copy(audio_buffer,0,t_buffersize,save_buffer,buffer_tell(save_buffer));
	    buffer_seek(save_buffer,buffer_seek_relative,t_buffersize);
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

var t_time = get_timer();
while ((get_timer() - t_time) > 4095)
    j = 0;
    
show_message_new("LaserShowGen project saved to "+string(file_loc));

buffer_delete(save_buffer);

filepath = file_loc;

global.loading_saveproject = 0;
room_goto(rm_seq);
