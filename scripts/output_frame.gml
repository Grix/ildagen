if (!frame_surf_refresh)
    exit;
    
if (output_buffer_ready)
{
    if (output_buffer != -1)
        buffer_delete(output_buffer);
    output_buffer = output_buffer_next;
    dac_send_frame(dac, output_buffer, output_buffer_next_size);
    output_buffer_ready = false;
    frame_surf_refresh = false;
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

output_buffer_next = buffer_create(26664,buffer_fixed,1);

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

if (laseronfirst)
{
    if (output_buffer != -1)
        buffer_delete(output_buffer);
    output_buffer = output_buffer_next;
    dac_send_frame(dac, output_buffer, output_buffer_next_size);
    output_buffer_ready = false;
    frame_surf_refresh = false;
}
else
    output_buffer_ready = true;

