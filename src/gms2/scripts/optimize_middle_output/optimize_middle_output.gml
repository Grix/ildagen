function optimize_middle_output() {
	maxpointswanted = floor((1/controller.projectfps)*controller.opt_scanspeed); 
	output_buffer_next_size = maxpointswanted;
    
	x_lowerbound_top = controller.scale_left_top;
	y_lowerbound_left = $FFFF-controller.scale_bottom_left;
	x_lowerbound_bottom = controller.scale_left_bottom;
	y_lowerbound_right = $FFFF-controller.scale_bottom_right;
	x_scale_top = (controller.scale_right_top-controller.scale_left_top)/$ffff;
	y_scale_left = (controller.scale_bottom_left-controller.scale_top_left)/$ffff;
	x_scale_bottom = (controller.scale_right_bottom-controller.scale_left_bottom)/$ffff;
	y_scale_right = (controller.scale_bottom_right-controller.scale_top_right)/$ffff;
	mid_x = x_lowerbound_top+(x_lowerbound_bottom-x_lowerbound_top)*($8000/$ffff)+$8000*(x_scale_top+(x_scale_bottom-x_scale_top)*($8000/$ffff));
	mid_y = y_lowerbound_left+(y_lowerbound_right-y_lowerbound_left)*($8000/$ffff)+$8000*(y_scale_left+(y_scale_right-y_scale_left)*($8000/$ffff));

	repeat (maxpointswanted * controller.fpsmultiplier)
	{
	    //writing point
	    buffer_write(output_buffer,buffer_u16,mid_x);
	    buffer_write(output_buffer,buffer_u16,mid_y);
	    buffer_write(output_buffer,buffer_u16,0);
	    buffer_write(output_buffer,buffer_u16,0);
	    buffer_write(output_buffer,buffer_u16,0);
	    buffer_write(output_buffer,buffer_u16,0);
	}
	output_buffer_next_size *= controller.fpsmultiplier;

}
