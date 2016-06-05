output_buffer_next_size = ds_list_size(list_raw)/4;
var t_list_raw_size = ds_list_size(list_raw)-4;

if (controller.dac[| 1] == 0) || (controller.dac[| 1] == 1)
{
    //riya, lasdac: 12bit xy
    var t_scaleshift = 4;
}
else
{
    var t_scaleshift = 0;
}

if (controller.exp_optimize)
{
    var t_red_lowerbound = round(controller.red_scale_lower*255);
    var t_green_lowerbound = round(controller.green_scale_lower*255);
    var t_blue_lowerbound = round(controller.blue_scale_lower*255);
    var t_red_scale = controller.red_scale*(255-t_red_lowerbound)/255;
    var t_green_scale = controller.green_scale*(255-t_green_lowerbound)/255;
    var t_blue_scale = controller.blue_scale*(255-t_blue_lowerbound)/255;
    
    var t_blankshift = controller.opt_blankshift*4;
    var t_redshift = controller.opt_redshift*4;
    var t_greenshift = controller.opt_greenshift*4;
    var t_blueshift = controller.opt_blueshift*4;
    var t_bl;
    
    for (i = 0; i <= t_list_raw_size; i += 4)
    {
        //writing point
        
        if (controller.invert_x)
            buffer_write(output_buffer_next,buffer_u16, ($FFFF - list_raw[| i]) >> t_scaleshift);
        else
            buffer_write(output_buffer_next,buffer_u16, (list_raw[| i]) >> t_scaleshift);
        if (controller.invert_y)
            buffer_write(output_buffer_next,buffer_u16, ($FFFF - list_raw[| i+1]) >> t_scaleshift);
        else
            buffer_write(output_buffer_next,buffer_u16, (list_raw[| i+1]) >> t_scaleshift);
            
        t_bl = list_raw[| i+t_blankshift+2];
        if (is_undefined(bl))
        {
            buffer_write(output_buffer_next,buffer_u32,0);
        }
        else
        {
            buffer_write(output_buffer_next,buffer_u8,t_red_lowerbound + (list_raw[| i+t_redshift+3] & $FF) * t_red_scale);
            buffer_write(output_buffer_next,buffer_u8,t_green_lowerbound + ((list_raw[| i+t_greenshift+3] >> 8) & $FF) * t_green_scale);
            buffer_write(output_buffer_next,buffer_u8,t_blue_lowerbound + (list_raw[| i+t_blueshift+3] >> 16) * t_blue_scale);
            if (t_bl)
                buffer_write(output_buffer_next,buffer_u8,0); 
            else
                buffer_write(output_buffer_next,buffer_u8,255);
        }
    }
}
else //not optimized
{
    var t_bl;
    
    for (i = 0; i <= t_list_raw_size; i += 4)
    {
        //writing point
        
        buffer_write(output_buffer_next,buffer_u16, (list_raw[| i]) >> t_scaleshift);
        buffer_write(output_buffer_next,buffer_u16, (list_raw[| i+1]) >> t_scaleshift);
            
        t_bl = list_raw[| i+2];
        if (is_undefined(bl))
        {
            buffer_write(output_buffer_next,buffer_u32,0);
        }
        else
        {
            buffer_write(output_buffer_next,buffer_u8,(list_raw[| i+3] & $FF));
            buffer_write(output_buffer_next,buffer_u8,(list_raw[| i+3] >> 8) & $FF);
            buffer_write(output_buffer_next,buffer_u8,(list_raw[| i+3] >> 16));
            if (t_bl)
                buffer_write(output_buffer_next,buffer_u8,0); 
            else
                buffer_write(output_buffer_next,buffer_u8,255);
        }
    }
}
    
ds_list_destroy(list_raw);
ds_list_destroy(list_points);
