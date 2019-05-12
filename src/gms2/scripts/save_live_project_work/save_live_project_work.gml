for (i = global.loading_current; i < global.loading_end;i++)
{
    if (get_timer()-global.loadingtimeprev >= 100000)
    {
        global.loading_current = i;
        global.loadingtimeprev = get_timer();
        return 0;
    }
        
    //layer objects
    objectlist = ds_list_find_value(filelist, i);
    tempframe = ds_list_find_value(objectlist,0);
    tempbuffer = ds_list_find_value(objectlist,1);
    tempinfolist = ds_list_find_value(objectlist,2);
	var t_shortcut = objectlist[| 3];
    buffer_write(save_buffer, buffer_u32, tempframe);
    buffer_write(save_buffer, buffer_u32, buffer_get_size(tempbuffer));
    buffer_copy(tempbuffer, 0, buffer_get_size(tempbuffer), save_buffer, buffer_tell(save_buffer));
    buffer_seek(save_buffer, buffer_seek_relative, buffer_get_size(tempbuffer));
    buffer_write(save_buffer, buffer_u32, ds_list_find_value(tempinfolist,0));
    buffer_write(save_buffer, buffer_u32, ds_list_find_value(tempinfolist,2));
	buffer_write(save_buffer, buffer_u32, t_shortcut);
}
    
buffer_resize(save_buffer,buffer_tell(save_buffer));

//export
buffer_save(save_buffer,file_loc);

var t_time = get_timer();
while ((get_timer() - t_time) > 4095)
    j = 0;
    
show_message_new("LaserShowGen Live grid saved to "+string(file_loc));

buffer_delete(save_buffer);

filepath = file_loc;

global.loading_saveliveproject = 0;
room_goto(rm_live);
