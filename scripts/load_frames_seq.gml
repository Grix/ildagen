//load frames file for sequencer object
if (selectedlayer == -1) or (selectedx < 0)
    {
    show_message_async("No timeline position marked, select a position first");
    exit;
    }
    
with (seqcontrol)
    {
    if (song) FMODInstanceSetPaused(songinstance,1);
    playing = 0;
    }

file_loc = argument0;
if (file_loc == "") or is_undefined(file_loc)
    exit;

FS_file_copy(file_loc,controller.FStemp+filename_name(file_loc));
    
load_buffer = buffer_load("temp\"+filename_name(file_loc));
buffer_seek(load_buffer,buffer_seek_start,0);
idbyte = buffer_read(load_buffer,buffer_u8);
if (idbyte != 0) and (idbyte != 50) and (idbyte != 51)
    {
    show_message_async("Unexpected ID byte: "+string(idbyte)+", is this a valid LasershowGen frames file?");
    exit;
    }
    
temp_list = ds_list_create();

//load
if (idbyte == 0) or (idbyte == 50)
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
                for (u = 0; u < numofinds; u++)
                    {
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_s32));
                    }
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
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_u8));
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_u8));
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_u8));
                    }
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
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_u8));
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_u8));
                    ds_list_add(ind_list,buffer_read(load_buffer,buffer_u8));
                    }
                }
            }
        }
        
    buffer_delete(load_buffer);
    
    save_buffer = buffer_create(1,buffer_grow,1);
    buffer_seek(save_buffer,buffer_seek_start,0);
    
    buffer_write(save_buffer,buffer_u8,51);
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
            for (u = 10; u < 50; u++)
                {
                buffer_write(save_buffer,buffer_bool,0);//ds_list_find_value(ind_list,u));
                }
            for (u = 50; u < tempsize; u += 6)
                {
                buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u));
                buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u+1));
                buffer_write(save_buffer,buffer_bool,ds_list_find_value(ind_list,u+2));
                buffer_write(save_buffer,buffer_u8,round(ds_list_find_value(ind_list,u+3)));
                buffer_write(save_buffer,buffer_u8,round(ds_list_find_value(ind_list,u+4)));
                buffer_write(save_buffer,buffer_u8,round(ds_list_find_value(ind_list,u+5)));
                }
            ds_list_destroy(ind_list);
            }
        ds_list_destroy(tempel_list);
        }
    //remove excess size
    buffer_resize(save_buffer,buffer_tell(save_buffer));
    
    }
else if (idbyte == 51)
    {
    tempmaxframes = buffer_read(load_buffer,buffer_u32);
    save_buffer = load_buffer;
    }

//send to sequencer
selectedlayerlist = ds_list_find_value(layer_list,selectedlayer);
    
if (selectedx > 0)
    {
    objectlist = ds_list_create();
    ds_list_add(objectlist,selectedx);
    ds_list_add(objectlist,save_buffer);
    
    info = ds_list_create();
    ds_list_add(info,tempmaxframes-1);
    ds_list_add(info,make_screenshot(save_buffer));
    ds_list_add(info,tempmaxframes);
    ds_list_add(objectlist,info);
    
    ds_list_add(selectedlayerlist,objectlist);
    
    infolisttemp = info;
    selectedx += tempmaxframes;
    }
else
    {
    objectlist = abs(selectedx);
    //if buffer exist
    buffer_delete(ds_list_find_value(objectlist,1));
    ds_list_replace(objectlist,1,save_buffer);
    
    var infolist = ds_list_find_value(objectlist,2);
    ds_list_replace(infolist,0,tempmaxframes-1);
    if (surface_exists(ds_list_find_value(infolist,1)))
        surface_free(ds_list_find_value(infolist,1));
    ds_list_replace(infolist,1,make_screenshot(save_buffer));
    ds_list_replace(infolist,2,tempmaxframes);
    
    ds_list_add(selectedlayerlist,objectlist);
    
    infolisttemp = infolist;
    }
    
undolisttemp = ds_list_create();
ds_list_add(undolisttemp,selectedlayerlist);
ds_list_add(undolisttemp,objectlist);
ds_list_add(undo_list,"c"+string(undolisttemp));
     
ds_list_destroy(temp_list);

room_goto(rm_seq);