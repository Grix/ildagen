function prepare_output_bezier() {
	//if (debug_mode)
	//    log("prepare_output");

	list_raw = ds_list_create_pool();

	order_list = ds_list_create_pool();
	polarity_list = ds_list_create_pool();

	lit_length = 0;
	numrawpoints = 0;
	maxpoints_static = 0;
	maxpoints_dots = 0;

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

	xp_prev = mid_x;
	yp_prev = mid_y;
	xp_prev_prev = mid_x;
	yp_prev_prev = mid_y;
	bl_prev = 1;
	c_prev = 0;
	new_dot = 1;

	a_ballistic = controller.opt_maxdist; //scanner acceleration

	var t_pol = 0;
	var t_order = 0;
	var t_lowestdist, t_dist;
	var t_found = 0;
	var t_list_empties = ds_list_create_pool();

	//checking best element order
	// TODO can be made better by accounting for bezier curve lengths
	while (ds_list_size(order_list) < (ds_list_size(el_list)-ds_list_size(t_list_empties)))
	{
	    t_lowestdist = $fffff;
	    for (i = 0; i < ds_list_size(el_list); i++)
	    {
	        if (ds_list_find_index(order_list,i) != -1)
	            continue;
            
	        list_id = el_list[| i];
        
	        if (ds_list_find_index(t_list_empties, list_id) != -1)
	            continue;
			
			if (ds_list_size(list_id) <= 22)
			{
				ds_list_add(t_list_empties, list_id);
				continue;
			}
        
	        xo = list_id[| 0];
	        yo = list_id[| 1];
	        t_found = 0;
			
			/*if (is_undefined(xo) || is_undefined(yo))
			{
				xo = list_id[| 0] = 0;
				yo = list_id[| 1] = 0;
				http_post_string(   "https://www.bitlasers.com/lasershowgen/bugreport.php",
			                "bug=OS: " + string(os_type) + " VER: "+string(controller.version) +  "\r\n"+t_actionhistory + "\n\rERROR: xo or yo was undefined in prepare_output. xo: "+string(xo)+", yo: "+string(yo) +", tool: "+string(controller.placing));
			}*/
        
	        xp = xo+list_id[| 20];
	        yp = yo+list_id[| 21];
        
	        t_dist = point_distance(xp_prev,yp_prev,xp,yp);
	        if (t_dist < t_lowestdist)
	        {
	            t_order = i;
	            t_pol = 0;
	            if (t_dist < 280)
	                break;
	            t_lowestdist = t_dist;
	        }
        
	        if (!list_id[| 11])
	        {
	            currentpos = ds_list_size(list_id)-4;
	            xp = xo+list_id[| currentpos+0];
	            yp = yo+list_id[| currentpos+1];
            
	            t_dist = point_distance(xp_prev,yp_prev,xp,yp);
	            if (t_dist < t_lowestdist)
	            {
	                t_order = i;
	                t_pol = 1;
	                if (t_dist < 280)
	                    break;
	                t_lowestdist = t_dist;
	            }
	        }
	    }
	    if ((ds_list_size(el_list)-ds_list_size(t_list_empties)) > 0)
	    {
	        list_id = el_list[| t_order];
	        if (t_pol)
	            currentpos = 20;
	        else
	            currentpos = ds_list_size(list_id)-4;
            
	        xp_prev = list_id[| 0]+list_id[| currentpos+0];
	        yp_prev = list_id[| 1]+list_id[| currentpos+1];
	        ds_list_add(order_list,t_order);
	        ds_list_add(polarity_list,t_pol);
	    }
	}

	if ((ds_list_size(el_list)-ds_list_size(t_list_empties)) <= 0)
	{
	    ds_list_free_pool(order_list); order_list = -1;
		ds_list_free_pool(polarity_list); polarity_list =-1;
		ds_list_free_pool(t_list_empties); t_list_empties = -1;
		ds_list_free_pool(list_raw); list_raw = -1;
	    return 0;
	}
       
	xp_prev = mid_x;
	yp_prev = mid_y;

	//parse elements

	var t_numofelems = ds_list_size(order_list);
    
	for (i = 0; i < t_numofelems; i++)
	{
	    list_id = ds_list_find_value(el_list,order_list[| i]);
        
	    if (is_undefined(list_id))
	        continue;

	    xo = ds_list_find_value(list_id,0);
	    yo = ds_list_find_value(list_id,1);
        
	    prepare_output_points_bezier();
    
	    //maxpoints_static++;
       
	    bl_prev = 1;
	}

	if (xp_prev != mid_x) and (yp_prev != mid_y)
	{
	    //back to middle
	    xp = mid_x;
	    yp = mid_y;
    
	    //BLANKING
	    opt_dist = point_distance(xp_prev,yp_prev,xp,yp);
    
	    if (opt_dist < 280) //connecting segments
	    {
	        var t_true_dwell = controller.opt_maxdwell;
	        maxpoints_static += (   (controller.opt_maxdwell_blank)
	                                +  abs(t_true_dwell - controller.opt_maxdwell_blank) );
	    }
	    else
	    {
			var t_bezier_protrusion_length = clamp(opt_dist / 10000, 0.1, 1) * 10000;
			var t_true_dwell = 0;
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
                
					t_true_dwell =  round(controller.opt_maxdwell * 
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
                 
	        var t_quantumsteps = ceil(opt_dist / (a_ballistic*6));
             
	        maxpoints_static += (   (controller.opt_maxdwell_blank) 
	                                +  max(controller.opt_maxdwell_blank, t_true_dwell - controller.opt_maxdwell_blank)
	                                +  t_quantumsteps);
	    }
	}

	ds_list_free_pool(t_list_empties); t_list_empties = -1;

	//numrawpoints += maxpoints_dots;

	return 1;




}
