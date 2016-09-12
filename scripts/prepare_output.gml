list_raw = ds_list_create();

order_list = ds_list_create();
polarity_list = ds_list_create();

//start from middle
xp_prev = $8000;
yp_prev = $8000;
bl_prev = 1;
c_prev = 0;
new_dot = 1;

lit_length = 0;
maxpoints_static = 0;
maxpoints_dots = 0;
smallestdotsize = 0;
currentdotsize = 0;
num_dots = 0;

a_ballistic = controller.opt_maxdist; //ballistic scanner acceleration

t_pol = 0;
t_order = 0;
var t_lowestdist, t_dist, t_tempxp_prev_other, t_tempyp_prev_other, t_tempxp_prev, t_tempyp_prev;
var t_found = 0;
var t_list_empties = ds_list_create();

//checking best element order
if (controller.exp_optimize)
{
    while (ds_list_size(order_list) < (ds_list_size(el_list)-ds_list_size(t_list_empties)))
    {
        t_lowestdist = $fffff;
        for (i = 0;i < ds_list_size(el_list);i++)
        {
            if (ds_list_find_index(order_list,i) != -1)
                continue;
                
            list_id = ds_list_find_value(el_list,i);
            
            if (ds_list_find_index(t_list_empties, list_id) != -1)
                continue;
            
            xo = ds_list_find_value(list_id,0);
            yo = ds_list_find_value(list_id,1);
            t_found = 0;
            
            currentpos = 20;
            while (ds_list_find_value(list_id,currentpos+2))
                currentpos += 4;
                
            if (is_undefined(list_id[| currentpos]))
            {
                ds_list_add(t_list_empties, list_id);
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
        if ((ds_list_size(el_list)-ds_list_size(t_list_empties)) > 0)
        {
            xp_prev = t_tempxp_prev;
            yp_prev = t_tempyp_prev;
            ds_list_add(order_list,t_order);
            ds_list_add(polarity_list,t_pol);
        }
    }
}

if ((ds_list_size(el_list)-ds_list_size(t_list_empties)) <= 0)
{
    ds_list_destroy(order_list);
    ds_list_destroy(polarity_list);
    ds_list_destroy(t_list_empties);
    return 0;
}
        
xp_prev = $8000;
yp_prev = $8000;

//parse elements
if (controller.exp_optimize)
    var t_numofelems = ds_list_size(order_list);
else 
    var t_numofelems = ds_list_size(el_list);
    
for (i = 0; i < t_numofelems; i++)
{
    if (controller.exp_optimize)
        list_id = ds_list_find_value(el_list,order_list[| i]);
    else 
        list_id = ds_list_find_value(el_list,i); 
        
    if (is_undefined(list_id))
        continue;

    xo = ds_list_find_value(list_id,0);
    yo = ds_list_find_value(list_id,1);
       
    prepare_output_points();
        
    if (controller.exp_optimize)
    {
        if (bl_prev == 0)
        {
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
        var t_true_dwell = controller.opt_maxdwell; //todo calculate from angles
        
        if (opt_dist < 200) //connecting segments
        {
            maxpoints_static += (   (controller.opt_maxdwell_blank)
                                    +  abs(t_true_dwell - controller.opt_maxdwell_blank) );
        }
        else
        {
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
                 
            maxpoints_static += (   (controller.opt_maxdwell_blank) 
                                    +  max(controller.opt_maxdwell_blank, t_true_dwell - controller.opt_maxdwell_blank)
                                    +  (t_n + t_n) );
        }
    }
}

ds_list_destroy(t_list_empties);

return 1;
