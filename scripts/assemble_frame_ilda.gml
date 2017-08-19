if (!ds_list_size(el_list)) 
{
    optimize_middle_export();
    //update maxpoints
    maxpoints = maxpointswanted;
    maxpointsa[0] = maxpoints & 255;
    maxpoints = maxpoints >> 8;
    maxpointsa[1] = maxpoints & 255;
    buffer_poke(ilda_buffer,maxpointspos,buffer_u8,maxpointsa[1]);
    buffer_poke(ilda_buffer,maxpointspos+1,buffer_u8,maxpointsa[0]);
    return false;
}
    
if (controller.exp_optimize)
{
    if (controller.opt_onlyblanking)
    {
        if (prepare_output_onlyblank() == 0)
        {
            optimize_middle_export();
            //update maxpoints
            maxpoints = maxpointswanted;
            maxpointsa[0] = maxpoints & 255;
            maxpoints = maxpoints >> 8;
            maxpointsa[1] = maxpoints & 255;
            buffer_poke(ilda_buffer,maxpointspos,buffer_u8,maxpointsa[1]);
            buffer_poke(ilda_buffer,maxpointspos+1,buffer_u8,maxpointsa[0]);
            return false;
        }
        
        make_frame_onlyblank();
    }
    else
    {
        if (prepare_output() == 0)
        {
            optimize_middle_export();
            //update maxpoints
            maxpoints = maxpointswanted;
            maxpointsa[0] = maxpoints & 255;
            maxpoints = maxpoints >> 8;
            maxpointsa[1] = maxpoints & 255;
            buffer_poke(ilda_buffer,maxpointspos,buffer_u8,maxpointsa[1]);
            buffer_poke(ilda_buffer,maxpointspos+1,buffer_u8,maxpointsa[0]);
            return false;
        }
        
        make_frame();
    }
    
    export_framelist_to_buffer();
}
else
{
    if (prepare_output_unopt() == 0)
    {
        optimize_middle_export();
        //update maxpoints
        maxpoints = maxpointswanted;
        maxpointsa[0] = maxpoints & 255;
        maxpoints = maxpoints >> 8;
        maxpointsa[1] = maxpoints & 255;
        buffer_poke(ilda_buffer,maxpointspos,buffer_u8,maxpointsa[1]);
        buffer_poke(ilda_buffer,maxpointspos+1,buffer_u8,maxpointsa[0]);
        return false;
    }
    
    make_frame_unopt();
    export_framelist_to_buffer();
}

//update maxpoints
maxpointsa[0] = maxpoints & 255;
maxpoints = maxpoints >> 8;
maxpointsa[1] = maxpoints & 255;
buffer_poke(ilda_buffer,maxpointspos,buffer_u8,maxpointsa[1]);
buffer_poke(ilda_buffer,maxpointspos+1,buffer_u8,maxpointsa[0]);

return true;
