if (!frame_surf_refresh)
    exit;
    

if (output_buffer_ready)
{
    if (output_buffer != -1)
        buffer_delete(output_buffer);
    output_buffer = output_buffer_next;
    dac_send_frame(controller.dac, output_buffer, output_buffer_next_size);
    output_buffer_ready = false;
    frame_surf_refresh = false;
}

maxpoints = 0;

if (laseronfirst)
    correctframe = round(tlpos/1000*projectfps);
else
    correctframe = round(tlpos/1000*projectfps)+1;
    
output_buffer_next = buffer_create(26664,buffer_fixed,1);

el_list = ds_list_create(); 
//check which should be drawn
for (k = 0; k < ds_list_size(layer_list); k++)
    {
    env_dataset = 0;
    
    layer = ds_list_find_value(layer_list, k);
    for (m = 1; m < ds_list_size(layer); m++)
        {
        objectlist = ds_list_find_value(layer,m);
        
        infolist =  ds_list_find_value(objectlist,2);
        frametime = round(ds_list_find_value(objectlist,0));
        object_length = ds_list_find_value(infolist,0);
        object_maxframes = ds_list_find_value(infolist,2);
        
        if (correctframe != clamp(correctframe, frametime, frametime+object_length))
            continue;
            
        //envelope transforms
        if (!env_dataset)
            {
            env_dataset = 1;
            
            ready_envelope_applying(ds_list_find_value(layer,0));
            }
        
        //yup, draw object
        el_buffer = ds_list_find_value(objectlist,1);
        fetchedframe = (correctframe-frametime) mod object_maxframes;
        buffer_seek(el_buffer,buffer_seek_start,0);
        buffer_ver = buffer_read(el_buffer,buffer_u8);
        if (buffer_ver != 52)
            {
            show_message_async("Error: Unexpected idbyte in buffer for export_project. Things might get ugly. Contact developer.");
            exit;
            }
        buffer_maxframes = buffer_read(el_buffer,buffer_u32);
        
        //skip to correct frame
        for (i = 0; i < fetchedframe;i++)
            {
            numofel = buffer_read(el_buffer,buffer_u32);
            for (u = 0; u < numofel; u++)
                {
                numofdata = buffer_read(el_buffer,buffer_u32)-20;
                buffer_seek(el_buffer,buffer_seek_relative,50+numofdata*3.25);
                }
            }
            
        buffer_maxelements = buffer_read(el_buffer,buffer_u32);
        
        //make into lists
        for (i = 0; i < buffer_maxelements;i++)
            {
            numofinds = buffer_read(el_buffer,buffer_u32);
            ind_list = ds_list_create();
            ds_list_add(el_list,ind_list);
            for (u = 0; u < 10; u++)
                {
                ds_list_add(ind_list,buffer_read(el_buffer,buffer_f32));
                }
            //envelope transforms
            if (env_xtrans)
                {
                ds_list_replace(ind_list,0,ds_list_find_value(ind_list,0) + env_xtrans_val);
                }
            if (env_ytrans)
                {
                ds_list_replace(ind_list,1,ds_list_find_value(ind_list,1) + env_ytrans_val);
                }
            for (u = 10; u < 20; u++)
                {
                ds_list_add(ind_list,buffer_read(el_buffer,buffer_bool));
                }
            for (u = 20; u < numofinds; u += 4)
                {
                ds_list_add(ind_list,buffer_read(el_buffer,buffer_f32));
                ds_list_add(ind_list,buffer_read(el_buffer,buffer_f32));
                ds_list_add(ind_list,buffer_read(el_buffer,buffer_bool));
                ds_list_add(ind_list,buffer_read(el_buffer,buffer_u32));
                //apply envelope transforms to point data
                if (env_hue)
                    {
                    c = ds_list_find_value(ind_list,ds_list_size(ind_list)-1);
                    ds_list_replace(ind_list,ds_list_size(ind_list)-1,make_colour_hsv(  (colour_get_hue(c)+env_hue_val) mod 255,
                                                                                        colour_get_saturation(c),
                                                                                        colour_get_value(c)));
                    }
                if (env_a)
                    {
                    c = ds_list_find_value(ind_list,ds_list_size(ind_list)-1);
                    ds_list_replace(ind_list,ds_list_size(ind_list)-1,merge_colour(c,c_black,env_a_val));
                    }
                if (env_r)
                    {
                    c = ds_list_find_value(ind_list,ds_list_size(ind_list)-1);
                    ds_list_replace(ind_list,ds_list_size(ind_list)-1,make_colour_rgb(  (c & $FF)*env_r_val,
                                                                                        ((c >> 8) & $FF),
                                                                                        (c >> 16)));
                    }
                if (env_g)
                    {
                    c = ds_list_find_value(ind_list,ds_list_size(ind_list)-1);
                    ds_list_replace(ind_list,ds_list_size(ind_list)-1,make_colour_rgb(  (c & $FF),
                                                                                        ((c >> 8) & $FF)*env_g_val,
                                                                                        (c >> 16)));
                    }
                if (env_b)
                    {
                    c = ds_list_find_value(ind_list,ds_list_size(ind_list)-1);
                    ds_list_replace(ind_list,ds_list_size(ind_list)-1,make_colour_rgb(  (c & $FF),
                                                                                        ((c >> 8) & $FF),
                                                                                        (c >> 16)*env_b_val));
                    }
                }
            }
                
        }
    }

if (ds_list_size(el_list) == 0) 
{
    optimize_middle_output();
}
else
{
    if (output_makeframe_pass_list() == 0)
    {
        optimize_middle_output();
    }
    else
    {
        output_makeframe_pass_int();
        
        output_framelist_to_buffer();
    }
}

//cleanup
for (i = 0;i < ds_list_size(el_list);i++)
    {
    ds_list_destroy(ds_list_find_value(el_list,i));
    }
ds_list_destroy(el_list);

if (laseronfirst)
{
    if (output_buffer != -1)
        buffer_delete(output_buffer);
    output_buffer = output_buffer_next;
    dac_send_frame(controller.dac, output_buffer, output_buffer_next_size);
    output_buffer_ready = false;
    frame_surf_refresh = false;
}
else
    output_buffer_ready = true;