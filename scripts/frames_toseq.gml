//exports every element into an ilda file
placing_status = 0;

if (seqcontrol.selectedlayer = -1)
    {
    show_message_async("No timeline position marked, enter the timeline and select a position first");
    exit;
    }
    
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

ds_list_add(seqcontrol.buffer_list,save_buffer);

//send to sequencer
with (seqcontrol)
    {
    selectedlayerlist = ds_list_find_value(layer_list,selectedlayer);
    for (j = 0; j < ds_list_size(selectedlayerlist); j += 3)
        {
        if (selectedx == ds_list_find_value(selectedlayerlist,j)) 
            {
            buffer_delete(ds_list_find_value(selectedlayerlist,j+1));
            exit;
            }
        }
    ds_list_add(selectedlayerlist,selectedx);
    ds_list_add(selectedlayerlist,controller.save_buffer);
    info = ds_list_create();
    ds_list_add(info,controller.maxframes);
    ds_list_add(info,make_screenshot(controller.save_buffer));
    ds_list_add(selectedlayerlist,info);
    }