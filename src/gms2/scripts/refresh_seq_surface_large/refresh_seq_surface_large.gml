function refresh_seq_surface_large() {
	//refreshes the laser show preview surface in the sequencer mode room
	if (!surface_exists(frame_surf_large))
	    frame_surf_large = surface_create(clamp(power(2, ceil(log2(view_wport[4]))), 1, 8192), clamp(power(2, ceil(log2(view_hport[4]+view_hport[1]))), 1, 8192));
	if (!surface_exists(frame3d_surf_large))
	    frame3d_surf_large = surface_create(clamp(power(2, ceil(log2(view_wport[4]))), 1, 8192), clamp(power(2, ceil(log2(view_hport[4]+view_hport[1]))), 1, 8192));

	if (viewmode != 1)
	{
	    surface_set_target(frame_surf_large);
	    draw_clear_alpha(c_white,0);
	    surface_reset_target();
	}

	if (viewmode != 0)
	{
	    surface_set_target(frame3d_surf_large);
	    draw_clear(c_black);
	    surface_reset_target();
	}

	correctframe = round(tlpos/1000*projectfps);

	var t_scaley = 1/$FFFF*(view_hport[4]+view_hport[1]);
	var t_centerx = view_wport[4]/2;
	var t_centery = (view_hport[4]+view_hport[1])/2;
	var t_scalediag = sqrt((view_hport[4]+view_hport[1])*(view_hport[4]+view_hport[1])+view_wport[4]*view_wport[4])/2;
    
	//check which should be drawn
	for (j = 0; j < ds_list_size(layer_list); j++)
	{
	    var env_dataset = 0;
	    _layer = ds_list_find_value(layer_list, j);
	
		if (_layer[| 2])
			continue;
		
		var t_preview_x_offset = _layer[| 6]*t_scaley;
		var t_preview_y_offset = _layer[| 7]*t_scaley;
		var t_preview_angle_offset = _layer[| 8];
		var t_preview_mirror_x = _layer[| 9];
    
	    elementlist = _layer[| 1];
	    for (m = 0; m < ds_list_size(elementlist); m++)
	    {
	        objectlist = elementlist[| m];
			if (!ds_list_exists_pool(objectlist))
			{
				ds_list_delete(elementlist, m);
				if (m > 0)
					m--;
				continue;
			}
        
	        frametime = round(ds_list_find_value(objectlist,0));
	        object_length = ds_list_find_value(objectlist,2);
	        object_maxframes = ds_list_find_value(objectlist,4);
        
	        if (correctframe != clamp(correctframe, frametime, frametime+object_length))
	            continue;
            
	        //envelope transforms
	        if (!env_dataset)
	        {
	            env_dataset = 1;
            
	            ready_envelope_applying(ds_list_find_value(_layer,0));
	        }
        
	        //draw object
	        el_buffer = ds_list_find_value(objectlist,1);
	        fetchedframe = (correctframe-frametime) mod object_maxframes;
        
			if (!seek_to_correct_frame(el_buffer, fetchedframe, objectlist))
				exit;
        
	        //el_list = ds_list_create_pool(); why is this here?
            
	        buffer_maxelements = buffer_read(el_buffer,buffer_u32);
        
	        draw_set_alpha(1);
        
	        //actual elements
	        for (i = 0; i < buffer_maxelements;i++)
	        {
	            numofinds = buffer_read(el_buffer,buffer_u32);
	            var repeatnum = (numofinds-20)/4-1;
	            var buffer_start_pos = buffer_tell(el_buffer);
				
				if ((repeatnum+1)*13 >= buffer_get_size(el_buffer)+buffer_start_pos+50) // sanity check
				{
					if (!controller.bug_report_suppress)
					{
						controller.bug_report_suppress = true;
						show_message_new("Error drawing frame in refresh_seq_surface_large. Please contact the developer and report the bug using the top menu: \"About\"->\"Contact developer\"");
						http_post_string(   "https://www.bitlasers.com/lasershowgen/bugreport.php",
				            "bug=OS: " + string(os_type) + " VER: "+string(controller.version) + "\r\n"+"Error drawing frame.. repeatnum: "+string(repeatnum));
					}
					break;
				}
            
	            //2d
	            if (viewmode != 1)
	            {
					xo_raw = buffer_read(el_buffer,buffer_f32);
					yo_raw =  buffer_read(el_buffer,buffer_f32);
	                xo = view_wport[4]/2-(view_hport[4]+view_hport[1])/2+xo_raw*t_scaley;
	                yo = yo_raw*t_scaley;  
					xo += t_preview_x_offset;
					yo += t_preview_y_offset;
	                buffer_seek(el_buffer,buffer_seek_relative,42);
                
	                apply_envelope_frame(t_scaley);
                
					if (repeatnum >= 0)
					{
		                xp = buffer_read(el_buffer,buffer_f32);
		                yp = buffer_read(el_buffer,buffer_f32);
		                bl = buffer_read(el_buffer,buffer_bool);
		                c = buffer_read(el_buffer,buffer_u32);
                
		                apply_envelope_point();
                
		                surface_set_target(frame_surf_large);
                
		                repeat (repeatnum)
		                {
		                    xpp = xp;
		                    ypp = yp;
		                    blp = bl;
                    
		                    xp = buffer_read(el_buffer,buffer_f32);
		                    yp = buffer_read(el_buffer,buffer_f32);
		                    bl = buffer_read(el_buffer,buffer_bool);
		                    c = buffer_read(el_buffer,buffer_u32);
                    
		                    apply_envelope_point();
                    
		                    if (!bl)
		                    {
		                        draw_set_color(c);
		                        if ((xp == xpp) and (yp == ypp) and !blp)
		                        {
		                            draw_rectangle(xo+xp*t_scaley-1,yo+yp*t_scaley-1, xo+xp*t_scaley+1,yo+yp*t_scaley+1, 0);
		                        }
		                        else
		                            draw_line_width(xo+ xpp*t_scaley,yo+ ypp*t_scaley,xo+ xp*t_scaley,yo+ yp*t_scaley, controller.dpi_multiplier);
		                    }
		                }
		                surface_reset_target();
					}
	            }
                
	            //3d
	            if (viewmode != 0)
	            {
	                buffer_seek(el_buffer,buffer_seek_start,buffer_start_pos);
                
					xo_raw = buffer_read(el_buffer,buffer_f32);
					yo_raw =  buffer_read(el_buffer,buffer_f32);
	                xo = view_wport[4]/2-(view_hport[4]+view_hport[1])/2+xo_raw*t_scaley;
	                yo = yo_raw*t_scaley;  
	                buffer_seek(el_buffer,buffer_seek_relative,42);
                
	                apply_envelope_frame(t_scaley);
                
					if (repeatnum >= 0)
					{
		                xp = buffer_read(el_buffer,buffer_f32);
		                yp = buffer_read(el_buffer,buffer_f32);
		                bl = buffer_read(el_buffer,buffer_bool);
		                c = buffer_read(el_buffer,buffer_u32);
                
		                apply_envelope_point();
                
		                gpu_set_blendmode(bm_max);
		                draw_set_alpha(0.7);
		                surface_set_target(frame3d_surf_large);
                
		                repeat (repeatnum)
		                {
		                    xpp = xp;
		                    ypp = yp;
		                    blp = bl;
                    
		                    xp = buffer_read(el_buffer,buffer_f32);
		                    yp = buffer_read(el_buffer,buffer_f32);
		                    bl = buffer_read(el_buffer,buffer_bool);
		                    c = buffer_read(el_buffer,buffer_u32);
                    
		                    apply_envelope_point();
                    
		                    if (!bl)
		                    {
		                        pdir = point_direction(t_centerx,t_centery,xo+ xp*t_scaley,yo+ yp*t_scaley);
		                        xxp = t_centerx+cos(degtorad(-pdir))*t_scalediag;
		                        yyp = t_centery+sin(degtorad(-pdir))*t_scalediag;
                        
		                        if (xpp == xp) and (ypp == yp) and !(blp)
		                        {
		                            draw_set_alpha(0.9);
		                            draw_line_colour(t_centerx+t_preview_x_offset,t_centery+t_preview_y_offset,xxp+t_preview_x_offset,yyp+t_preview_y_offset,c,c_black);
		                            draw_set_alpha(0.7);
		                        }
		                        else
		                        {
		                            pdir_p = point_direction(t_centerx,t_centery,xo+ xpp*t_scaley,yo+ ypp*t_scaley);
		                            xxp_p = t_centerx+t_preview_x_offset+cos(degtorad(-pdir_p))*t_scalediag;
		                            yyp_p = t_centery+t_preview_y_offset+sin(degtorad(-pdir_p))*t_scalediag;
		                            draw_triangle_colour(t_centerx+t_preview_x_offset,t_centery+t_preview_y_offset,xxp_p,yyp_p,xxp+t_preview_x_offset,yyp+t_preview_y_offset,c,c_black,c_black,0);
		                        }
		                    }
		                }
		                gpu_set_blendmode(bm_normal);
		                draw_set_alpha(1);
		                surface_reset_target();  
					}
	            }
	        }
	    }
	}

	if (controller.onion)
	{
		for (k = 1; k <= controller.onion_number; k++)
	    {
			correctframe = max(0, round(tlpos/1000*projectfps) - k);
			draw_set_alpha(controller.onion_alpha * power(controller.onion_dropoff, k));
		
			//check which should be drawn
			for (j = 0; j < ds_list_size(layer_list); j++)
			{
			    var env_dataset = 0;
			    _layer = ds_list_find_value(layer_list, j);
			
				if (_layer[| 2])
					continue;
    
			    elementlist = _layer[| 1];
			    for (m = 0; m < ds_list_size(elementlist); m++)
			    {
			        objectlist = elementlist[| m];
					if (!ds_list_exists_pool(objectlist))
					{
						ds_list_delete(elementlist, m);
						if (m > 0)
							m--;
						continue;
					}
        
			        frametime = round(ds_list_find_value(objectlist,0));
			        object_length = ds_list_find_value(objectlist,2);
			        object_maxframes = ds_list_find_value(objectlist,4);
        
			        if (correctframe != clamp(correctframe, frametime, frametime+object_length))
			            continue;
            
			        //envelope transforms
			        if (!env_dataset)
			        {
			            env_dataset = 1;
            
			            ready_envelope_applying(ds_list_find_value(_layer,0));
			        }
        
			        //draw object
			        el_buffer = ds_list_find_value(objectlist,1);
			        fetchedframe = (correctframe-frametime) mod object_maxframes;
		        
					if (!seek_to_correct_frame(el_buffer, fetchedframe, objectlist))
						exit;
        
			        //el_list = ds_list_create_pool(); //why is this here?
        
            
			        buffer_maxelements = buffer_read(el_buffer,buffer_u32);
        
			        //actual elements
			        for (i = 0; i < buffer_maxelements;i++)
			        {
			            numofinds = buffer_read(el_buffer,buffer_u32);
			            var repeatnum = (numofinds-20)/4-1;
			            var buffer_start_pos = buffer_tell(el_buffer);
            
			            //2d
			            if (viewmode != 1)
			            {
							xo_raw = buffer_read(el_buffer,buffer_f32);
							yo_raw =  buffer_read(el_buffer,buffer_f32);
			                xo = view_wport[4]/2-(view_hport[4]+view_hport[1])/2+xo_raw*t_scaley;
			                yo = yo_raw*t_scaley;  
							xo += t_preview_x_offset;
							yo += t_preview_y_offset;
			                buffer_seek(el_buffer,buffer_seek_relative,42);
                
			                apply_envelope_frame(t_scaley);
                
							if (repeatnum >= 0)
							{
				                xp = buffer_read(el_buffer,buffer_f32);
				                yp = buffer_read(el_buffer,buffer_f32);
				                bl = buffer_read(el_buffer,buffer_bool);
				                c = buffer_read(el_buffer,buffer_u32);
                
				                apply_envelope_point();
                
				                surface_set_target(frame_surf_large);
                
				                repeat (repeatnum)
				                {
				                    xpp = xp;
				                    ypp = yp;
				                    blp = bl;
                    
				                    xp = buffer_read(el_buffer,buffer_f32);
				                    yp = buffer_read(el_buffer,buffer_f32);
				                    bl = buffer_read(el_buffer,buffer_bool);
				                    c = buffer_read(el_buffer,buffer_u32);
                    
				                    apply_envelope_point();
                    
				                    if (!bl)
				                    {
				                        draw_set_color(c);
				                        if ((xp == xpp) and (yp == ypp) and !blp)
				                        {
				                            draw_point(xo+xp*t_scaley,yo+yp*t_scaley);
				                        }
				                        else
				                            draw_line(xo+ xpp*t_scaley,yo+ ypp*t_scaley,xo+ xp*t_scaley,yo+ yp*t_scaley);
				                    }
				                }
				                surface_reset_target();
							}
			            }
			        }
			    }
			}
		}
	}
  
	draw_set_alpha(1);
	gpu_set_blendmode(bm_normal);
	draw_set_color(c_black);


}
