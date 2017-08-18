minroomspeed = max(projectfps,10);

output_buffer = controller.dac[| 4];
output_buffer2 = controller.dac[| 5];
output_buffer_ready = controller.dac[| 6];
output_buffer_next_size = controller.dac[| 7];

if (output_buffer_ready)
{
    if (debug_mode)
        log("outputted frame ", dac, output_buffer, output_buffer_next_size, output_buffer_next_size*projectfps);
        
    dac_send_frame(dac, output_buffer, output_buffer_next_size, output_buffer_next_size*projectfps);
    frame_surf_refresh = false;
    output_buffer_ready = false;
    laseronfirst = false;
    
    var t_output_buffer_prev = output_buffer;
    output_buffer = output_buffer2;
    output_buffer2 = t_output_buffer_prev;
}

maxpoints = 0;

if (!playing)
    el_list = frame_list[| frame];
else
    el_list = frame_list[| ((frame+1) % (maxframes))];
    
//blindzones preview
if (room = rm_options)
{
    blindzone_el_lists = 0;
    for (i = 0; i < ds_list_size(controller.blindzone_list); i += 4)
    {
        var blindzone_el = ds_list_create();
        blindzone_el[| 19] = 0; //fills up to 19 with 0
        blindzone_el[| 10] = true;
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 0]);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 2]);
        ds_list_add(blindzone_el, 0);
        ds_list_add(blindzone_el, c_white);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 1]);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 2]);
        ds_list_add(blindzone_el, 0);
        ds_list_add(blindzone_el, c_white);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 1]);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 3]);
        ds_list_add(blindzone_el, 0);
        ds_list_add(blindzone_el, c_white);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 0]);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 3]);
        ds_list_add(blindzone_el, 0);
        ds_list_add(blindzone_el, c_white);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 0]);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 2]);
        ds_list_add(blindzone_el, 0);
        ds_list_add(blindzone_el, c_white);
        ds_list_add(el_list, blindzone_el);
        blindzone_el_lists++;
    }
}
    
if (is_undefined(el_list))
{
    log("undef el_list in output_frame()");
    controller.dac[| 4] = output_buffer;
    controller.dac[| 5] = output_buffer2;
    controller.dac[| 6] = output_buffer_ready;
    controller.dac[| 7] = output_buffer_next_size;
    if (room = rm_options)
    {
        for (i = 0; i < blindzone_el_lists; i++)
        {
            ds_list_destroy(el_list[| ds_list_size(el_list)-1]);
            ds_list_delete(el_list, ds_list_size(el_list)-1);
        }
    }
    exit;
}    

buffer_seek(output_buffer, buffer_seek_start, 0);

if (ds_list_size(el_list) == 0) 
{
    optimize_middle_output();
}
else
{
    if (controller.exp_optimize)
    {
        if (controller.opt_onlyblanking)
        {
            if (!prepare_output_onlyblank())
            {
                optimize_middle_output();
            }
            else
            {
                make_frame_onlyblank();
                output_framelist_to_buffer();
            }
        }
        else
        {
            if (!prepare_output())
            {
                optimize_middle_output();
            }
            else
            {
                make_frame();
                output_framelist_to_buffer();
            }
        }
    }
    else
    {
        if (!prepare_output())
        {
            optimize_middle_output();
        }
        else
        {
            make_frame();
            output_framelist_to_buffer();
        }
    }
}

output_buffer_ready = true;

controller.dac[| 4] = output_buffer;
controller.dac[| 5] = output_buffer2;
controller.dac[| 6] = output_buffer_ready;
controller.dac[| 7] = output_buffer_next_size;

if (room = rm_options)
{
    for (i = 0; i < blindzone_el_lists; i++)
    {
        ds_list_destroy(el_list[| ds_list_size(el_list)-1]);
        ds_list_delete(el_list, ds_list_size(el_list)-1);
    }
}

return 1;

