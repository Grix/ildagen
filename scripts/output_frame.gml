if ((!frame_surf_refresh) && (!laseronfirst))
    exit;

if (output_buffer_ready)
{
    dac_send_frame(dac, output_buffer, output_buffer_next_size, output_buffer_next_size*projectfps);
    frame_surf_refresh = false;
    output_buffer_ready = false;
    laseronfirst = false;
    
    var t_output_buffer_prev = output_buffer;
    output_buffer = output_buffer2;
    output_buffer2 = t_output_buffer_prev;
    
    if (!playing)
        return 1;
}

maxpoints = 0;

if (!playing)
    el_list = frame_list[| frame];
else
    el_list = frame_list[| ((frame+1) % (maxframes))];
if (is_undefined(el_list))
    {
    log("undef");
    exit;
    }    

buffer_seek(output_buffer, buffer_seek_start, 0);

if (ds_list_size(el_list) == 0) 
{
    optimize_middle_output();
}
else
{
    if (makeframe_pass_list() == 0)
    {
        optimize_middle_output();
    }
    else
    {
        if (controller.exp_optimize)
            makeframe_pass_int();
        
        output_framelist_to_buffer();
    }
}

output_buffer_ready = true;

return 1;

