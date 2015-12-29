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
            if (controller.exp_optimize)
                {
                if (outside_flag == 0)
                    {
                    outside_flag = 1;
                    repeat (controller.opt_maxdwell)
                        {
                        //dwell on blanking start
                        ds_list_add(list_raw,xp_prev);
                        ds_list_add(list_raw,yp_prev);
                        ds_list_add(list_raw,1);
                        ds_list_add(list_raw,0);
                        maxpoints_static++;
                        }
                    }
                }
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
                repeat (controller.opt_maxdwell)
                    {
                    //dwell on blanking start
                    ds_list_add(list_raw,xp_prev);
                    ds_list_add(list_raw,yp_prev);
                    ds_list_add(list_raw,1);
                    ds_list_add(list_raw,0);
                    maxpoints_static++;
                    }
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
            maxpoints_static++;
            if (controller.exp_optimize)
                {
                //interpolate blanking
                opt_dist = point_distance(xp_prev,yp_prev,xp,yp);
                if (opt_dist > 10)
                    {
                    new_point = 1;
                    opt_vectorx = (xp_prev-xp)/opt_dist;
                    opt_vectory = (yp_prev-yp)/opt_dist;
                    trav = -controller.opt_maxdist;
                    for (trav_dist = trav/2;trav_dist >= -opt_dist; trav_dist += trav;)
                        {
                        xp_now = xp_prev+opt_vectorx*trav_dist;
                        yp_now = yp_prev+opt_vectory*trav_dist;
                        
                        ds_list_add(list_raw,xp_now);
                        ds_list_add(list_raw,yp_now);
                        ds_list_add(list_raw,1);
                        ds_list_add(list_raw,0);
                        maxpoints_static++;
                        }
                    }
                else
                    {
                    if (new_point == 1)
                        {
                        ds_list_add(list_points,ds_list_size(list_raw)-4);
                        new_point = 0;
                        }
                    }
                }
            ds_list_add(list_raw,xp);
            ds_list_add(list_raw,yp);
            ds_list_add(list_raw,1);
            ds_list_add(list_raw,0);
            if (controller.exp_optimize)
                {
                maxpoints_static++;
                repeat (controller.opt_maxdwell-1)
                    {
                    //dwell on blanking end
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
        
    xp_prev = xp;
    yp_prev = yp;
    bl_prev = 0;
        
    //writing point
    ds_list_add(list_raw,xp);
    ds_list_add(list_raw,yp);
    ds_list_add(list_raw,bl);
    ds_list_add(list_raw,c);
    }
