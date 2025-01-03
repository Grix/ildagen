function refresh_live_surface() {
	if (!surface_exists(frame_surf))
	    frame_surf = surface_create(clamp(power(2, ceil(log2(view_wport[4]))), 1, 8192), clamp(power(2, ceil(log2(view_hport[4]))), 1, 8192));
	if (!surface_exists(frame3d_surf))
	    frame3d_surf = surface_create(clamp(power(2, ceil(log2(view_wport[4]))), 1, 8192), clamp(power(2, ceil(log2(view_hport[4]))), 1, 8192));
	
	
	if (viewmode != 1)
	{
	    surface_set_target(frame_surf);
	    draw_clear_alpha(c_white,0);
	    surface_reset_target();
	}

	if (viewmode != 0)
	{
	    surface_set_target(frame3d_surf);
	    draw_clear(c_black);
	    surface_reset_target();
	}

	var t_scaley = 1/$FFFF*view_hport[4];
	var t_centerx = view_wport[4]/2;
	var t_centery = view_hport[4]/2;
	var t_scalediag = sqrt(view_hport[4]*view_hport[4]+view_wport[4]*view_wport[4])/2;

	var t_exclusive_active = false;
	for (j = 0; j < ds_list_size(filelist); j++)
	{
		if (ds_list_find_value(filelist[| j], 8) != 0 && filelist[| j][| 0])
		{
			t_exclusive_active = true;
			break;
		}
	}

	for (j = 0; j < ds_list_size(filelist); j++)
	{
		objectlist = filelist[| j];
	
		if (!objectlist[| 0] || (t_exclusive_active && objectlist[| 8] == 0)) // is not playing
			continue;

		object_maxframes = objectlist[| 4];
	    frame = objectlist[| 2];
	
		//modifier transforms
	    ready_envelope_applying_live();
        
		//draw object
		el_buffer = ds_list_find_value(objectlist, 1);
		fetchedframe = frame mod object_maxframes;
	
		if (!seek_to_correct_frame(el_buffer, fetchedframe, objectlist))
			exit;
            
		buffer_maxelements = buffer_read(el_buffer,buffer_u32);
        
		draw_set_alpha(1);
        
		//actual elements
		for (i = 0; i < buffer_maxelements;i++)
		{
			numofinds = buffer_read(el_buffer,buffer_u32);
			var repeatnum = (numofinds-20)/4-1;
			var buffer_start_pos = buffer_tell(el_buffer);
		
			var t_raw_xo = buffer_read(el_buffer,buffer_f32);
			var t_raw_yo = buffer_read(el_buffer,buffer_f32);
		
			var t_actualanchor_x = $8000 - t_raw_xo;
	        var t_actualanchor_y = $8000 - t_raw_yo;
		
			//2d
			gpu_set_blendenable(0);
			if (viewmode != 1)
			{
			    xo = view_wport[4]/2-view_hport[4]/2 + (t_raw_xo+env_xtrans_val)*t_scaley;
			    yo = (t_raw_yo+env_ytrans_val)*t_scaley; 
			
			    buffer_seek(el_buffer,buffer_seek_relative,42);
                
				if (repeatnum >= 0)
				{
				    xp = buffer_read(el_buffer,buffer_f32);
				    yp = buffer_read(el_buffer,buffer_f32);
				    bl = buffer_read(el_buffer,buffer_bool);
				    c = buffer_read(el_buffer,buffer_u32);
			
					if (env_rotabs)
				    {
				        angle = degtorad(point_direction(t_actualanchor_x, t_actualanchor_y, xp, yp));
				        dist = point_distance(t_actualanchor_x, t_actualanchor_y, xp, yp);
				        xp = t_actualanchor_x+cos(env_rotabs_val-angle)*dist;
				        yp = t_actualanchor_y+sin(env_rotabs_val-angle)*dist;
				    }
					
			
				    surface_set_target(frame_surf);
                
				    repeat (repeatnum)
				    {
				        xpp = xp;
				        ypp = yp;
				        blp = bl;
                    
				        xp = buffer_read(el_buffer,buffer_f32);
				        yp = buffer_read(el_buffer,buffer_f32);
				        bl = buffer_read(el_buffer,buffer_bool);
				        c = buffer_read(el_buffer,buffer_u32);
				
				        if (!bl)
				        {
							if (env_hue)
				            {
				                c = make_colour_hsv((colour_get_hue(c)+env_hue_val+255) % 255,colour_get_saturation(c),colour_get_value(c));
				            }
				            if (env_a)
				            {
				                c = merge_colour(c,c_black,env_a_val);
				            }
				            if (env_r)
				            {
				                c = (c & $FFFF00) | ((c & $FF)*env_r_val);
				            }
				            if (env_g)
				            {
				                c = (c & $FF00FF) | ((((c >> 8) & $FF)*env_g_val) << 8);
				            }
				            if (env_b)
				            {
				                c = (c & $00FFFF) | (((c >> 16)*env_b_val) << 16);
				            }
				            if (env_rotabs)
				            {
				                angle = degtorad(point_direction(t_actualanchor_x, t_actualanchor_y, xp, yp));
				                dist = point_distance(t_actualanchor_x, t_actualanchor_y, xp, yp);
				                xp = t_actualanchor_x+cos(env_rotabs_val-angle)*dist;
				                yp = t_actualanchor_y+sin(env_rotabs_val-angle)*dist;
				            }
					
				            draw_set_color(c);
				            if ((xp == xpp) and (yp == ypp) and !blp)
				            {
				                draw_rectangle(xo+xp*t_scaley-1,yo+yp*t_scaley-1,xo+xp*t_scaley+1,yo+yp*t_scaley+1, 0);
				            }
				            else
				                draw_line_width(xo+ xpp*t_scaley,yo+ ypp*t_scaley,xo+ xp*t_scaley,yo+ yp*t_scaley, controller.dpi_multiplier);
				        }
				    }
                
				    surface_reset_target();
				}
			}
			gpu_set_blendenable(1);
                
			//3d
			if (viewmode != 0)
			{
			    buffer_seek(el_buffer,buffer_seek_start,buffer_start_pos);
                
				var t_raw_xo = buffer_read(el_buffer,buffer_f32);
				var t_raw_yo = buffer_read(el_buffer,buffer_f32);
				
			    xo = view_wport[4]/2-view_hport[4]/2 + (t_raw_xo+env_xtrans_val)*t_scaley;
			    yo = (t_raw_yo+env_ytrans_val)*t_scaley;  
			    buffer_seek(el_buffer,buffer_seek_relative,42);
				
				if (repeatnum >= 0)
				{
				    xp = buffer_read(el_buffer,buffer_f32);
				    yp = buffer_read(el_buffer,buffer_f32);
				    bl = buffer_read(el_buffer,buffer_bool);
				    c = buffer_read(el_buffer,buffer_u32);
			
					if (env_rotabs)
				    {
				        angle = degtorad(point_direction(t_actualanchor_x, t_actualanchor_y, xp, yp));
				        dist = point_distance(t_actualanchor_x, t_actualanchor_y, xp, yp);
				        xp = t_actualanchor_x+cos(env_rotabs_val-angle)*dist;
				        yp = t_actualanchor_y+sin(env_rotabs_val-angle)*dist;
				    }
                
				    gpu_set_blendmode(bm_max);
				    draw_set_alpha(0.7);
				    surface_set_target(frame3d_surf);
                
				    repeat (repeatnum)
				    {
				        xpp = xp;
				        ypp = yp;
				        blp = bl;
                    
				        xp = buffer_read(el_buffer,buffer_f32);
				        yp = buffer_read(el_buffer,buffer_f32);
				        bl = buffer_read(el_buffer,buffer_bool);
				        c = buffer_read(el_buffer,buffer_u32);
				
                    
				        if (!bl)
				        {
							if (env_hue)
				            {
				                c = make_colour_hsv((colour_get_hue(c)+env_hue_val+255) % 255,colour_get_saturation(c),colour_get_value(c));
				            }
				            if (env_a)
				            {
				                c = merge_colour(c,c_black,env_a_val);
				            }
				            if (env_r)
				            {
				                c = (c & $FFFF00) | ((c & $FF)*env_r_val);
				            }
				            if (env_g)
				            {
				                c = (c & $FF00FF) | ((((c >> 8) & $FF)*env_g_val) << 8);
				            }
				            if (env_b)
				            {
				                c = (c & $00FFFF) | (((c >> 16)*env_b_val) << 16);
				            }
				            if (env_rotabs)
				            {
				                angle = degtorad(point_direction(t_actualanchor_x, t_actualanchor_y, xp, yp));
				                dist = point_distance(t_actualanchor_x, t_actualanchor_y, xp, yp);
				                xp = t_actualanchor_x+cos(env_rotabs_val-angle)*dist;
				                yp = t_actualanchor_y+sin(env_rotabs_val-angle)*dist;
				            }
					
				            pdir = point_direction(t_centerx, t_centery, xo+ xp*t_scaley,yo+ yp*t_scaley);
				            xxp = t_centerx+cos(degtorad(-pdir))*t_scalediag;
				            yyp = t_centery+sin(degtorad(-pdir))*t_scalediag;
                        
				            if (xpp == xp) and (ypp == yp) and !(blp)
				            {
				                draw_set_alpha(0.9);
				                draw_line_colour(t_centerx, t_centery, xxp,yyp,c,c_black);
				                draw_set_alpha(0.7);
				            }
				            else
				            {
				                pdir_p = point_direction(t_centerx,t_centery,xo+ xpp*t_scaley,yo+ ypp*t_scaley);
				                xxp_p = t_centerx+cos(degtorad(-pdir_p))*t_scalediag;
				                yyp_p = t_centery+sin(degtorad(-pdir_p))*t_scalediag;
				                draw_triangle_colour(t_centerx,t_centery,xxp_p,yyp_p,xxp,yyp,c,c_black,c_black,0);
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

	if (controller.onion)
	{
		for (k = 1; k <= controller.onion_number; k++)
	    {
			draw_set_alpha(controller.onion_alpha * power(controller.onion_dropoff, k));
		
			for (j = 0; j < ds_list_size(filelist); j++)
			{
				objectlist = filelist[| j];
	
				if (!objectlist[| 0]) // is not playing
					continue;

				object_maxframes = objectlist[| 4];
			    frame = objectlist[| 2];
        
				//draw object
				el_buffer = ds_list_find_value(objectlist, 1);
				fetchedframe = (frame+k) mod object_maxframes;
				if (objectlist[| 4] == 0 && fetchedframe < (frame mod object_maxframes))
					continue; // is not looping, so don't wrap to start
				
				if (!seek_to_correct_frame(el_buffer, fetchedframe, objectlist))
					exit;
            
				buffer_maxelements = buffer_read(el_buffer,buffer_u32);
        
				//actual elements
				for (i = 0; i < buffer_maxelements;i++)
				{
					numofinds = buffer_read(el_buffer,buffer_u32);
					var repeatnum = (numofinds-20)/4-1;
					var buffer_start_pos = buffer_tell(el_buffer);
            
					//2d
					gpu_set_blendenable(0);
					if (viewmode != 1)
					{
						var t_raw_xo = buffer_read(el_buffer,buffer_f32);
						var t_raw_yo = buffer_read(el_buffer,buffer_f32);
						var t_actualanchor_x = $8000 - t_raw_xo;
						var t_actualanchor_y = $8000 - t_raw_yo;
						
					    xo = view_wport[4]/2-view_hport[4]/2 + (t_raw_xo+env_xtrans_val)*t_scaley;
					    yo = (t_raw_yo+env_ytrans_val)*t_scaley;  
						
					    buffer_seek(el_buffer,buffer_seek_relative,42);
                
						if (repeatnum >= 0)
						{
						    xp = buffer_read(el_buffer,buffer_f32);
						    yp = buffer_read(el_buffer,buffer_f32);
						    bl = buffer_read(el_buffer,buffer_bool);
						    c = buffer_read(el_buffer,buffer_u32);
							
							if (env_rotabs)
						    {
						        angle = degtorad(point_direction(t_actualanchor_x, t_actualanchor_y, xp, yp));
						        dist = point_distance(t_actualanchor_x, t_actualanchor_y, xp, yp);
						        xp = t_actualanchor_x+cos(env_rotabs_val-angle)*dist;
						        yp = t_actualanchor_y+sin(env_rotabs_val-angle)*dist;
						    }
		
						    surface_set_target(frame_surf);
                
						    repeat (repeatnum)
						    {
						        xpp = xp;
						        ypp = yp;
						        blp = bl;
                    
						        xp = buffer_read(el_buffer,buffer_f32);
						        yp = buffer_read(el_buffer,buffer_f32);
						        bl = buffer_read(el_buffer,buffer_bool);
						        c = buffer_read(el_buffer,buffer_u32);
                    
						        if (!bl)
						        {
									if (env_hue)
						            {
						                c = make_colour_hsv((colour_get_hue(c)+env_hue_val+255) % 255,colour_get_saturation(c),colour_get_value(c));
						            }
						            if (env_a)
						            {
						                c = merge_colour(c,c_black,env_a_val);
						            }
						            if (env_r)
						            {
						                c = (c & $FFFF00) | ((c & $FF)*env_r_val);
						            }
						            if (env_g)
						            {
						                c = (c & $FF00FF) | ((((c >> 8) & $FF)*env_g_val) << 8);
						            }
						            if (env_b)
						            {
						                c = (c & $00FFFF) | (((c >> 16)*env_b_val) << 16);
						            }
						            if (env_rotabs)
						            {
						                angle = degtorad(point_direction(t_actualanchor_x, t_actualanchor_y, xp, yp));
						                dist = point_distance(t_actualanchor_x, t_actualanchor_y, xp, yp);
						                xp = t_actualanchor_x+cos(env_rotabs_val-angle)*dist;
						                yp = t_actualanchor_y+sin(env_rotabs_val-angle)*dist;
						            }
									
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
					gpu_set_blendenable(1);
                
				}
			}
		}
	}

	draw_set_alpha(1);
	gpu_set_blendmode(bm_normal);
	draw_set_color(c_black);


}
