function make_frame() {
	//if (debug_mode)
	//    log("make_frame");
    
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
		if ((controller.opt_maxdist/t_lengthwanted) < 0.1)
		{
			controller.fpsmultiplier = 3;
		}
		else if ((controller.opt_maxdist/t_lengthwanted) < 0.25)
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
		
		var t_num_edge_overlaps = 0;
		if (listsize > 1)
		{
			var t_x_first = xo+list_id[| 20+0];
			var t_y_first = yo+list_id[| 20+1];
			var t_x_last = xo+list_id[| ds_list_size(list_id)-4+0];
			var t_y_last = yo+list_id[| ds_list_size(list_id)-4+1];
			if (abs(t_x_first - t_x_last) < 200 && abs(t_y_first == t_y_last) < 200)
				t_num_edge_overlaps = min(floor(listsize / 2), ceil(controller.opt_scanspeed/6000));
		}
    
	    for (var t_i = 1; t_i < listsize; t_i++)
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
				
	            if ((t_y > $ffff) || (t_y < 0) || (t_x > $ffff) || (t_x < 0))
	            {
	                //list_id[| currentpos+2 ] = 1;
	                bl_prev = 1;
	                continue;
	            }
				
		        xp = x_lowerbound_top+(x_lowerbound_bottom-x_lowerbound_top)*(($ffff-t_y)/$ffff)+t_x*(x_scale_top+(x_scale_bottom-x_scale_top)*(($ffff-t_y)/$ffff));
		        yp = y_lowerbound_left+(y_lowerbound_right-y_lowerbound_left)*(t_x/$ffff)+t_y*(y_scale_left+(y_scale_right-y_scale_left)*(t_x/$ffff));
                
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
				
	            if ((t_y >= $ffff) || (t_y <= 0) || (t_x >= $ffff) || (t_x <= 0))
	            {
	                continue;
	            }
				
		        xpp = x_lowerbound_top+(x_lowerbound_bottom-x_lowerbound_top)*(($ffff-t_y)/$ffff)+t_x*(x_scale_top+(x_scale_bottom-x_scale_top)*(($ffff-t_y)/$ffff));
		        ypp = y_lowerbound_left+(y_lowerbound_right-y_lowerbound_left)*(t_x/$ffff)+t_y*(y_scale_left+(y_scale_right-y_scale_left)*(t_x/$ffff));
                
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
	            else //not connecting segments
	            {
	                angle_blank = point_direction(xpp,ypp, xp_prev,yp_prev);
                    
	                if ((xpp == xp) && (ypp == yp))
	                {
	                    t_true_dwell_falling = round(controller.opt_maxdwell*0.2);
	                }
	                else
	                {
	                    angle_next = point_direction(xpp,ypp, xp,yp);
                        
	                    t_true_dwell_falling =  round(controller.opt_maxdwell * 
	                                            (1- abs(angle_difference( angle_blank, angle_next ))/180));
	                }
                    
	                if ((xp_prev_prev == xp_prev) && (yp_prev_prev == yp_prev))
	                {
	                    t_true_dwell_rising = round(controller.opt_maxdwell*0.2);
	                }
	                else
	                {
	                    angle_prev = point_direction(xp_prev_prev,yp_prev_prev, xp_prev,yp_prev);
                
	                    t_true_dwell_rising =  round(controller.opt_maxdwell * 
	                                            (1- abs(angle_difference( angle_prev, angle_blank ))/180));
	                }
                
	                //dwell on blanking start, unless it's the start of frame in the middle
					if (i != 0)
					{
		                repeat (controller.opt_maxdwell_blank)
		                {
		                    ds_list_add(list_raw,xp_prev);
		                    ds_list_add(list_raw,yp_prev);
		                    ds_list_add(list_raw,(c_prev == 0));
		                    ds_list_add(list_raw,c_prev);
		                }
		                repeat ( max(controller.opt_maxdwell_blank, t_true_dwell_rising - controller.opt_maxdwell_blank) )
		                {
		                    ds_list_add(list_raw,xp_prev);
		                    ds_list_add(list_raw,yp_prev);
		                    ds_list_add(list_raw,1);
		                    ds_list_add(list_raw,0);
		                }
					}
                    
	                new_dot = 1;
                    
	                //travel
	                //opt_vectorx = (xp_prev-xpp)/opt_dist;
	                //opt_vectory = (yp_prev-ypp)/opt_dist;
                    
	                //find number of steps and step size
	                var t_trav_dist = a_ballistic;
					var t_quantumstepssqrt = ceil(sqrt(opt_dist/t_trav_dist));
					var t_numsteps = t_quantumstepssqrt * 2;
					for (k = 0; k <= t_numsteps ; k++)
	                {
						var t_t = ease_in_out(k / t_numsteps);
	                    ds_list_add(list_raw,xp_prev + (xpp - xp_prev) * t_t);
	                    ds_list_add(list_raw,yp_prev + (ypp - yp_prev) * t_t);
	                    ds_list_add(list_raw,1);
	                    ds_list_add(list_raw,0);
	                }
	                /*var t_quantumsteps = t_quantumstepssqrt*t_quantumstepssqrt;
	                t_trav_dist = opt_dist/t_quantumsteps;
	                var t_trav_dist_x = -t_trav_dist*(xp_prev-xpp)/opt_dist;
	                var t_trav_dist_y = -t_trav_dist*(yp_prev-ypp)/opt_dist;
                    
	                //travel first and second half of segment
	                var t_step_dist_x = 0;
	                var t_step_dist_y = 0;
	                var t_xp_now = xp_prev;
	                var t_yp_now = yp_prev;
                    
					
	                for (k = 0; k < t_quantumstepssqrt; k++)
	                {
	                    t_step_dist_x += t_trav_dist_x;
	                    t_step_dist_y += t_trav_dist_y;
                        
	                    t_xp_now += t_step_dist_x;
	                    t_yp_now += t_step_dist_y;
                        
	                    ds_list_add(list_raw,t_xp_now);
	                    ds_list_add(list_raw,t_yp_now);
	                    ds_list_add(list_raw,1);
	                    ds_list_add(list_raw,0);
	                }
	                for (k = 1; k < t_quantumstepssqrt; k++)
	                {
	                    t_step_dist_x -= t_trav_dist_x;
	                    t_step_dist_y -= t_trav_dist_y;
                        
	                    t_xp_now += t_step_dist_x;
	                    t_yp_now += t_step_dist_y;
                        
	                    ds_list_add(list_raw,t_xp_now);
	                    ds_list_add(list_raw,t_yp_now);
	                    ds_list_add(list_raw,1);
	                    ds_list_add(list_raw,0);
	                }
                    */
					//if (i == 0)
					//{
		                repeat ( max(controller.opt_maxdwell_blank, t_true_dwell_falling - controller.opt_maxdwell_blank) )
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
					//}
                    
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
			        angle_prev = point_direction(xp_prev,yp_prev, xp_prev_prev,yp_prev_prev); // todo can increase performance by saving the previous angle like we do positions?
        
			        var t_corner_dwell =  round(controller.opt_maxdwell * abs(angle_difference( angle_prev, angle_next )/180));
				
					repeat (floor(t_corner_dwell))
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
		
	        if (opt_dist+t_totalrem < t_lengthwanted70 && t_i != 1 && t_i != listsize-1 && !list_id[| currentpos+currentposadjust+2] && !bl_prev)
	        {
	            //skip point, unless it's the last one before a blanking
				t_totalrem += opt_dist;
				xp_prev_prev = xp_prev;
				yp_prev_prev = yp_prev;
				xp_prev = xp;
				yp_prev = yp;
	            continue;
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

	//BLANKING
	opt_dist = point_distance(xp_prev,yp_prev,xp,yp);

	if (opt_dist < 280) //connecting segments
	{
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
	        ds_list_add(list_raw,xp);
	        ds_list_add(list_raw,yp);
	        ds_list_add(list_raw,1);
	        ds_list_add(list_raw,0);
	    }
	}
	else //not connecting segments
	{
	    if ((xp_prev_prev == xp_prev) && (yp_prev_prev == yp_prev))
	    {
	        t_true_dwell_rising = round(controller.opt_maxdwell*0.2);
	    }
	    else
	    {
	        angle_blank = point_direction(xp,yp, xp_prev,yp_prev);
	        angle_prev = point_direction(xp_prev_prev,yp_prev_prev, xp_prev,yp_prev);

	        t_true_dwell_rising =  round(controller.opt_maxdwell * 
	                                (1- abs(angle_difference( angle_prev, angle_blank ))/180));
	    }
    
	    //dwell on blanking start
	    repeat (controller.opt_maxdwell_blank)
	    {
	        ds_list_add(list_raw,xp_prev);
	        ds_list_add(list_raw,yp_prev);
	        ds_list_add(list_raw,0);
	        ds_list_add(list_raw,c_prev);
	    }
	    repeat ( max(controller.opt_maxdwell_blank, t_true_dwell_rising - controller.opt_maxdwell_blank) )
	    {
	        ds_list_add(list_raw,xp_prev);
	        ds_list_add(list_raw,yp_prev);
	        ds_list_add(list_raw,1);
	        ds_list_add(list_raw,0);
	    }
    
	    //travel
	    //opt_vectorx = (xp_prev-xp)/opt_dist;
	    //opt_vectory = (yp_prev-yp)/opt_dist;
    
	    //find number of steps and step size
	    var t_trav_dist = a_ballistic;
	    var t_quantumstepssqrt = ceil(sqrt(opt_dist/t_trav_dist));
		var t_numsteps = t_quantumstepssqrt * 2;
		for (k = 0; k <= t_numsteps ; k++)
	    {
			var t_t = ease_in_out(k / t_numsteps);
	        ds_list_add(list_raw,xp_prev + (xp - xp_prev) * t_t);
	        ds_list_add(list_raw,yp_prev + (yp - yp_prev) * t_t);
	        ds_list_add(list_raw,1);
	        ds_list_add(list_raw,0);
	    }
	    /*var t_quantumsteps = t_quantumstepssqrt*t_quantumstepssqrt;
	    t_trav_dist = opt_dist/t_quantumsteps;
	    var t_trav_dist_x = -t_trav_dist*(xp_prev-xp)/opt_dist;
	    var t_trav_dist_y = -t_trav_dist*(yp_prev-yp)/opt_dist;
    
	    //travel first and second half of segment
	    var t_step_dist_x = 0;
	    var t_step_dist_y = 0;
	    var t_xp_now = xp_prev;
	    var t_yp_now = yp_prev;
    
	    for (k = 0; k < t_quantumstepssqrt; k++)
	    {
	        t_step_dist_x += t_trav_dist_x;
	        t_step_dist_y += t_trav_dist_y;
        
	        t_xp_now += t_step_dist_x;
	        t_yp_now += t_step_dist_y;
        
	        ds_list_add(list_raw,t_xp_now);
	        ds_list_add(list_raw,t_yp_now);
	        ds_list_add(list_raw,1);
	        ds_list_add(list_raw,0);
	    }
	    for (k = 1; k < t_quantumstepssqrt; k++)
	    {
	        t_step_dist_x -= t_trav_dist_x;
	        t_step_dist_y -= t_trav_dist_y;
        
	        t_xp_now += t_step_dist_x;
	        t_yp_now += t_step_dist_y;
        
	        ds_list_add(list_raw,t_xp_now);
	        ds_list_add(list_raw,t_yp_now);
	        ds_list_add(list_raw,1);
	        ds_list_add(list_raw,0);
	    }*/
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
