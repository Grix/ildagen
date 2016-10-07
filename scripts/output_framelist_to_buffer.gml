output_buffer_next_size = ds_list_size(list_raw)/4;
var t_list_raw_size = ds_list_size(list_raw);

var t_red_lowerbound = round(controller.red_scale_lower*255);
var t_green_lowerbound = round(controller.green_scale_lower*255);
var t_blue_lowerbound = round(controller.blue_scale_lower*255);
var t_red_scale = controller.red_scale*(255-t_red_lowerbound)/255;
var t_green_scale = controller.green_scale*(255-t_green_lowerbound)/255;
var t_blue_scale = controller.blue_scale*(255-t_blue_lowerbound)/255;

var t_x_lowerbound = controller.x_scale_start;
var t_y_lowerbound = $FFFF-controller.y_scale_start;
var t_x_scale = controller.x_scale_end/$FFFF*($FFFF-t_x_lowerbound)/$FFFF;
var t_y_scale = controller.y_scale_end/$FFFF*(t_y_lowerbound)/$FFFF;

if (controller.exp_optimize)
{
    safe_bottom_boundary = abs(min(controller.opt_redshift,controller.opt_greenshift,controller.opt_blueshift,controller.opt_blankshift));
    safe_top_boundary = t_list_raw_size-max(controller.opt_redshift,controller.opt_greenshift,controller.opt_blueshift,controller.opt_blankshift);
    
    var t_blankshift = controller.opt_blankshift*4;
    var t_redshift = controller.opt_redshift*4;
    var t_greenshift = controller.opt_greenshift*4;
    var t_blueshift = controller.opt_blueshift*4;
    
    for (i = 0; i < t_list_raw_size; i += 4)
    {
        //writing point
        
        if (controller.invert_x)
            buffer_write(output_buffer,buffer_u16, t_x_lowerbound+($FFFF - list_raw[| i])*t_x_scale);
        else
            buffer_write(output_buffer,buffer_u16, t_x_lowerbound+(list_raw[| i])*t_x_scale);
        if (controller.invert_y)
            buffer_write(output_buffer,buffer_u16, t_y_lowerbound+($FFFF - list_raw[| i+1])*t_y_scale);
        else
            buffer_write(output_buffer,buffer_u16, t_y_lowerbound+(list_raw[| i+1])*t_y_scale);
            
        if ((i < safe_bottom_boundary) || (i > safe_top_boundary))
        {
            buffer_write(output_buffer,buffer_u32,0);
            buffer_write(output_buffer,buffer_u32,0);
        }
        else
        {
            buffer_write(output_buffer,buffer_u16,t_red_lowerbound + (list_raw[| i+t_redshift+3] & $FF) * t_red_scale);
            buffer_write(output_buffer,buffer_u16,t_green_lowerbound + ((list_raw[| i+t_greenshift+3] >> 8) & $FF) * t_green_scale);
            buffer_write(output_buffer,buffer_u16,t_blue_lowerbound + (list_raw[| i+t_blueshift+3] >> 16) * t_blue_scale);
            if (list_raw[| i+t_blankshift+2])
                buffer_write(output_buffer,buffer_u16,0); 
            else
                buffer_write(output_buffer,buffer_u16,255);
        }
    }
}
else //not optimized
{
    for (i = 0; i < t_list_raw_size; i += 4)
    {
        //writing point
        
        if (controller.invert_x)
            buffer_write(output_buffer,buffer_u16, t_x_lowerbound+($FFFF - list_raw[| i])*t_x_scale);
        else
            buffer_write(output_buffer,buffer_u16, t_x_lowerbound+(list_raw[| i])*t_x_scale);
        if (controller.invert_y)
            buffer_write(output_buffer,buffer_u16, t_y_lowerbound+($FFFF - list_raw[| i+1])*t_y_scale);
        else
            buffer_write(output_buffer,buffer_u16, t_y_lowerbound+(list_raw[| i+1])*t_y_scale);
        
        buffer_write(output_buffer,buffer_u16,t_red_lowerbound + (list_raw[| i+3] & $FF) * t_red_scale);
        buffer_write(output_buffer,buffer_u16,t_green_lowerbound + ((list_raw[| i+3] >> 8) & $FF) * t_green_scale);
        buffer_write(output_buffer,buffer_u16,t_blue_lowerbound + (list_raw[| i+3] >> 16) * t_blue_scale);
        if (list_raw[| i+2])
            buffer_write(output_buffer,buffer_u16,0); 
        else
            buffer_write(output_buffer,buffer_u16,255);
    }
}
    
ds_list_destroy(list_raw);

