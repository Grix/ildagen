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
	
	//log("start, order first: ", order_list[| 0]);
	//var t_litpoints = 0;
  
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
		
		var t_is_overlapping = false;
		var t_edge_overlap_length = list_id[| 12];
		var t_edge_overlap_length_so_far = 0;
    
	    for (var t_i = 1; t_i < listsize; t_i++)
	    {
	        currentpos += currentposadjust;
        
	        bl = ds_list_find_value(list_id,currentpos+2);
        
	        if (bl)
	        {
	            bl_prev = 1;
	            new_dot = 1;
				if (t_is_overlapping)
				{
					// This slightly underestimates our point budget and wastes some blanking at end of frame, but cba to fix
					break;
				}
					
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
				var t_c_first = list_id[| t_prevpos+3 ];
				
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
				
				if (t_edge_overlap_length_so_far < t_edge_overlap_length)
				{
					var t_ratio = t_edge_overlap_length_so_far / t_edge_overlap_length;
					if (t_is_overlapping)
					{
						if (t_ratio < 0.5)
							t_ratio = 0;
						else
							t_ratio = 0.5+t_ratio/2;
						t_c_first = merge_color(c, c_black, t_ratio);
					}
					else
						t_c_first = merge_color(c, c_black, 1 - t_ratio);
				}
                
	            if (opt_dist < 280) //connecting segments
	            {
	                angle_next = point_direction(xp,yp, xpp,ypp);
	                angle_prev = point_direction(xp_prev,yp_prev, xp_prev_prev,yp_prev_prev);
                
	                t_true_dwell_falling =  round(controller.opt_maxdwell * (1- abs(angle_difference( angle_prev, angle_next ))/180));
                                            
	                //dwell on blanking start
	                /*repeat (controller.opt_mindwell-1)
	                {
	                    ds_list_add(list_raw,xp_prev);
	                    ds_list_add(list_raw,yp_prev);
	                    ds_list_add(list_raw,(c_prev == 0));
	                    ds_list_add(list_raw,c_prev);
	                }*/
	                repeat (floor(t_true_dwell_falling/2)) // - (min(0,(controller.opt_mindwell-1))*2/*+1*/) ) // todo remove lit points at these corners? Normal corners dont have them
	                {
	                    ds_list_add(list_raw,xp_prev);
	                    ds_list_add(list_raw,ypp);
	                    ds_list_add(list_raw,(c_prev == 0));  //1);
	                    ds_list_add(list_raw,c_prev);  //0);
	                }
					repeat (ceil(t_true_dwell_falling/2)) // - (min(0,(controller.opt_mindwell-1))*2/*+1*/) ) // todo remove lit points at these corners? Normal corners dont have them
	                {
	                    ds_list_add(list_raw,xp_prev);
	                    ds_list_add(list_raw,ypp);
	                    ds_list_add(list_raw,(t_c_first == 0));  //1);
	                    ds_list_add(list_raw,t_c_first);  //0);
	                }
	                /*repeat (controller.opt_mindwell-1)//+1)
	                {
	                    ds_list_add(list_raw,xpp);
	                    ds_list_add(list_raw,ypp);
	                    ds_list_add(list_raw,0);
	                    ds_list_add(list_raw,t_c_first);
	                }*/
					//log("connecting on ", i, t_true_dwell_falling);
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
                        
	                    t_true_dwell_falling =  round(controller.opt_maxdwell * (1- abs(angle_difference( angle_blank, angle_next ))/180));
	                }
                    
	                if ((xp_prev_prev == xp_prev) && (yp_prev_prev == yp_prev))
	                {
	                    t_true_dwell_rising = round(controller.opt_maxdwell*0.2);
	                }
	                else
	                {
	                    angle_prev = point_direction(xp_prev_prev,yp_prev_prev, xp_prev,yp_prev);
                
	                    t_true_dwell_rising =  round(controller.opt_maxdwell * (1- abs(angle_difference( angle_prev, angle_blank ))/180));
	                }
                
	                //dwell on blanking start, unless it's the start of frame in the middle
					if (i != 0)
					{
		                repeat (controller.opt_mindwell)
		                {
		                    ds_list_add(list_raw,xp_prev);
		                    ds_list_add(list_raw,yp_prev);
		                    ds_list_add(list_raw,(c_prev == 0));
		                    ds_list_add(list_raw,c_prev);
		                }
		                repeat ( max(controller.opt_mindwell, t_true_dwell_rising - controller.opt_mindwell) )
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
					//if (i == 0)
					//{
		                repeat ( max(controller.opt_mindwell, t_true_dwell_falling - (controller.opt_mindwell/* + 1*/)) )
		                {
		                    ds_list_add(list_raw,xpp);
		                    ds_list_add(list_raw,ypp);
		                    ds_list_add(list_raw,1);
		                    ds_list_add(list_raw,0);
		                }
		                repeat (controller.opt_mindwell)// + 1)
		                {
		                    ds_list_add(list_raw,xpp);
		                    ds_list_add(list_raw,ypp);
		                    ds_list_add(list_raw,0);
		                    ds_list_add(list_raw,t_c_first);
		                }
					//}
                    
					//log("NOT connecting on ", i, t_true_dwell_falling + t_true_dwell_rising + t_numsteps);
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
				
			if (t_edge_overlap_length_so_far < t_edge_overlap_length)
			{
				var t_ratio = t_edge_overlap_length_so_far / t_edge_overlap_length;
				if (t_is_overlapping)
				{
					if (t_ratio < 0.5)
						t_ratio = 0;
					else
						t_ratio = (t_ratio-0.5)*2;
					c = merge_color(c, c_black, t_ratio);
				}
				else
					c = merge_color(c, c_black, 1 - t_ratio);
					
				t_edge_overlap_length_so_far += opt_dist;
			}
			else if (t_is_overlapping)
			{
				c_prev = 0;
				break;
			}
		
	        if (opt_dist+t_totalrem < t_lengthwanted70 && (t_is_overlapping || (t_i != 1 && t_i != listsize-1)) && !list_id[| currentpos+currentposadjust+2] && !bl_prev)
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
				var t_stepscount = floor((opt_dist+t_totalrem) / t_lengthwanted);
				t_totalrem = opt_dist+t_totalrem - t_lengthwanted*(t_stepscount+1);
				t_vectorx = (xp-xp_prev)/t_stepscount;
	            t_vectory = (yp-yp_prev)/t_stepscount;
	            for (u = 0; u < t_stepscount; u++)
	            {
					//t_litpoints++;
	                ds_list_add(list_raw,xp_prev+t_vectorx*(u));
	                ds_list_add(list_raw,yp_prev+t_vectory*(u));
	                ds_list_add(list_raw,0);
	                ds_list_add(list_raw,c); // todo merge_color to interpolate?
	            }
	            /*t_totalrem += t_lengthwanted - (opt_dist % t_lengthwanted);
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
					t_litpoints++;
	                ds_list_add(list_raw,xp_prev+t_vectorx*(u));
	                ds_list_add(list_raw,yp_prev+t_vectory*(u));
	                ds_list_add(list_raw,0);
	                ds_list_add(list_raw,c);
	            }*/
	        }
			else
			{
				//no action needed
				t_totalrem = opt_dist+t_totalrem-t_lengthwanted;
			}
        
	        //normal point, writing
			//t_litpoints++;
	        ds_list_add(list_raw,xp);
	        ds_list_add(list_raw,yp);
	        ds_list_add(list_raw,0);
	        ds_list_add(list_raw,c);
        
	        xp_prev_prev = xp_prev;
	        yp_prev_prev = yp_prev;
	        xp_prev = xp;
	        yp_prev = yp;
	        c_prev = c;
			
			if (t_edge_overlap_length > 0)
			{
				if (t_is_overlapping)
				{
					if (t_edge_overlap_length_so_far >= t_edge_overlap_length)
					{
						break;
					}
				}
				else if (t_i == listsize-1)
				{
					t_is_overlapping = true;
					t_edge_overlap_length *= 2;
					t_edge_overlap_length_so_far = 0;
					t_i = 0;
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
				}
			}
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
		//log("connecting on last");
	    t_true_dwell_falling = controller.opt_maxdwell; //worst case
                            
	    //dwell on blanking start
	    repeat (controller.opt_mindwell)
	    {
	        ds_list_add(list_raw,xp_prev);
	        ds_list_add(list_raw,yp_prev);
	        ds_list_add(list_raw,0);
	        ds_list_add(list_raw,c_prev);
	    }
	    repeat (t_true_dwell_falling - controller.opt_mindwell )
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

	        t_true_dwell_rising =  round(controller.opt_maxdwell * (1- abs(angle_difference( angle_prev, angle_blank ))/180));
	    }
    
	    //dwell on blanking start
	    repeat (controller.opt_mindwell)
	    {
	        ds_list_add(list_raw,xp_prev);
	        ds_list_add(list_raw,yp_prev);
	        ds_list_add(list_raw,0);
	        ds_list_add(list_raw,c_prev);
	    }
	    repeat ( max(controller.opt_mindwell, t_true_dwell_rising - controller.opt_mindwell) )
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
	}
  
	ds_list_free_pool(order_list); order_list = -1;
	ds_list_free_pool(polarity_list); polarity_list =-1;
	
	//log("result: ", ds_list_size(list_raw)/4, t_lengthwanted, maxpoints_static, lit_length, t_litpoints, t_litpointswanted, t_totalrem);

	//final removal or adding of ending points to try to match perfectly
	if (ds_list_size(list_raw)/4-1 > t_totalpointswanted)
	{
		var t_remove_num = min(min(5, (ds_list_size(list_raw)/4-1) - t_totalpointswanted), ds_list_size(list_raw)/4-3);
		repeat (t_remove_num)
		{
			ds_list_delete(list_raw, ds_list_size(list_raw)-1);
			ds_list_delete(list_raw, ds_list_size(list_raw)-1);
			ds_list_delete(list_raw, ds_list_size(list_raw)-1);
			ds_list_delete(list_raw, ds_list_size(list_raw)-1);
		}
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
