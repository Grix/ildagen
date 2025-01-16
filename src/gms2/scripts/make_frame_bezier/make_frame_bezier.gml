// TODO FOR THIS: 
// Has not yet included improvements from around new years 2024-2025. However improvement were not noticable anyway so maybe abandon project.

function make_frame_bezier() {
	//if (debug_mode)
	//    log("make_frame_bezier");
    
	//var timerbm = get_timer();

	var t_vectorx, t_vectory, t_true_dwell_falling, t_true_dwell_rising;
	var t_blindzonelistsize = ds_list_size(controller.blindzone_list);

	var t_totalrem = 0;
	var t_totalpointswanted = floor(controller.opt_scanspeed/controller.projectfps);
	var t_litpointswanted = t_totalpointswanted - maxpoints_static - 1;

	if (t_litpointswanted == 0) 
	    t_litpointswanted = 0.0001; //todo
	if (numrawpoints != 0)
	{
		var t_dotlength = lit_length/numrawpoints*controller.dotstrength;
		var t_lengthwanted = (lit_length + t_dotlength*maxpoints_dots)/t_litpointswanted;
	}
	else
	{
		var t_dotlength = 1;
		var t_lengthwanted = (t_dotlength*maxpoints_dots)/t_litpointswanted;
	}

	// slow framerate if frame is too complex
	if (controller.enable_dynamic_fps)
	{
		/*if ((controller.opt_maxdist/t_lengthwanted) < 0.12)
		{
			controller.fpsmultiplier = 4;
		}*/
		if ((controller.opt_maxdist/t_lengthwanted) < 0.08)
		{
			controller.fpsmultiplier = 3;
		}
		else if ((controller.opt_maxdist/t_lengthwanted) < 0.2)
		{
			controller.fpsmultiplier = 2;
		}
		else
			controller.fpsmultiplier = 1;
	}
	else
		controller.fpsmultiplier = 1;
	
	
	var t_lengthwanted70 = t_lengthwanted*0.7;
	var t_lengthwanted170 = t_lengthwanted*1.7;

	xp_prev = mid_x;
	yp_prev = mid_y;
	xp_prev_prev = mid_x;
	yp_prev_prev = mid_y;
	bl_prev = 1;
	c_prev = 0;
	new_dot = 1;

	//parse elements
	var t_numofelems = ds_list_size(order_list);
  
	for (i = 0; i < t_numofelems; i++)
	{
	    list_id = ds_list_find_value(el_list,order_list[| i]);
        
	    if (is_undefined(list_id))
	        continue;

	    xo = ds_list_find_value(list_id,0);
	    yo = ds_list_find_value(list_id,1);
       
	    //writing points in element list
	    listsize = ((ds_list_size(list_id)-20)/4);

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
    
	    var t_i;
	    for (t_i = 1; t_i < listsize; t_i++)
	    {
	        currentpos += currentposadjust;
        
	        bl = ds_list_find_value(list_id,currentpos+2);
        
	        if (bl)
	        {
	            bl_prev = 1;
	            new_dot = 1;
	            continue;
	        }
		
	        if (list_id[| 10] != true)//if not blind zone
	        {
				var t_skipflag = false;
			
				var t_x = xo+list_id[| currentpos+0];
				var t_y = $ffff-(yo+list_id[| currentpos+1]);
		        xp = x_lowerbound_top+(x_lowerbound_bottom-x_lowerbound_top)*(($ffff-t_y)/$ffff)+t_x*(x_scale_top+(x_scale_bottom-x_scale_top)*(($ffff-t_y)/$ffff));
		        yp = y_lowerbound_left+(y_lowerbound_right-y_lowerbound_left)*(t_x/$ffff)+t_y*(y_scale_left+(y_scale_right-y_scale_left)*(t_x/$ffff));
                
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
                    
	        //valid lit point, process it
            
	        c = list_id[| currentpos+3 ];
            
	        if (bl_prev)
	        {
	            //BLANKING
	            var t_prevpos = currentpos-currentposadjust;
				
				var t_x = xo+list_id[| t_prevpos+0];
				var t_y = $ffff-(yo+list_id[| t_prevpos+1]);
		        xpp = x_lowerbound_top+(x_lowerbound_bottom-x_lowerbound_top)*(($ffff-t_y)/$ffff)+t_x*(x_scale_top+(x_scale_bottom-x_scale_top)*(($ffff-t_y)/$ffff));
		        ypp = y_lowerbound_left+(y_lowerbound_right-y_lowerbound_left)*(t_x/$ffff)+t_y*(y_scale_left+(y_scale_right-y_scale_left)*(t_x/$ffff));
                
	            if ((ypp >= $ffff) || (ypp <= 0) || (xpp >= $ffff) || (xpp <= 0))
	            {
	                continue;
	            }
                
	            for (jj = 0; jj < t_blindzonelistsize; jj += 4)
	            {
	                if ((xpp > controller.blindzone_list[| jj+0]) 
	                &&  (xpp < controller.blindzone_list[| jj+1])
	                &&  (ypp < $FFFF-controller.blindzone_list[| jj+2]) 
	                &&  (ypp > $FFFF-controller.blindzone_list[| jj+3]))
	                {
	                    continue;
	                }
	            }
            
	            opt_dist = point_distance(xp_prev,yp_prev,xpp,ypp);
                
	            if (opt_dist < 280) //connecting segments
	            {
	                angle_next = point_direction(xp,yp, xpp,ypp);
	                angle_prev = point_direction(xp_prev,yp_prev, xp_prev_prev,yp_prev_prev);
                
	                t_true_dwell_falling =  round(controller.opt_maxdwell * 
	                                        (1- abs(angle_difference( angle_prev, angle_next ))/180));
                                            
	                //dwell on blanking start
	                repeat (controller.opt_maxdwell_blank)
	                {
	                    ds_list_add(list_raw,xp_prev);
	                    ds_list_add(list_raw,yp_prev);
	                    ds_list_add(list_raw,(c_prev == 0));
	                    ds_list_add(list_raw,c_prev);
	                }
	                repeat (t_true_dwell_falling - controller.opt_maxdwell_blank*2 )
	                {
	                    ds_list_add(list_raw,xp_prev);
	                    ds_list_add(list_raw,yp);
	                    ds_list_add(list_raw,1);
	                    ds_list_add(list_raw,0);
	                }
	                repeat (controller.opt_maxdwell_blank)
	                {
	                    ds_list_add(list_raw,xp);
	                    ds_list_add(list_raw,yp);
	                    ds_list_add(list_raw,0);
	                    ds_list_add(list_raw,c);
	                }
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
					
                
	                //dwell on blanking start
	                repeat (controller.opt_maxdwell_blank)
	                {
	                    ds_list_add(list_raw,xp_prev);
	                    ds_list_add(list_raw,yp_prev);
	                    ds_list_add(list_raw,(c_prev == 0));
	                    ds_list_add(list_raw,c_prev);
	                }
	                repeat (t_true_dwell_rising - controller.opt_maxdwell_blank*2 )
	                {
	                    ds_list_add(list_raw,xp_prev);
	                    ds_list_add(list_raw,yp_prev);
	                    ds_list_add(list_raw,1);
	                    ds_list_add(list_raw,0);
	                }
					repeat (controller.opt_maxdwell_blank)
	                {
	                    ds_list_add(list_raw,xp_prev);
	                    ds_list_add(list_raw,yp_prev);
	                    ds_list_add(list_raw,1);
	                    ds_list_add(list_raw,0);
	                }
                    
	                new_dot = 1;
					
					// travel in the bezier curve
					var t_quantumsteps = ceil(opt_dist / (a_ballistic*6));
					
					for (k = 0; k <= t_quantumsteps; k++)
	                {
						var t_t = ease_in_out(k / t_quantumsteps);
	                    ds_list_add(list_raw,bezier_x(t_t));
	                    ds_list_add(list_raw,bezier_y(t_t));
	                    ds_list_add(list_raw,1);
	                    ds_list_add(list_raw,0);
	                }
					
					
	                repeat (controller.opt_maxdwell_blank)
	                {
	                    ds_list_add(list_raw,xpp);
	                    ds_list_add(list_raw,ypp);
	                    ds_list_add(list_raw,1);
	                    ds_list_add(list_raw,0);
	                }
					repeat (t_true_dwell_falling - controller.opt_maxdwell_blank*2 )
	                {
	                    ds_list_add(list_raw,xpp);
	                    ds_list_add(list_raw,ypp);
	                    ds_list_add(list_raw,1);
	                    ds_list_add(list_raw,0);
	                }
	                repeat (controller.opt_maxdwell_blank)
	                {
	                    ds_list_add(list_raw,xpp);
	                    ds_list_add(list_raw,ypp);
	                    ds_list_add(list_raw,0);
	                    ds_list_add(list_raw,c);
	                }
                    
	            }
			
	            xp_prev = xpp;
	            yp_prev = ypp;
				c_prev = c;
				bl_prev = 0;
			
	        } //end if bl_prev
			else
			{
				if (controller.opt_per_point)
				{
					// Add more delay if sharp corner within the element
					angle_next = point_direction(xp,yp, xp_prev,yp_prev);
			        angle_prev = point_direction(xp_prev,yp_prev, xp_prev_prev,yp_prev_prev);
        
			        var t_corner_dwell =  round(controller.opt_maxdwell * abs(angle_difference( angle_prev, angle_next )/180));
				
					repeat(floor(t_corner_dwell))
					{
						ds_list_add(list_raw,xp_prev);
				        ds_list_add(list_raw,yp_prev);
				        ds_list_add(list_raw,0);
				        ds_list_add(list_raw,c_prev);
					}
				}
			}
			
			opt_dist = point_distance(xp,yp,xp_prev,yp_prev);
			
			if (opt_dist < 2)
				opt_dist = t_dotlength;
		
	        if (opt_dist+t_totalrem < t_lengthwanted70)
	        {
	            //skip point
	            if (t_i != listsize-1 && t_i != 1)
	            {
					t_totalrem += opt_dist;//t_lengthwanted;
					xp_prev = xp;
					yp_prev = yp;
	                continue;
				}
				else
					t_totalrem = opt_dist+t_totalrem-t_lengthwanted;
	        }
	        else if (opt_dist+t_totalrem > t_lengthwanted170)
			{
	            //add points
	            t_totalrem += t_lengthwanted - (opt_dist % t_lengthwanted);
	            if (t_totalrem > t_lengthwanted)
	            {
	                t_totalrem -= t_lengthwanted;
	                opt_dist -= t_lengthwanted;
	            }
	            var t_stepscount = floor(opt_dist/t_lengthwanted+1);
	            t_vectorx = (xp-xp_prev)/t_stepscount;
	            t_vectory = (yp-yp_prev)/t_stepscount;
	            for (u = 1; u < t_stepscount; u++)
	            {
	                ds_list_add(list_raw,xp_prev+t_vectorx*(u));
	                ds_list_add(list_raw,yp_prev+t_vectory*(u));
	                ds_list_add(list_raw,0);
	                ds_list_add(list_raw,c);
	            }
	        }
			else
			{
				//no action needed
				t_totalrem = opt_dist+t_totalrem-t_lengthwanted;
			}
        
	        //normal point, writing
	        ds_list_add(list_raw,xp);
	        ds_list_add(list_raw,yp);
	        ds_list_add(list_raw,0);
	        ds_list_add(list_raw,c);
        
	        xp_prev_prev = xp_prev;
	        yp_prev_prev = yp_prev;
	        xp_prev = xp;
	        yp_prev = yp;
	        c_prev = c;
	    }
        
	    bl_prev = 1;
	}

	//back to middle
	xp = mid_x;
	yp = mid_y;
	opt_dist = point_distance(xp_prev,yp_prev,xp,yp);

	//BLANKING
	if (opt_dist < 280) //connecting segments
	{            
		//dwell on blanking start
		t_true_dwell_falling = controller.opt_maxdwell; //worst case
                            
	    //dwell on blanking start
	    repeat (controller.opt_maxdwell_blank)
	    {
	        ds_list_add(list_raw,xp_prev);
	        ds_list_add(list_raw,yp_prev);
	        ds_list_add(list_raw,0);
	        ds_list_add(list_raw,c_prev);
	    }
	    repeat (t_true_dwell_falling - controller.opt_maxdwell_blank )
	    {
	        ds_list_add(list_raw,xp_prev);
	        ds_list_add(list_raw,yp_prev);
	        ds_list_add(list_raw,1);
	        ds_list_add(list_raw,0);
	    }
	}
	else //not connecting segments
	{
		var t_bezier_protrusion_length = clamp(opt_dist / 10000, 0.1, 1) * 10000; // todo this should be improved, dependent on angle
		var t_dist_prev = point_distance(xp_prev_prev, yp_prev_prev, xp_prev, yp_prev);
                        
		var t_bezier_prev_x;
		var t_bezier_prev_y;
					
		if (t_dist_prev >= 1)
		{
			t_bezier_prev_x = xp_prev + (xp_prev - xp_prev_prev) / t_dist_prev * 5000;
			t_bezier_prev_y = yp_prev + (yp_prev - yp_prev_prev) / t_dist_prev * 5000;
			
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
					
		bezier_coeffs(xp_prev, yp_prev, t_bezier_prev_x, t_bezier_prev_y, xp, yp, xp, yp);
					
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
					
                
		//dwell on blanking start
		repeat (controller.opt_maxdwell_blank)
		{
		    ds_list_add(list_raw,xp_prev);
		    ds_list_add(list_raw,yp_prev);
		    ds_list_add(list_raw,(c_prev == 0));
		    ds_list_add(list_raw,c_prev);
		}
	    repeat (t_true_dwell_rising - controller.opt_maxdwell_blank*2 )
	    {
	        ds_list_add(list_raw,xp_prev);
	        ds_list_add(list_raw,yp_prev);
	        ds_list_add(list_raw,1);
	        ds_list_add(list_raw,0);
	    }
		repeat (controller.opt_maxdwell_blank)
		{
		    ds_list_add(list_raw,xp_prev);
		    ds_list_add(list_raw,yp_prev);
		    ds_list_add(list_raw,1);
		    ds_list_add(list_raw,0);
		}
                    
		new_dot = 1;
					
		// travel in the bezier curve
		var t_quantumsteps = ceil(opt_dist / (a_ballistic*6));
					
		for (k = 0; k <= t_quantumsteps; k++)
		{
			var t_t = ease_in_out(k / t_quantumsteps);
		    ds_list_add(list_raw,bezier_x(t_t));
		    ds_list_add(list_raw,bezier_y(t_t));
		    ds_list_add(list_raw,1);
		    ds_list_add(list_raw,0);
		}
	}
	
  
	ds_list_free_pool(order_list); order_list = -1;
	ds_list_free_pool(polarity_list); polarity_list =-1;

	//final removal or adding of ending points to match perfectly
	if (ds_list_size(list_raw)/4-1 > t_totalpointswanted)
	{
	    /*if (controller.opt_warning_flag != 1)
	    {
	        //show_message_new("Failed to optimize the file based on the selected scanning speed and FPS. Please reduce the complexity of frame [ "+string(j)+" ] or use the exported file at your own risk");
	        controller.opt_warning_flag = 1;
	    }*/
	}
	else while (ds_list_size(list_raw)/4 < t_totalpointswanted)
	{
	    ds_list_add(list_raw,mid_x);
	    ds_list_add(list_raw,mid_y);
	    ds_list_add(list_raw,1);
	    ds_list_add(list_raw,0);
	}
  
	//log("make_frame",get_timer() - timerbm);



}
