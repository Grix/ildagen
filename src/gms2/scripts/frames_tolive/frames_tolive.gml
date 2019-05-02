//sends editor frames to a timeline object
if (os_browser != browser_not_a_browser)
{
    show_message_new("Sorry, the timeline is not available in the web version");
    exit;
}

ilda_cancel();
frame = 0;
framehr = 0;

save_buffer = buffer_create(16,buffer_grow,1);

buffer_write(save_buffer,buffer_u8,52);
buffer_write(save_buffer,buffer_u32,maxframes);

for (j = 0; j < maxframes;j++)
{
    el_list = ds_list_find_value(frame_list,j);
    buffer_write(save_buffer,buffer_u32,ds_list_size(el_list));
    
    for (i = 0; i < ds_list_size(el_list);i++)
    {
        ind_list = ds_list_find_value(el_list,i);
        buffer_write(save_buffer,buffer_u32,ds_list_size(ind_list));
        tempsize = ds_list_size(ind_list);
        
        for (u = 0; u < 10; u++)
        {
            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u));
        }
        for (u = 10; u < 20; u++)
        {
            buffer_write(save_buffer,buffer_bool,ds_list_find_value(ind_list,u));
        }
        for (u = 20; u < tempsize; u += 4)
        {
            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u));
            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u+1));
            buffer_write(save_buffer,buffer_bool,ds_list_find_value(ind_list,u+2));
            buffer_write(save_buffer,buffer_u32,ds_list_find_value(ind_list,u+3));
        }
    }
}
//remove excess size
buffer_resize(save_buffer, buffer_tell(save_buffer));


//send to live
with (livecontrol)
{
	objectlist = ds_list_create();
    ds_list_add(objectlist,0);
    ds_list_add(objectlist,controller.save_buffer);
	info = ds_list_create();
    ds_list_add(info,controller.maxframes-1);
    ds_list_add(info,-1);
    ds_list_add(info,controller.maxframes);
    ds_list_add(objectlist,info);
	
    ds_list_add(filelist,objectlist);
}

with (seqcontrol)
{
    if (song != -1) 
		FMODGMS_Chan_PauseChannel(play_sndchannel);
}
    
room_goto(rm_live);
