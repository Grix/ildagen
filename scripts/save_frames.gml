//exports every element into an ilda file
placing_status = 0;

file_loc = get_save_filename_ext("*.igf","example.igf","","Select ildaGen frames file");
if (file_loc == "")
    exit;
    
save_buffer = buffer_create(1,buffer_grow,1);

buffer_write(save_buffer,buffer_u8,0);
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
//remove excess size
buffer_resize(save_buffer,buffer_tell(save_buffer));

//export
buffer_save(save_buffer,file_loc);
show_message_async("Frames saved.");
buffer_delete(save_buffer);
