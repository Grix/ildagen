//sends editor frames to a timeline object
placing_status = 0;

if (seqcontrol.selectedlayer = -1)
    {
    show_message_async("No timeline position marked, enter timeline mode and select a position first");
    exit;
    }

placing_status = 0;
ds_list_clear(free_list);
ds_list_clear(bez_list);
    
//check for overlaps
/*with (seqcontrol)
    {
    layer = ds_list_find_value(layer_list,selectedlayer);
    for (j = 0; j < ds_list_size(layer); j += 3)
        {
        infolist = ds_list_find_value(layer,j+2);
        frametime = ds_list_find_value(layer,j);
        if (selectedx+controller.maxframes = clamp(frametime,tlx,tlx+tlzoom)) 
            {
            //frametime-tlx
            //frametime-tlx+ds_list_find_value(infolist,0);
            }
        }
    }*/

save_buffer = buffer_create(1,buffer_grow,1);

buffer_write(save_buffer,buffer_u8,51);
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
            buffer_write(save_buffer,buffer_bool,0);//ds_list_find_value(ind_list,u));
            }
        for (u = 50; u < tempsize; u += 6)
            {
            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u));
            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u+1));
            buffer_write(save_buffer,buffer_bool,ds_list_find_value(ind_list,u+2));
            buffer_write(save_buffer,buffer_u8,floor(ds_list_find_value(ind_list,u+3)));
            buffer_write(save_buffer,buffer_u8,floor(ds_list_find_value(ind_list,u+4)));
            buffer_write(save_buffer,buffer_u8,floor(ds_list_find_value(ind_list,u+5)));
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
        ds_list_add(info,controller.maxframes-1);
        ds_list_add(info,make_screenshot(controller.save_buffer));
        ds_list_add(info,controller.maxframes);
        ds_list_add(selectedlayerlist,info);
        
        selectedx += controller.maxframes;
        }
    else
        {
        buffer_delete(ds_list_find_value(selectedlayerlist,abs(selectedx)+1));
        ds_list_replace(selectedlayerlist,abs(selectedx)+1,controller.save_buffer);
        
        var infolist = ds_list_find_value(selectedlayerlist,abs(selectedx)+2);
        ds_list_replace(infolist,0,controller.maxframes-1);
        if (surface_exists(ds_list_find_value(infolist,1)))
            surface_free(ds_list_find_value(infolist,1));
        ds_list_replace(infolist,1,make_screenshot(controller.save_buffer));
        ds_list_replace(infolist,2,controller.maxframes);
        }
    }
    
room_goto(rm_seq);
