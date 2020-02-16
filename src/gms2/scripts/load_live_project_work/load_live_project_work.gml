if (idbyte == 200 || idbyte == 201)
{
    for (j = global.loading_current; j < global.loading_end;j++)
    {
        if (get_timer()-global.loadingtimeprev >= 100000)
        {
            global.loading_current = j;
            global.loadingtimeprev = get_timer();
            return 0;
        }
        
        //object data
        objectlist = ds_list_create();
        ds_list_add(objectlist,round(buffer_read(load_buffer,buffer_u32)));
            
        objectbuffersize = buffer_read(load_buffer,buffer_u32);
        objectbuffer = buffer_create(objectbuffersize,buffer_fixed,1);
        ds_list_add(objectlist,objectbuffer);
        buffer_copy(load_buffer,buffer_tell(load_buffer),objectbuffersize,objectbuffer,0);
        buffer_seek(load_buffer,buffer_seek_relative,objectbuffersize);
            
        objectinfolist = ds_list_create();
        ds_list_add(objectlist,objectinfolist);
        ds_list_add(objectinfolist,round(buffer_read(load_buffer,buffer_u32)));
        ds_list_add(objectinfolist,-1);
        ds_list_add(objectinfolist,round(buffer_read(load_buffer,buffer_u32)));
            
        ds_list_add(objectlist,round(buffer_read(load_buffer,buffer_u32)));
		ds_list_add(objectlist,buffer_read(load_buffer,buffer_bool));
		
		if (idbyte == 201)
		{
			ds_list_add(objectlist,buffer_read(load_buffer,buffer_bool));
			ds_list_add(objectlist,buffer_read(load_buffer,buffer_bool));
			buffer_read(load_buffer,buffer_u32);
			buffer_read(load_buffer,buffer_u32);
			buffer_read(load_buffer,buffer_u32);
			buffer_read(load_buffer,buffer_u32);
		}
		else
		{
			ds_list_add(objectlist,0);
			ds_list_add(objectlist,0);
		}
		
		ds_list_add(filelist, objectlist);
	}
}
    
buffer_delete(load_buffer);

global.loading_loadliveproject = 0;

room_goto(rm_live);
