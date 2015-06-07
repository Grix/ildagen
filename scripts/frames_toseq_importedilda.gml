//converts newly imported ilda in ild_list to sequencer object

if (seqcontrol.selectedlayer = -1) or (seqcontrol.selectedx < 0)
    {
    show_message_async("No timeline position marked, select a position first");
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
        if (selectedx+controller.ds_list_size(ild_list) = clamp(frametime,tlx,tlx+tlzoom)) 
            {
            //frametime-tlx
            //frametime-tlx+ds_list_find_value(infolist,0);
            }
        }
    }*/
    
save_buffer = buffer_create(1,buffer_grow,1);

buffer_write(save_buffer,buffer_u8,51);
buffer_write(save_buffer,buffer_u32,ds_list_size(ild_list));
//show_message(ds_list_size(ild_list));

for (j = 0; j < ds_list_size(ild_list);j++)
    {
    buffer_write(save_buffer,buffer_u32,1);

    ind_list = ds_list_find_value(ild_list,j);
    tempsize = ds_list_size(ind_list);
    //show_message(tempsize);
    buffer_write(save_buffer,buffer_u32,tempsize);
    
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
        
    ds_list_add(selectedlayerlist,selectedx);
    ds_list_add(selectedlayerlist,controller.save_buffer);
    
    info = ds_list_create();
    ds_list_add(info,ds_list_size(controller.ild_list)-1);
    ds_list_add(info,make_screenshot(controller.save_buffer));
    ds_list_add(info,ds_list_size(controller.ild_list));
    ds_list_add(selectedlayerlist,info);
    
    selectedx += ds_list_size(controller.ild_list);
    }
    
room_goto(rm_seq);
