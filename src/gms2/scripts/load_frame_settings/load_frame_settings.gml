file_loc = "lsgtestpattern.igf";
    
load_buffer = buffer_load(file_loc);
buffer_seek(load_buffer,buffer_seek_start,0);
idbyte = buffer_read(load_buffer,buffer_u8);
if (idbyte != 52)
{
    exit;
}

//load

buffer_read(load_buffer,buffer_u32); //not needed
el_list = ds_list_create();

numofelems = buffer_read(load_buffer,buffer_u32);
for (i = 0; i < numofelems;i++)
{
    numofinds = buffer_read(load_buffer,buffer_u32);
    ind_list = ds_list_create();
    ds_list_add(el_list,ind_list);
    
    for (u = 0; u < 9; u++)
    {
        ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
    }
    el_id_read = buffer_read(load_buffer,buffer_f32);
    ds_list_add(ind_list,el_id_read);
    for (u = 10; u < 20; u++)
    {
        ds_list_add(ind_list,buffer_read(load_buffer,buffer_bool));
    }
    for (u = 20; u < numofinds; u += 4)
    {
        ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
        ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
        ds_list_add(ind_list,buffer_read(load_buffer,buffer_bool));
        ds_list_add(ind_list,buffer_read(load_buffer,buffer_u32));
    }
}
    
buffer_delete(load_buffer);
