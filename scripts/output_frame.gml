minroomspeed = max(projectfps,25);

if (output_buffer_ready)
{
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
if (is_undefined(el_list))
    {
    log("undef el_list in output_frame()");
    exit;
    }    

buffer_seek(output_buffer, buffer_seek_start, 0);

if (ds_list_size(el_list) == 0) 
{
    optimize_middle_output();
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

output_buffer_ready = true;

return 1;

