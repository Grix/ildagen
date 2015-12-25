list_id = ds_list_find_value(el_list,i);

list_points = ds_list_create();
list_raw = ds_list_create();

order_list = ds_list_create();
polarity_list = ds_list_create();

//start from middle
xp_prev = $8000;
yp_prev = $8000;
bl_prev = 1;

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

//parse elements
for (i = 0;i < ds_list_size(el_list);i++)
    {
    if (controller.exp_optimize == 1)
        list_id = ds_list_find_value(el_list,order_list[| i]);
    else list_id = ds_list_find_value(el_list,i); 
    
    xo = ds_list_find_value(list_id,0);
    yo = ds_list_find_value(list_id,1);
    
    //point loop ascending or descending:
    if (polarity_list[| i] == 0)
        pass_list_pol_asc();
    else
        pass_list_pol_desc();
        
    if (controller.exp_optimize)
        {
        if (bl_prev == 0)
            {
            repeat (controller.opt_maxdwell)
                {
                //dwell on blanking start
                ds_list_add(list_raw,xp);
                ds_list_add(list_raw,yp);
                ds_list_add(list_raw,1);
                ds_list_add(list_raw,0);
                maxpoints_static++;
                }
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
    //interpolate blanking
    opt_dist = point_distance(xp_prev,yp_prev,xp,yp);
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
    repeat (controller.opt_maxdwell)
        {
        //dwell on blanking start
        ds_list_add(list_raw,xp);
        ds_list_add(list_raw,yp);
        ds_list_add(list_raw,1);
        ds_list_add(list_raw,0);
        maxpoints_static++;
        }
    }
    
ds_list_destroy(order_list);
ds_list_destroy(polarity_list);

return 1;
