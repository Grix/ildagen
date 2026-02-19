function prepare_output_points_bezier() {
	//if (debug_mode)
	//    log("prepare_output_points");

	listsize = ((ds_list_size(list_id)-20)/4);
	var t_blindzonelistsize = ds_list_size(controller.blindzone_list);
	var t_true_dwell_falling, t_true_dwell_rising;

	if (polarity_list[| i] == 0)
	{
	    currentpos = 20;
	    currentposadjust = 4;
	}
	else
	{
	    currentpos = ds_list_size(list_id)-4;
	    currentposadjust = -4;
	}

	//walk through list to get lit length and static point count
	for (var t_i = 1; t_i < listsize; t_i++)
	{
	    currentpos += currentposadjust;
	    //getting values from element list
    
	    bl = ds_list_find_value(list_id,currentpos+2);
    
	    if (bl)
	    {
	        bl_prev = 1;
	        continue;
	    }
    
	    //check if outside bounds
	    if (list_id[| 10] != true)
	    {
			var t_skipflag = false;
		
			var t_x = xo+list_id[| currentpos+0];
			var t_y = $ffff-(yo+list_id[| currentpos+1]);
	        xp = x_lowerbound_top+(x_lowerbound_bottom-x_lowerbound_top)*(($ffff-t_y)/$ffff)+t_x*(x_scale_top+(x_scale_bottom-x_scale_top)*(($ffff-t_y)/$ffff));
		    yp = y_lowerbound_left+(y_lowerbound_right-y_lowerbound_left)*(t_x/$ffff)+t_y*(y_scale_left+(y_scale_right-y_scale_left)*(t_x/$ffff));
	        //xp = x_lowerbound+(xo+list_id[| currentpos+0])*x_scale;
	        //yp = y_lowerbound+($ffff-(yo+list_id[| currentpos+1]))*y_scale;
       
	        if ((yp > $ffff) || (yp < 0) || (xp > $ffff) || (xp < 0))
	        {
	            //list_id[| currentpos+2 ] = 1;
	            bl_prev = 1;
	            continue;
	        }
        
	        for (jj = 0; jj < t_blindzonelistsize; jj += 4)
	        {
	            if ((xp > controller.blindzone_list[| jj+0]) 
	            &&  (xp < controller.blindzone_list[| jj+1])
	            &&  (yp < $FFFF-controller.blindzone_list[| jj+2]) 
	            &&  (yp > $FFFF-controller.blindzone_list[| jj+3]))
	            {
	                //list_id[| currentpos+2 ] = 1;
	                bl_prev = 1;
					t_skipflag = true;
	                break;
	            }
	        }
			if (t_skipflag)
				continue;
	    }
	    else
	    {   
	        //is blind zone, no scaling or blanking
	        xp = xo+list_id[| currentpos+0];
	        yp = $ffff-(yo+list_id[| currentpos+1]);
	    }
    
	    //valid point, process it
    
	    if (bl_prev)
	    {
	        //todo maybe add reference to current position so we don't 
	        //have to parse through all blanked points when writing
    
	        //BLANKING
        
	        var t_prevpos = currentpos-currentposadjust;
			var t_x = xo+list_id[| t_prevpos+0];
			var t_y = $ffff-(yo+list_id[| t_prevpos+1]);
	        xpp = x_lowerbound_top+(x_lowerbound_bottom-x_lowerbound_top)*(($ffff-t_y)/$ffff)+t_x*(x_scale_top+(x_scale_bottom-x_scale_top)*(($ffff-t_y)/$ffff));
		    ypp = y_lowerbound_left+(y_lowerbound_right-y_lowerbound_left)*(t_x/$ffff)+t_y*(y_scale_left+(y_scale_right-y_scale_left)*(t_x/$ffff));
	        opt_dist = point_distance(xp_prev,yp_prev,xpp,ypp);
        
	        if (opt_dist < 280) //connecting segments
	        {
	            angle_next = point_direction(xp,yp, xpp,ypp);
	            angle_prev = point_direction(xp_prev,yp_prev, xp_prev_prev,yp_prev_prev);
        
	            t_true_dwell_falling =  round(controller.opt_maxdwell * 
	                                    (1- abs(angle_difference( angle_prev, angle_next ))/180));
        
                
	            maxpoints_static += ( (controller.opt_mindwell)*2
	                                   + abs(t_true_dwell_falling - controller.opt_mindwell*2) );
	        }
	        else //not connecting segments
	        {
	            var t_bezier_protrusion_length = clamp(opt_dist / 10000, 0.1, 1) * 10000; // todo this should be improved, dependent on angle
				var t_dist_prev = point_distance(xp_prev_prev, yp_prev_prev, xp_prev, yp_prev);
	            var t_dist_next = point_distance(xpp, ypp, xp, yp);
                        
	            var t_bezier_prev_x;
	            var t_bezier_prev_y;
				var t_true_dwell_rising = 0;
					
				if (t_dist_prev >= 1)
				{
					t_bezier_prev_x = xp_prev + (xp_prev - xp_prev_prev) / t_dist_prev * t_bezier_protrusion_length;
		            t_bezier_prev_y = yp_prev + (yp_prev - yp_prev_prev) / t_dist_prev * t_bezier_protrusion_length;
						
					var t_shortening_ratio = 0;
						
					if (t_bezier_prev_y < 0 && (yp_prev - t_bezier_prev_y) != 0)
						t_shortening_ratio = max(t_shortening_ratio, -t_bezier_prev_y / (yp_prev - t_bezier_prev_y));
					else if (t_bezier_prev_y > $ffff && (t_bezier_prev_y - $ffff) != 0)
						t_shortening_ratio = max(t_shortening_ratio, (t_bezier_prev_y - $ffff) / (t_bezier_prev_y - yp_prev));
					if (t_bezier_prev_x < 0 && (xp_prev - t_bezier_prev_x) != 0)
						t_shortening_ratio = max(t_shortening_ratio, -t_bezier_prev_x / (xp_prev - t_bezier_prev_x));
					else if (t_bezier_prev_x > $ffff && (t_bezier_prev_x - $ffff) != 0)
						t_shortening_ratio = max(t_shortening_ratio, (t_bezier_prev_x - $ffff) / (t_bezier_prev_x - xp_prev));
							
					
					if (t_shortening_ratio > 0)
					{
						t_bezier_prev_x = xp_prev + (xp_prev - xp_prev_prev) / t_dist_prev * t_bezier_protrusion_length * (1 - t_shortening_ratio);
			            t_bezier_prev_y = yp_prev + (yp_prev - yp_prev_prev) / t_dist_prev * t_bezier_protrusion_length * (1 - t_shortening_ratio);
							
				        angle_prev = point_direction(xp_prev,yp_prev, xp_prev_prev,yp_prev_prev);
						angle_blank = point_direction(xpp,ypp, xp_prev,yp_prev);
						t_shortening_ratio = clamp(t_shortening_ratio, 0, 1);
                
				        t_true_dwell_rising =  round(controller.opt_maxdwell * 
												(1- abs(angle_difference( angle_prev, angle_blank ))/180) 
												* t_shortening_ratio);
					}
				}
				else
				{
					t_bezier_prev_x = xp_prev;
					t_bezier_prev_y = yp_prev;
				}
					
				var t_bezier_next_x;
	            var t_bezier_next_y;
				var t_true_dwell_falling = 0;
					
				if (t_dist_next >= 1)
				{
					t_bezier_next_x = xpp + (xpp - xp) / t_dist_next * t_bezier_protrusion_length;
		            t_bezier_next_y = ypp + (ypp - yp) / t_dist_next * t_bezier_protrusion_length;
						
					var t_shortening_ratio = 0;
						
					if (t_bezier_next_y < 0 && (ypp - t_bezier_next_y) != 0)
						t_shortening_ratio = max(t_shortening_ratio, -t_bezier_next_y / (ypp - t_bezier_next_y));
					else if (t_bezier_next_y > $ffff && (t_bezier_next_y - $ffff) != 0)
						t_shortening_ratio = max(t_shortening_ratio, (t_bezier_next_y - $ffff) / (t_bezier_next_y - ypp));
					if (t_bezier_next_x < 0 && (xpp - t_bezier_next_x) != 0)
						t_shortening_ratio = max(t_shortening_ratio, -t_bezier_next_x / (xpp - t_bezier_next_x));
					else if (t_bezier_next_x > $ffff && (t_bezier_next_x - $ffff) != 0)
						t_shortening_ratio = max(t_shortening_ratio, (t_bezier_next_x - $ffff) / (t_bezier_next_x - xpp));
						
					
					if (t_shortening_ratio > 0)
					{
						t_bezier_next_x = xpp + (xpp - xp) / t_dist_next * t_bezier_protrusion_length * (1 - t_shortening_ratio);
			            t_bezier_next_y = ypp + (ypp - yp) / t_dist_next * t_bezier_protrusion_length * (1 - t_shortening_ratio);
							
						angle_next = point_direction(xp,yp, xpp,ypp);
						angle_blank = point_direction(xpp,ypp, xp_prev,yp_prev);
						t_shortening_ratio = clamp(t_shortening_ratio, 0, 1);
                
				        t_true_dwell_falling =  round(controller.opt_maxdwell * 
												(1- abs(angle_difference( angle_blank, angle_next ))/180)
												* t_shortening_ratio);
					}
				}
				else
				{
					t_bezier_next_x = xpp;
					t_bezier_next_y = ypp;
				}
					
				bezier_coeffs(xp_prev, yp_prev, t_bezier_prev_x, t_bezier_prev_y, t_bezier_next_x, t_bezier_next_y, xpp, ypp);
					
				var t_bezier_length = 0;
					
				var t_x_prev_bez = xp_prev;
				var t_y_prev_bez = yp_prev;
				for (var t_j = 0; t_j <= 4; t_j++)
				{
					var t_x_next_bez = bezier_x(t_j/4);
					var t_y_next_bez = bezier_y(t_j/4);
					t_bezier_length += point_distance(t_x_prev_bez, t_y_prev_bez, t_x_next_bez, t_y_next_bez);
					t_x_prev_bez = t_x_next_bez;
					t_y_prev_bez = t_y_next_bez;
				}
				opt_dist = t_bezier_length;
				var t_quantumsteps = ceil(opt_dist / (a_ballistic*6));
                 
	            maxpoints_static += (   2*(controller.opt_mindwell) 
	                                    +  max(controller.opt_mindwell, t_true_dwell_rising - controller.opt_mindwell)
	                                    +  max(controller.opt_mindwell, t_true_dwell_falling - controller.opt_mindwell)
	                                    +  t_quantumsteps);
	        }
        
	        xp_prev = xpp;
	        yp_prev = ypp;
			bl_prev = 0;
	    }
		else
		{
			if (controller.opt_per_point)
			{
				// Add more delay if sharp corner within the element
				angle_next = point_direction(xp,yp, xp_prev,yp_prev);
			    angle_prev = point_direction(xp_prev,yp_prev, xp_prev_prev,yp_prev_prev);
        
			    var t_corner_dwell =  round(controller.opt_maxdwell * abs(angle_difference( angle_prev, angle_next )/180));
				
				maxpoints_static += floor(t_corner_dwell);
			}
		}
	
	    opt_dist = point_distance(xp,yp,xp_prev,yp_prev);
		
	    if (opt_dist < 2)
	    {
	        maxpoints_dots++;
	    }
	    else
	    {
			lit_length += opt_dist;
			numrawpoints++;
	    }
    
	    xp_prev_prev = xp_prev;
	    yp_prev_prev = yp_prev;
	    xp_prev = xp;
	    yp_prev = yp;
	    //c_prev = c;
	}





}
