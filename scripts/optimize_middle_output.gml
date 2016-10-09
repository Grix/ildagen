maxpointswanted = floor((1/controller.projectfps)*controller.opt_scanspeed); 
output_buffer_next_size = maxpointswanted;
    
x_lowerbound = controller.x_scale_start;
y_lowerbound = $FFFF-controller.y_scale_end;
x_scale = controller.x_scale_end/$FFFF*($FFFF-x_lowerbound)/$FFFF;
y_scale = ($FFFF-controller.y_scale_start)/$FFFF*($FFFF-y_lowerbound)/$FFFF;
mid_x = x_lowerbound+$8000*x_scale;
mid_y = y_lowerbound+$8000*y_scale;

repeat (maxpointswanted)
    {
    //writing point
    buffer_write(output_buffer,buffer_u16,mid_x);
    buffer_write(output_buffer,buffer_u16,mid_y);
    buffer_write(output_buffer,buffer_u32,0);
    buffer_write(output_buffer,buffer_u32,0);
    }
