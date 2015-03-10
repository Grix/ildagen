//exports every element into an ilda file
placing_status = 0;
    
save_buffer = buffer_create(1,buffer_grow,1);

buffer_write(save_buffer,buffer_u8,50);
buffer_write(save_buffer,buffer_s32,maxframes);

for (j = 0; j < maxframes;j++)
    {
    el_list = ds_list_find_value(frame_list,j);
    buffer_write(save_buffer,buffer_s32,ds_list_size(el_list));
    
    for (i = 0; i < ds_list_size(el_list);i++)
        {
        ind_list = ds_list_find_value(el_list,i);
        buffer_write(save_buffer,buffer_s32,ds_list_size(ind_list));
        for (u = 0; u < ds_list_size(ind_list); u++)
            {
            buffer_write(save_buffer,buffer_s32,ds_list_find_value(ind_list,u));
            }
        }
    }

//export
ildastring = "";
buffersize = buffer_tell(save_buffer);


error = 0;
for (i = 0;i < buffersize;i++)
    {
    if (!toArray(i,buffer_peek(save_buffer,i,buffer_u8)))
        {
        if (!error) show_message_async("Error filling file with data, may not save correctly!");
        error = 1;
        }
    }
save(file_loc);

buffer_delete(save_buffer);