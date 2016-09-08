output_buffer_next_size = ds_list_size(list_raw);
var t_list_raw_size = ds_list_size(list_raw)-1;

if (controller.exp_optimize)
{
    var t_red_lowerbound = round(controller.red_scale_lower*255);
    var t_green_lowerbound = round(controller.green_scale_lower*255);
    var t_blue_lowerbound = round(controller.blue_scale_lower*255);
    var t_red_scale = controller.red_scale*(255-t_red_lowerbound)/255;
    var t_green_scale = controller.green_scale*(255-t_green_lowerbound)/255;
    var t_blue_scale = controller.blue_scale*(255-t_blue_lowerbound)/255;
    var red_pointlist, green_pointlist, blue_pointlist, blank_pointlist;
    
    safe_bottom_boundary = abs(min(controller.opt_redshift,controller.opt_greenshift,controller.opt_blueshift,controller.opt_blankshift));
    safe_top_boundary = t_list_raw_size-max(controller.opt_redshift,controller.opt_greenshift,controller.opt_blueshift,controller.opt_blankshift);
    
    for (i = 0; i <= t_list_raw_size; i++)
    {
        pos_pointlist = list_raw[| i];
        //writing point
        
        if (controller.invert_x)
            buffer_write(output_buffer,buffer_u16, ($FFFF - pos_pointlist[| 0]));
        else
            buffer_write(output_buffer,buffer_u16, (pos_pointlist[| 0]));
        if (controller.invert_y)
            buffer_write(output_buffer,buffer_u16, ($FFFF - pos_pointlist[| 1]));
        else
            buffer_write(output_buffer,buffer_u16, (pos_pointlist[| 1]));
        
        if ((i < safe_bottom_boundary) || (i > safe_top_boundary))
        {
            buffer_write(output_buffer,buffer_u32,0);
            buffer_write(output_buffer,buffer_u32,0);
        }
        else
        {
            red_pointlist = list_raw[| i+controller.opt_redshift];
            green_pointlist = list_raw[| i+controller.opt_greenshift];
            blue_pointlist = list_raw[| i+controller.opt_blueshift];
            blank_pointlist = list_raw[| i+controller.opt_blankshift];
            
            buffer_write(output_buffer,buffer_u16,t_red_lowerbound + (red_pointlist[| 3] & $FF) * t_red_scale);
            buffer_write(output_buffer,buffer_u16,t_green_lowerbound + ((green_pointlist[| 3] >> 8) & $FF) * t_green_scale);
            buffer_write(output_buffer,buffer_u16,t_blue_lowerbound + (blue_pointlist[| 3] >> 16) * t_blue_scale);
            if (blank_pointlist[| 2])
                buffer_write(output_buffer,buffer_u16,0); 
            else
                buffer_write(output_buffer,buffer_u16,255);
        }
    }
}
else //not optimized
{
    var t_red_lowerbound = round(controller.red_scale_lower*255);
    var t_green_lowerbound = round(controller.green_scale_lower*255);
    var t_blue_lowerbound = round(controller.blue_scale_lower*255);
    var t_red_scale = controller.red_scale*(255-t_red_lowerbound)/255;
    var t_green_scale = controller.green_scale*(255-t_green_lowerbound)/255;
    var t_blue_scale = controller.blue_scale*(255-t_blue_lowerbound)/255;
    
    for (i = 0; i <= t_list_raw_size; i++)
    {
        pos_pointlist = list_raw[| i];
        //writing point
        
        if (controller.invert_x)
            buffer_write(output_buffer,buffer_u16, ($FFFF - pos_pointlist[| 0]));
        else
            buffer_write(output_buffer,buffer_u16, (pos_pointlist[| 0]));
        if (controller.invert_y)
            buffer_write(output_buffer,buffer_u16, ($FFFF - pos_pointlist[| 1]));
        else
            buffer_write(output_buffer,buffer_u16, (pos_pointlist[| 1]));
        
        buffer_write(output_buffer,buffer_u16,t_red_lowerbound + (pos_pointlist[| 3] & $FF) * t_red_scale);
        buffer_write(output_buffer,buffer_u16,t_green_lowerbound + ((pos_pointlist[| 3] >> 8) & $FF) * t_green_scale);
        buffer_write(output_buffer,buffer_u16,t_blue_lowerbound + (pos_pointlist[| 3] >> 16) * t_blue_scale);
        if (pos_pointlist[| 2])
            buffer_write(output_buffer,buffer_u16,0); 
        else
            buffer_write(output_buffer,buffer_u16,255);
    }
}
    
for (i = 0; i <= t_list_raw_size; i++)
    ds_list_destroy(list_raw[| i]);
ds_list_destroy(list_raw);
ds_list_destroy(list_points);
