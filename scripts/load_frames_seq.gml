//load frames file for sequencer object
if (seqcontrol.selectedlayer = -1) or (seqcontrol.selectedx < 0)
    {
    show_message_async("No timeline position marked, select a position first");
    exit;
    }

file_loc = argument0;
if (file_loc == "") or is_undefined(file_loc)
    exit;
    
temp_list = ds_list_create();

FS_file_copy(file_loc,FStemp+filename_name(file_loc));
    
load_buffer = buffer_load("temp\"+filename_name(file_loc));
    
idbyte = buffer_read(load_buffer,buffer_u8);
if (idbyte != 0) and (idbyte != 50) and (idbyte != 51)
    {
    show_message_async("Unexpected ID byte: "+string(idbyte)+", is this a valid LasershowGen frames file?");
    exit;
    }

//load
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

    
//check for overlaps
/*with (seqcontrol)
    {
    layer = ds_list_find_value(layer_list,selectedlayer);
    for (j = 0; j < ds_list_size(layer); j += 3)
        {
        infolist = ds_list_find_value(layer,j+2);
        frametime = ds_list_find_value(layer,j);
        if (selectedx+controller.tempmaxframes = clamp(frametime,tlx,tlx+tlzoom)) 
            {
            //frametime-tlx
            //frametime-tlx+ds_list_find_value(infolist,0);
            }
        }
    }*/

save_buffer = buffer_create(1,buffer_grow,1);

buffer_write(save_buffer,buffer_u8,50);
buffer_write(save_buffer,buffer_u32,tempmaxframes);

for (j = 0; j < tempmaxframes;j++)
    {
    tempel_list = ds_list_find_value(temp_list,j);
    buffer_write(save_buffer,buffer_u32,ds_list_size(tempel_list));
    
    for (i = 0; i < ds_list_size(tempel_list);i++)
        {
        ind_list = ds_list_find_value(tempel_list,i);
        tempsize = ds_list_size(ind_list);
        buffer_write(save_buffer,buffer_u32,tempsize);
        
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

//send to sequencer
with (seqcontrol)
    {
    selectedlayerlist = ds_list_find_value(layer_list,selectedlayer);
    /* what is this???? for (j = 0; j < ds_list_size(selectedlayerlist); j += 3)
        {
        if (selectedx == ds_list_find_value(selectedlayerlist,j)) 
            {
            buffer_delete(ds_list_find_value(selectedlayerlist,j+1));
            exit;
            }
        }*/ 
        
    if (selectedx > 0)
        {
        ds_list_add(selectedlayerlist,selectedx);
        ds_list_add(selectedlayerlist,controller.save_buffer);
        
        info = ds_list_create();
        ds_list_add(info,controller.tempmaxframes-1);
        ds_list_add(info,make_screenshot(controller.save_buffer));
        ds_list_add(info,controller.tempmaxframes);
        ds_list_add(selectedlayerlist,info);
        
        selectedx += controller.tempmaxframes;
        }
    else
        {
        buffer_delete(ds_list_find_value(selectedlayerlist,abs(selectedx)+1));
        ds_list_replace(selectedlayerlist,abs(selectedx)+1,controller.save_buffer);
        
        var infolist = ds_list_find_value(selectedlayerlist,abs(selectedx)+2);
        ds_list_replace(infolist,0,controller.tempmaxframes-1);
        if (surface_exists(ds_list_find_value(infolist,1)))
            surface_free(ds_list_find_value(infolist,1));
        ds_list_replace(infolist,1,make_screenshot(controller.save_buffer));
        ds_list_replace(infolist,2,controller.tempmaxframes);
        }
    }
     

buffer_delete(load_buffer);
for (i = 0;i < ds_list_size(temp_list);i++)
    ds_list_destroy(ds_list_find_value(temp_list,i));
ds_list_destroy(temp_list);

room_goto(rm_seq);