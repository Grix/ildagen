//exports the frames from the ilda editor into an igf file
placing_status = 0;

file_loc = get_save_filename_ext("*.igf","example.igf","","Select LasershowGen frames file location");
if (file_loc == "")
    exit;
    
save_buffer = buffer_create(1,buffer_grow,1);

buffer_write(save_buffer,buffer_u8,52);
buffer_write(save_buffer,buffer_u32,maxframes);

for (j = 0; j < maxframes;j++)
    {
    el_list = ds_list_find_value(frame_list,j);
    buffer_write(save_buffer,buffer_u32,ds_list_size(el_list));
    
    for (i = 0; i < ds_list_size(el_list);i++)
        {
        ind_list = ds_list_find_value(el_list,i);
        tempsize = ds_list_size(ind_list);
        buffer_write(save_buffer,buffer_u32,tempsize);
        
        for (u = 0; u < 10; u++)
            {
            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u));
            }
        for (u = 10; u < 20; u++)
            {
            buffer_write(save_buffer,buffer_bool,0);//ds_list_find_value(ind_list,u));
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
buffer_resize(save_buffer,buffer_tell(save_buffer));

//export
if (file_exists("temp/"+filename_name(file_loc)))
    file_delete("temp/"+filename_name(file_loc));
if (FS_file_exists(file_loc))
    FS_file_delete(file_loc);
buffer_save(save_buffer,"temp/"+filename_name(file_loc));
FS_file_copy(controller.FStemp+filename_name(file_loc),file_loc);

if (FS_file_exists(file_loc))
    {
    binfile = FS_file_bin_open(file_loc,0);
    binfilesize = FS_file_bin_size(binfile);
    FS_file_bin_close(binfile);
    if (binfilesize == buffer_get_size(save_buffer))
        show_message_async("IGF file saved.");
    else
        {
        show_message_async("Problem saving file: Did not pass integrity test. May be corrupt, you might want to try again.");
        }
    }
else
    show_message_async("Could not save file. May not have access rights, try a different folder.");

buffer_delete(save_buffer);