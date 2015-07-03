layer = ds_list_find_value(layer_list,selectedlayer);
controller.load_buffer = ds_list_find_value(abs(selectedx),1);

with (controller)
    {
    buffer_seek(load_buffer,buffer_seek_start,0);
    idbyte = buffer_read(load_buffer,buffer_u8);
    if (idbyte != 50) and (idbyte != 51)
        {
        show_message_async("Unexpected ID byte in frames_fromseq: "+string(idbyte)+", things might get ugly. Contact developer.");
        exit;
        }
    
    //clear
    clear_all();
    
    //load
    if (idbyte == 50)
        {
        maxframes = buffer_read(load_buffer,buffer_u32);
        for (j = 0; j < maxframes;j++)
            {
            el_list = ds_list_create();
            ds_list_add(frame_list,el_list);
            
            numofelems = buffer_read(load_buffer,buffer_u32);
            for (i = 0; i < numofelems;i++)
                {
                numofinds = buffer_read(load_buffer,buffer_u32);
                ind_list = ds_list_create();
                ds_list_add(el_list,ind_list);
                
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
        maxframes = buffer_read(load_buffer,buffer_u32);
        for (j = 0; j < maxframes;j++)
            {
            el_list = ds_list_create();
            ds_list_add(frame_list,el_list);
            
            numofelems = buffer_read(load_buffer,buffer_u32);
            for (i = 0; i < numofelems;i++)
                {
                numofinds = buffer_read(load_buffer,buffer_u32);
                ind_list = ds_list_create();
                ds_list_add(el_list,ind_list);
                
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
        
    scope_start = 0;
    scope_end = maxframes-1;
    }

if (song) FMODInstanceSetPaused(songinstance,1);
playing = 0;
room_goto(rm_ilda);