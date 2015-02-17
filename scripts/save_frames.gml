//exports the frames from the ilda editor into an igf file
placing_status = 0;

file_loc = get_save_filename_ext("*.igf","example.igf","","Select ildaGen frames file location");
if (file_loc == "")
    exit;
    
save_buffer = buffer_create(1,buffer_grow,1);

buffer_write(save_buffer,buffer_u8,50);
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
        for (u = 10; u < 50; u++)
            {
            buffer_write(save_buffer,buffer_u8,0);//ds_list_find_value(ind_list,u));
            }
        for (u = 50; u < tempsize; u += 6)
            {
            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u));
            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u+1));
            buffer_write(save_buffer,buffer_u8,ds_list_find_value(ind_list,u+2));
            buffer_write(save_buffer,buffer_u8,ds_list_find_value(ind_list,u+3));
            buffer_write(save_buffer,buffer_u8,ds_list_find_value(ind_list,u+4));
            buffer_write(save_buffer,buffer_u8,ds_list_find_value(ind_list,u+5));
            }
        }
    }
//remove excess size
buffer_resize(save_buffer,buffer_tell(save_buffer));

//export
//tempname = FS_unique_fname(working_directory,".igf");
FS_buffer_save(save_buffer,file_loc);

if (FS_file_exists(file_loc))
    show_message_async("Frames saved.");
else
    show_message_async("Could not save file. May not have access rights, try a different folder.");

buffer_delete(save_buffer);
    
/*
file = FS_file_bin_open(file_loc,1);
for (i = 0;i < buffer_get_size(save_buffer);i++)
    {
    FS_file_bin_write_byte(file,buffer_peek(save_buffer,i,buffer_u8));
    }
FS_file_bin_close(file);

if (FS_file_exists(file_loc))
    show_message_async("Frames saved.");
else
    show_message_async("Could not save file. May not have access rights, try a different folder.");

buffer_delete(save_buffer);
