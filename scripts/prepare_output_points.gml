listsize = ((ds_list_size(list_id)-20)/4);
var t_blindzonelistsize = ds_list_size(controller.blindzone_list);
var t_true_dwell_falling, t_true_dwell_rising;
var t_contflag = false;

if (polarity_list[| i] == 0)
{
    currentpos = 16;
    currentposadjust = 4;
}
else
{
    currentpos = ds_list_size(list_id);
    currentposadjust = -4;
}

//walk through list to get lit length and static point count
var t_i;
for (t_i = 0; t_i < listsize; t_i++)
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
    xp = x_lowerbound+(xo+list_id[| currentpos+0])*x_scale;
    yp = y_lowerbound+($ffff-(yo+list_id[| currentpos+1]))*y_scale;
   
    if ((yp >= $fffe) || (yp <= 1) || (xp >= $fffe) || (xp <= 1))
    {
        //list_id[| currentpos+2 ] = 1;
        bl_prev = 1;
        continue;
    }
    
    for (j = 0; j < t_blindzonelistsize; j+= 4)
    {
        if ((xp >= controller.blindzone_list[| j+0]) 
        &&  (xp <= controller.blindzone_list[| j+1])
        &&  (yp <= $FFFF-controller.blindzone_list[| j+2]) 
        &&  (yp >= $FFFF-controller.blindzone_list[| j+3]))
        {
            //list_id[| currentpos+2 ] = 1;
            bl_prev = 1;
            t_contflag = true;
            continue;
        }
    }
    
    if (t_contflag)
    {
        t_contflag = false;
        continue;
    }
    
    //valid point, process it
    
    //c = ds_list_find_value(list_id,currentpos+3);
    
    if (controller.exp_optimize)
    {
        opt_dist = point_distance(xp,yp,xp_prev,yp_prev);
        
        if (bl_prev)
        {
            //todo maybe add reference to current position so we don't 
            //have to parse through all blanked points when writing
        
            //BLANKING
            
            if (opt_dist < 250) //connecting segments
            {
                var t_nextpos = currentpos+currentposadjust;
                if (!is_undefined(list_id[| t_nextpos ]))
                {
                    xpn = x_lowerbound+(xo+list_id[| t_nextpos+0])*x_scale;
                    ypn = y_lowerbound+($ffff-(yo+list_id[| t_nextpos+1]))*y_scale;
                    
                    angle_next = point_direction(xpn,ypn, xp,yp);
                    angle_prev = point_direction(xp_prev,yp_prev, xp_prev_prev,yp_prev_prev);
                
                    t_true_dwell_falling =  round(controller.opt_maxdwell * 
                                            (1- abs(angle_difference( angle_prev, angle_next ))/180));
                }
                else
                    t_true_dwell_falling = controller.opt_maxdwell;
                    
                maxpoints_static += ( (controller.opt_maxdwell_blank)*2
                                       + abs(t_true_dwell_falling - controller.opt_maxdwell_blank*2) );
            }
            else //not connecting segments
            {
                angle_blank = point_direction(xp,yp, xp_prev,yp_prev);
                var t_nextpos = currentpos+currentposadjust;
                if (!is_undefined(list_id[| t_nextpos ]))
                {
                    xpn = x_lowerbound+(xo+list_id[| t_nextpos+0])*x_scale;
                    ypn = y_lowerbound+($ffff-(yo+list_id[| t_nextpos+1]))*y_scale;
                    
                    if ((xpn == xp) && (ypn == yp))
                    {
                        t_true_dwell_falling = round(controller.opt_maxdwell*0.2);
                    }
                    else
                    {
                        angle_next = point_direction(xp,yp, xpn,ypn);
                        
                        t_true_dwell_falling =  round(controller.opt_maxdwell * 
                                                (1- abs(angle_difference( angle_blank, angle_next ))/180));
                    }
                }
                else
                {   
                    t_true_dwell_falling = controller.opt_maxdwell; //for worst case scenario
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
                var t_quantumsteps = 0;
                var t_totaldist = 0;
                while (1)
                {
                    t_totaldist += (t_n + t_n-1)*t_trav_dist;
                    t_quantumsteps += (t_n + t_n-1);
                    if (t_totaldist > opt_dist)
                        break;
                    t_n++;
                }
                     
                maxpoints_static += (   2*(controller.opt_maxdwell_blank) 
                                        +  max(controller.opt_maxdwell_blank, t_true_dwell_rising - controller.opt_maxdwell_blank)
                                        +  max(controller.opt_maxdwell_blank, t_true_dwell_falling - controller.opt_maxdwell_blank)
                                        +  (t_n + t_n) );
            }
        }
        else
            lit_length+= opt_dist;
        
        if (opt_dist == 0)
        {
            maxpoints_dots++;
            currentdotsize++;
            new_dot = 1;
        }
        else
        {
            if ((new_dot) && (currentdotsize > 1))
            {
                num_dots++;
                maxpoints_dots++;
                if (currentdotsize < smallestdotsize)
                    smallestdotsize = currentdotsize;
                currentdotsize = 0;
            }
            new_dot = 0;
        }
    }
    
    xp_prev_prev = xp_prev;
    yp_prev_prev = yp_prev;
    xp_prev = xp;
    yp_prev = yp;
    //c_prev = c;
    bl_prev = 0;
}

if ((new_dot) && (currentdotsize > 1))
{
    num_dots++;
    maxpoints_dots++;
    if (currentdotsize < smallestdotsize)
        smallestdotsize = currentdotsize;
    currentdotsize = 0;
}



