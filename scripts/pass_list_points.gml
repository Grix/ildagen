listsize = ((ds_list_size(list_id)-20)/4);

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
maxpoints_static++;

var t_i;
for (t_i = 0; t_i < listsize; t_i++)
    {
    currentpos += currentposadjust;
    //getting values from element list
    
    xp = xo+ds_list_find_value(list_id,currentpos);
    yp = $ffff-(yo+ds_list_find_value(list_id,currentpos+1));
    bl = ds_list_find_value(list_id,currentpos+2);
    
    //check if outside bounds
    if (bl == 0)
        {
        if (yp >= $fffd) or (yp <= 2) or (xp >= $fffd) or (xp <= 2)
            {
            outside_flag = 1;
            bl_prev = 1;
            continue;
            }
        }
    outside_flag = 0; 
    
    if (bl)
        {
        if (controller.exp_optimize)
            {
            if (bl_prev == 0)
                {
                xp_prev_prev = xp_prev;
                yp_prev_prev = yp_prev;
                xp_prev = xp;
                yp_prev = yp;
                }
            }
        bl_prev = 1;
        continue;
        }
    else 
        {
        c = ds_list_find_value(list_id,currentpos+3);
        if (bl_prev)
            {
            //blanking
            maxpoints_static++;
            if (controller.exp_optimize)
                {
                repeat (controller.opt_maxdwell)
                    {
                    //dwell on start
                    ds_list_add(list_raw,xp_prev);
                    ds_list_add(list_raw,yp_prev);
                    ds_list_add(list_raw,1);
                    ds_list_add(list_raw,0);
                    maxpoints_static++;
                    }
                new_point = 1;
                //travel
                opt_dist = point_distance(xp_prev,yp_prev,xp,yp);
                opt_vectorx = (xp_prev-xp)/opt_dist;
                opt_vectory = (yp_prev-yp)/opt_dist;
                
                //find number of steps and step size
                var t_trav_dist = controller.opt_maxdist/4;
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
                t_trav_dist -= (t_totaldist-opt_dist)/t_quantumsteps;
                var t_trav_dist_x = -t_trav_dist*(xp_prev-xp)/opt_dist;
                var t_trav_dist_y = -t_trav_dist*(yp_prev-yp)/opt_dist;
                
                //travel first and second half of segment
                var t_step_dist_x = 0;
                var t_step_dist_y = 0;
                
                for (i = 0; i < t_n; i++)
                    {
                    t_step_dist_x += t_trav_dist_x;
                    t_step_dist_y += t_trav_dist_y;
                    
                    xp_now = xp_prev + t_step_dist_x;
                    yp_now = yp_prev + t_step_dist_y;
                    
                    ds_list_add(list_raw,xp_now);
                    ds_list_add(list_raw,yp_now);
                    ds_list_add(list_raw,1);
                    ds_list_add(list_raw,0);
                    maxpoints_static++;
                    }
                for (i = 1; i < t_n; i++)
                    {
                    t_step_dist_x -= t_trav_dist_x;
                    t_step_dist_y -= t_trav_dist_y;
                    
                    xp_now = xp_prev + t_step_dist_x;
                    yp_now = yp_prev + t_step_dist_y;
                    
                    ds_list_add(list_raw,xp_now);
                    ds_list_add(list_raw,yp_now);
                    ds_list_add(list_raw,1);
                    ds_list_add(list_raw,0);
                    maxpoints_static++;
                    }
                    
                if (new_point == 1)
                    {
                    ds_list_add(list_points,ds_list_size(list_raw)-4);
                    new_point = 0;
                    }
                }
            else
                {
                ds_list_add(list_raw,xp);
                ds_list_add(list_raw,yp);
                ds_list_add(list_raw,1);
                ds_list_add(list_raw,0);
                }
                
            if (controller.exp_optimize)
                {
                //dwell on blanking end
                repeat (controller.opt_maxdwell)
                    {
                    ds_list_add(list_raw,xp);
                    ds_list_add(list_raw,yp);
                    ds_list_add(list_raw,1);
                    ds_list_add(list_raw,0);
                    maxpoints_static++;
                    }
                repeat (controller.opt_maxdwell_blank)
                    {
                    ds_list_add(list_raw,xp);
                    ds_list_add(list_raw,yp);
                    ds_list_add(list_raw,bl);
                    ds_list_add(list_raw,c);
                    maxpoints_static++;
                    }
                }
            }
        else if (controller.exp_optimize)
            {
            vector_length = point_distance(xp,yp,xp_prev,yp_prev);
            if (vector_length == 0)
                {
                maxpoints_static++;
                if (new_point == 1)
                    {
                    ds_list_add(list_points,ds_list_size(list_raw)-4);
                    new_point = 0;
                    }
                }
            else
                {
                new_point = 1;
                lit_length += vector_length;
                }
            }
        }
        
    xp_prev_prev = xp_prev;
    yp_prev_prev = yp_prev;
    xp_prev = xp;
    yp_prev = yp;
    bl_prev = 0;
        
    //writing point
    ds_list_add(list_raw,xp);
    ds_list_add(list_raw,yp);
    ds_list_add(list_raw,bl);
    ds_list_add(list_raw,c);
    }
