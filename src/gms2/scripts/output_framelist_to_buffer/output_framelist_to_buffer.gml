function output_framelist_to_buffer() {
	//if (debug_mode)
	//    log("output_framelist_to_buffer");
    
	//var timerbm = get_timer();

	output_buffer_next_size = min(ds_list_size(list_raw)/4, $ffff/controller.projectfps, 4095);
	var t_list_raw_size = output_buffer_next_size*4;

	var t_red_lowerbound = round(controller.red_scale_lower*255);
	var t_green_lowerbound = round(controller.green_scale_lower*255);
	var t_blue_lowerbound = round(controller.blue_scale_lower*255);
	var t_red_scale = controller.red_scale*(255-t_red_lowerbound)/255 * controller.intensity_master_scale;
	var t_green_scale = controller.green_scale*(255-t_green_lowerbound)/255 * controller.intensity_master_scale;
	var t_blue_scale = controller.blue_scale*(255-t_blue_lowerbound)/255 * controller.intensity_master_scale;

	//safe_bottom_boundary = abs(min(controller.opt_redshift,controller.opt_greenshift,controller.opt_blueshift,controller.opt_blankshift));
	//safe_top_boundary = t_list_raw_size-max(controller.opt_redshift,controller.opt_greenshift,controller.opt_blueshift,controller.opt_blankshift);
    
	var t_blankshift = controller.opt_blankshift*4;
	var t_redshift = controller.opt_redshift*4;
	var t_greenshift = controller.opt_greenshift*4;
	var t_blueshift = controller.opt_blueshift*4;
    
	for (i = 0; i < t_list_raw_size; i += 4)
	{
	    //writing point
        
		if (controller.invert_x)
			xp = $FFFF - list_raw[| i+0];
		else
			xp = list_raw[| i+0];
            
		if (controller.invert_y)
			yp = $FFFF - list_raw[| i+1];
		else
			yp = list_raw[| i+1];
            
		var t_index = i+t_redshift+3;
		if (t_index >= 0 && t_index < t_list_raw_size)
			cr = (t_red_lowerbound + (list_raw[| t_index] & $FF) * t_red_scale);
		else
			cr = 0;
				
		t_index = i+t_greenshift+3;
		if (t_index >= 0 && t_index < t_list_raw_size)
			cg = (t_green_lowerbound + ((list_raw[| t_index] >> 8) & $FF) * t_green_scale);
		else
			cg = 0;
				
		t_index = i+t_blueshift+3;
		if (t_index >= 0 && t_index < t_list_raw_size)
			cb = (t_blue_lowerbound + (list_raw[| t_index] >> 16) * t_blue_scale);
		else
			cb = 0;
				
		t_index = i+t_blankshift+2;
	    if (t_index >= 0 && t_index < t_list_raw_size)
		{
			if (list_raw[| t_index])
				bl = 0;
		    else
				bl = 255;
		}
		else
			bl = 0;
			
		repeat (controller.fpsmultiplier)
		{
			if (!controller.swapxy)
			{
				buffer_write(output_buffer,buffer_u16, xp);
				buffer_write(output_buffer,buffer_u16, yp);
			}
			else
			{
				buffer_write(output_buffer,buffer_u16, yp);
				buffer_write(output_buffer,buffer_u16, xp);
			}
			buffer_write(output_buffer,buffer_u16, cr);
			buffer_write(output_buffer,buffer_u16, cg);
			buffer_write(output_buffer,buffer_u16, cb);
			buffer_write(output_buffer,buffer_u16, bl);
		}
	}
	output_buffer_next_size *= controller.fpsmultiplier;
    
	ds_list_free_pool(list_raw); list_raw = -1;

	//log("output_framelist_to_buffer",get_timer() - timerbm);




}
