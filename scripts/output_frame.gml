if (!frame_surf_refresh)
    exit;
    

if (output_buffer_ready) || (laseronfirst && output_buffer_ready)
{
    dac_send_frame(dac, output_buffer_next, output_buffer_next_size, output_buffer_next_size*projectfps);
    output_buffer_ready = false;
    frame_surf_refresh = false;
    
    var t_output_buffer_prev = output_buffer;
    output_buffer = ouput_buffer_next;
    output_buffer_next = buffer_unused;
    buffer_unused = t_output_buffer_prev;
    
    laseronfirst = false;
}

maxpoints = 0;

if (laseronfirst)
    el_list = frame_list[| frame];
else
    el_list = frame_list[| ((frame+1) % (maxframes))];
if (is_undefined(el_list))
    {
    log("undef");
    exit;
    }    

/*log(get_timer()-time);
time = get_timer();
log(frame);*/

if (ds_list_size(el_list) == 0) 
{
    optimize_middle_output();
}
else
{
    if (export_makeframe_pass_list() == 0)
    {
        optimize_middle_output();
    }
    else
    {
        if (controller.exp_optimize)
            output_makeframe_pass_int();
        
        output_framelist_to_buffer();
    }
}

output_buffer_ready = true;

