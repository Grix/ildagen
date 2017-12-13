if (debug_mode)
    log("prepare_output_points");

listsize = ((ds_list_size(list_id)-20)/4);
var t_blindzonelistsize = ds_list_size(controller.blindzone_list);
var t_true_dwell_falling, t_true_dwell_rising;
var t_contflag = false;

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
		var t_x = xo+list_id[| currentpos+0];
		var t_y = $ffff-(yo+list_id[| currentpos+1]);
        xp = x_lowerbound+(x_lowerbound-x_lowerbound)*(t_x/$ffff)+t_x*(x_scale+(x_scale-x_scale)*(t_x/$ffff));
        yp = y_lowerbound+(y_lowerbound-y_lowerbound)*(t_y/$ffff)+t_y*(y_scale+(y_scale-y_scale)*(t_y/$ffff));
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
                continue;
            }
        }
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
        //xpp = x_lowerbound+(xo+list_id[| t_prevpos+0])*x_scale;
        //ypp = y_lowerbound+($ffff-(yo+list_id[| t_prevpos+1]))*y_scale;
		var t_x = xo+list_id[| t_prevpos+0];
		var t_y = $ffff-(yo+list_id[| t_prevpos+1]);
        xpp = x_lowerbound+(x_lowerbound-x_lowerbound)*(t_x/$ffff)+t_x*(x_scale+(x_scale-x_scale)*(t_x/$ffff));
        ypp = y_lowerbound+(y_lowerbound-y_lowerbound)*(t_y/$ffff)+t_y*(y_scale+(y_scale-y_scale)*(t_y/$ffff));
        opt_dist = point_distance(xp_prev,yp_prev,xpp,ypp);
        
        if (opt_dist < 250) //connecting segments
        {
            angle_next = point_direction(xp,yp, xpp,ypp);
            angle_prev = point_direction(xp_prev,yp_prev, xp_prev_prev,yp_prev_prev);
        
            t_true_dwell_falling =  round(controller.opt_maxdwell * 
                                    (1- abs(angle_difference( angle_prev, angle_next ))/180));
        
                
            maxpoints_static += ( (controller.opt_maxdwell_blank)*2
                                   + abs(t_true_dwell_falling - controller.opt_maxdwell_blank*2) );
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
        
            var t_trav_dist = a_ballistic;
            var t_n = 1;
            //var t_quantumsteps = 0;
            var t_totaldist = 0;
            while (1)
            {
                t_totaldist += (t_n + t_n-1)*t_trav_dist;
                //t_quantumsteps += (t_n + t_n-1);
                if (t_totaldist > opt_dist)
                    break;
                t_n++;
            }
                 
            maxpoints_static += (   2*(controller.opt_maxdwell_blank) 
                                    +  max(controller.opt_maxdwell_blank, t_true_dwell_rising - controller.opt_maxdwell_blank)
                                    +  max(controller.opt_maxdwell_blank, t_true_dwell_falling - controller.opt_maxdwell_blank)
                                    +  (t_n + t_n - 1) );
        }
        
        xp_prev = xpp;
        yp_prev = ypp;
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
    bl_prev = 0;
}


