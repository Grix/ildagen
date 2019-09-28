//load frames file for live mode object

if (ds_list_size(livecontrol.filelist) >= 10)
{
	if (!verify_serial(1))
		return;
}

file_loc = argument0;
if !string_length(file_loc) 
    exit;

//file_copy(file_loc, "temp/temp.igf");
load_buffer = buffer_load(file_loc);

if (load_buffer == -1)
{
	show_message_new("Could not open file");
	exit;
}

buffer_seek(load_buffer,buffer_seek_start,0);
idbyte = buffer_read(load_buffer,buffer_u8);
if (idbyte != 0) and (idbyte != 50) and (idbyte != 51) and (idbyte != 52)
{
    show_message_new("Unexpected ID byte: "+string(idbyte)+", is this a valid LaserShowGen frames file?");
    exit;
}
    
temp_list = ds_list_create();

//load
if (idbyte == 0) or (idbyte == 50) or (idbyte == 51)
{
    if (idbyte == 0)
    {
        tempmaxframes = buffer_read(load_buffer,buffer_s32);
        for (j = 0; j < tempmaxframes;j++)
        {
            tempel_list = ds_list_create();
            ds_list_add(temp_list,tempel_list);
            
            numofelems = buffer_read(load_buffer,buffer_s32);
            for (i = 0; i < numofelems;i++)
            {
                numofinds = buffer_read(load_buffer,buffer_s32);
                ind_list = ds_list_create();
                ds_list_add(tempel_list,ind_list);
                for (u = 0; u < 50; u++)
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_s32));
                for (u = 50; u < numofinds; u+=6)
                {
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_s32));
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_s32));
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_s32));
                    cr = buffer_read(load_buffer,buffer_s32);
                    cg = buffer_read(load_buffer,buffer_s32);
                    cb = buffer_read(load_buffer,buffer_s32);
                    ds_list_add(ind_list,make_colour_rgb(cr,cg,cb));
                }
                repeat (30) ds_list_delete(ind_list,19);
            }
        }
    }
    else if (idbyte == 50)
    {
        tempmaxframes = buffer_read(load_buffer,buffer_u32);
        for (j = 0; j < tempmaxframes;j++)
        {
            tempel_list = ds_list_create();
            ds_list_add(temp_list,tempel_list);
            
            numofelems = buffer_read(load_buffer,buffer_u32);
            for (i = 0; i < numofelems;i++)
            {
                numofinds = buffer_read(load_buffer,buffer_u32);
                ind_list = ds_list_create();
                ds_list_add(tempel_list,ind_list);
                
                for (u = 0; u < 10; u++)
                {
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
                }
                for (u = 10; u < 50; u++)
                {
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_u8));
                }
                for (u = 50; u < numofinds; u += 6)
                {
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_u8));
                    ds_list_add(ind_list,make_colour_rgb(buffer_read(load_buffer,buffer_u8),
                                                        buffer_read(load_buffer,buffer_u8),
                                                        buffer_read(load_buffer,buffer_u8)));
                }
                repeat (30) ds_list_delete(ind_list,19);
            }
        }
    }
    else if (idbyte == 51)
    {
        tempmaxframes = buffer_read(load_buffer,buffer_u32);
        for (j = 0; j < tempmaxframes;j++)
        {
            tempel_list = ds_list_create();
            ds_list_add(temp_list,tempel_list);
            
            numofelems = buffer_read(load_buffer,buffer_u32);
            for (i = 0; i < numofelems;i++)
            {
                numofinds = buffer_read(load_buffer,buffer_u32);
                ind_list = ds_list_create();
                ds_list_add(tempel_list,ind_list);
                
                for (u = 0; u < 10; u++)
                {
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
                }
                for (u = 10; u < 50; u++)
                {
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_bool));
                }
                for (u = 50; u < numofinds; u += 6)
                {
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_f32));
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_bool));
                    ds_list_add(ind_list,make_colour_rgb(buffer_read(load_buffer,buffer_u8),
                                                        buffer_read(load_buffer,buffer_u8),
                                                        buffer_read(load_buffer,buffer_u8)));
                }
                repeat (30) ds_list_delete(ind_list,19);
            }
        }
    }
        
    buffer_delete(load_buffer);
    
    save_buffer = buffer_create(1,buffer_grow,1);
    buffer_seek(save_buffer,buffer_seek_start,0);
    
    buffer_write(save_buffer,buffer_u8,52);
    buffer_write(save_buffer,buffer_u32,ds_list_size(temp_list));
    
    for (j = 0; j < ds_list_size(temp_list);j++)
    {
        tempel_list = ds_list_find_value(temp_list,j);
        buffer_write(save_buffer,buffer_u32,ds_list_size(tempel_list));
        
        for (i = 0; i < ds_list_size(tempel_list);i++)
        {
            ind_list = ds_list_find_value(tempel_list,i);
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
            ds_list_destroy(ind_list);
        }
        ds_list_destroy(tempel_list);
    }
    //remove excess size
    buffer_resize(save_buffer,buffer_tell(save_buffer));
}
else if (idbyte == 52)
{
    tempmaxframes = buffer_read(load_buffer,buffer_u32);
    save_buffer = load_buffer;
}

//send to live
objectlist = ds_list_create();
ds_list_add(objectlist,0);
ds_list_add(objectlist,save_buffer);
info = ds_list_create();
ds_list_add(info,0);
ds_list_add(info,-1);
ds_list_add(info,tempmaxframes);
ds_list_add(objectlist,info);
ds_list_add(objectlist, find_next_available_shortcut());
ds_list_add(objectlist, (tempmaxframes == 1));
	
ds_list_add(filelist,objectlist);
    
selectedfile = ds_list_size(filelist)-1;
	
ds_list_add(undo_list, "c"+string(selectedfile));
	
frame_surf_refresh = 1;
if (surface_exists(browser_surf))
	surface_free(browser_surf);
browser_surf = -1;
frame = 0;
playing = 0;
     
ds_list_destroy(temp_list);
