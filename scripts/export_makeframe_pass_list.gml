list_points = ds_list_create();
list_raw = ds_list_create();

order_list = ds_list_create();
polarity_list = ds_list_create();

//start from middle
xp_prev = $8000;
yp_prev = $8000;
bl_prev = 1;
c_prev = 0;

outside_flag = 0;
lit_length = 0;
maxpoints_static = 3;
new_point = 1;

t_pol = 0;
t_order = 0;
var t_lowestdist, t_dist, t_tempxp_prev_other, t_tempyp_prev_other, t_tempxp_prev, t_tempyp_prev;
var t_found = 0;

//checking best element order
if (controller.exp_optimize == 1)
    {
    while (ds_list_size(order_list) < ds_list_size(el_list))
        {
        t_lowestdist = $fffff;
        for (i = 0;i < ds_list_size(el_list);i++)
            {
            if (ds_list_find_index(order_list,i) != -1)
                continue;
                
            list_id = ds_list_find_value(el_list,i);
            
            xo = ds_list_find_value(list_id,0);
            yo = ds_list_find_value(list_id,1);
            t_found = 0;
            
            currentpos = 20;
            while (ds_list_find_value(list_id,currentpos+2))
                currentpos += 4;
                
            if (is_undefined(list_id[| currentpos]))
                {
                ds_list_delete(el_list,i);
                continue;
                }
            
            xp = xo+ds_list_find_value(list_id,currentpos+0);
            yp = $ffff-(yo+ds_list_find_value(list_id,currentpos+1));
            t_tempxp_prev_other = xp;
            t_tempyp_prev_other = yp;
            
            t_dist = point_distance(xp_prev,yp_prev,xp,yp);
            if (t_dist < t_lowestdist)
                {
                t_lowestdist = t_dist;
                t_order = i;
                t_pol = 0;
                t_found = 1;
                }
            
            currentpos = ds_list_size(list_id)-4;
            while (ds_list_find_value(list_id,currentpos+2))
                currentpos -= 4;
            
            xp = xo+ds_list_find_value(list_id,currentpos+0);
            yp = $ffff-(yo+ds_list_find_value(list_id,currentpos+1));
            
            t_dist = point_distance(xp_prev,yp_prev,xp,yp);
            if (t_dist < t_lowestdist)
                {
                t_lowestdist = t_dist;
                t_order = i;
                t_pol = 1;
                t_tempxp_prev = t_tempxp_prev_other;
                t_tempyp_prev = t_tempxp_prev_other;
                }
            
            if (t_found = 1)
                {
                t_tempxp_prev = xp;
                t_tempyp_prev = yp;
                }
            }
        if (ds_list_size(el_list))
            {
            xp_prev = t_tempxp_prev;
            yp_prev = t_tempyp_prev;
            ds_list_add(order_list,t_order);
            ds_list_add(polarity_list,t_pol);
            }
        }
    }

if (ds_list_size(el_list) == 0)
    {
    return 0;
    }
        
xp_prev = $8000;
yp_prev = $8000;
xp_prev_prev = $8001;
yp_prev_prev = $8001;

//parse elements
for (i = 0;i < ds_list_size(el_list);i++)
    {
    if (controller.exp_optimize)
        list_id = ds_list_find_value(el_list,order_list[| i]);
    else 
        list_id = ds_list_find_value(el_list,i); 

    xo = ds_list_find_value(list_id,0);
    yo = ds_list_find_value(list_id,1);
       
    pass_list_points();
        
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
    }

if (controller.exp_optimize) and (xp_prev != $8000) and (yp_prev != $8000)
    {
    //back to middle
    xp = $8000;
    yp = $8000;
    //BLANKING
    if (controller.exp_optimize)
        {
        opt_dist = point_distance(xp_prev,yp_prev,xp,yp);
        if (opt_dist < 10) //connecting segments
            {
            //dwell on blanking start
            repeat (controller.opt_maxdwell_blank)
                {
                ds_list_add(list_raw,xp_prev);
                ds_list_add(list_raw,yp_prev);
                ds_list_add(list_raw,0);
                ds_list_add(list_raw,c_prev);
                maxpoints_static++;
                }
            repeat ( max(controller.opt_maxdwell_blank, controller.opt_maxdwell - controller.opt_maxdwell_blank) )
                {
                ds_list_add(list_raw,xp_prev);
                ds_list_add(list_raw,yp_prev);
                ds_list_add(list_raw,1);
                ds_list_add(list_raw,0);
                maxpoints_static++;
                }
            }
        else //not connecting segments
            {
            //dwell on blanking start
            repeat (controller.opt_maxdwell_blank)
                {
                ds_list_add(list_raw,xp_prev);
                ds_list_add(list_raw,yp_prev);
                ds_list_add(list_raw,0);
                ds_list_add(list_raw,c_prev);
                maxpoints_static++;
                }
            repeat ( max(controller.opt_maxdwell_blank, controller.opt_maxdwell - controller.opt_maxdwell_blank) )
                {
                ds_list_add(list_raw,xp_prev);
                ds_list_add(list_raw,yp_prev);
                ds_list_add(list_raw,1);
                ds_list_add(list_raw,0);
                maxpoints_static++;
                }
            
            new_point = 1;
            
            //travel
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
            var t_xp_now = xp_prev;
            var t_yp_now = yp_prev;
            
            for (k = 0; k < t_n; k++)
                {
                t_step_dist_x += t_trav_dist_x;
                t_step_dist_y += t_trav_dist_y;
                
                t_xp_now += t_step_dist_x;
                t_yp_now += t_step_dist_y;
                
                ds_list_add(list_raw,t_xp_now);
                ds_list_add(list_raw,t_yp_now);
                ds_list_add(list_raw,1);
                ds_list_add(list_raw,0);
                maxpoints_static++;
                }
            for (k = 1; k < t_n; k++)
                {
                t_step_dist_x -= t_trav_dist_x;
                t_step_dist_y -= t_trav_dist_y;
                
                t_xp_now += t_step_dist_x;
                t_yp_now += t_step_dist_y;
                
                ds_list_add(list_raw,t_xp_now);
                ds_list_add(list_raw,t_yp_now);
                ds_list_add(list_raw,1);
                ds_list_add(list_raw,0);
                maxpoints_static++;
                }
            }
        }
    else
        {
        ds_list_add(list_raw,xp);
        ds_list_add(list_raw,yp);
        ds_list_add(list_raw,1);
        ds_list_add(list_raw,0);
        }
    }

ds_list_destroy(order_list);
ds_list_destroy(polarity_list);

return 1;
