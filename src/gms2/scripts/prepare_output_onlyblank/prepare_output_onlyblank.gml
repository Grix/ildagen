if (debug_mode)
    log("prepare_output_ob");

list_raw = ds_list_create();

order_list = ds_list_create();
polarity_list = ds_list_create();

maxpoints_static = 0;

x_lowerbound = controller.x_scale_start;
y_lowerbound = $FFFF-controller.y_scale_end;
x_scale = controller.x_scale_end/$FFFF*($FFFF-x_lowerbound)/$FFFF;
y_scale = ($FFFF-controller.y_scale_start)/$FFFF*($FFFF-y_lowerbound)/$FFFF;
mid_x = x_lowerbound+$8000*x_scale;
mid_y = y_lowerbound+$8000*y_scale;

xp_prev = mid_x;
yp_prev = mid_y;
xp_prev_prev = mid_x;
yp_prev_prev = mid_y;
bl_prev = 1;
c_prev = 0;
new_dot = 1;

a_ballistic = controller.opt_maxdist; //scanner acceleration

t_pol = 0;
t_order = 0;
var t_lowestdist, t_dist, t_tempxp_prev_other, t_tempyp_prev_other, t_tempxp_prev, t_tempyp_prev;
var t_found = 0;
var t_list_empties = ds_list_create();

//checking best element order
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
        
        xo = list_id[| 0];
        yo = list_id[| 1];
        t_found = 0;
        
        xp = xo+list_id[| 20];
        yp = yo+list_id[| 21];
        
        t_dist = point_distance(xp_prev,yp_prev,xp,yp);
        if (t_dist < t_lowestdist)
        {
            t_order = i;
            t_pol = 0;
            if (t_dist < 250)
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
                if (t_dist < 250)
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
    ds_list_destroy(order_list);
    ds_list_destroy(polarity_list);
    ds_list_destroy(t_list_empties);
    ds_list_destroy(list_raw);
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
        
    if (!prepare_output_points_onlyblank())
    {
        ds_list_destroy(order_list);
        ds_list_destroy(polarity_list);
        ds_list_destroy(t_list_empties);
        ds_list_destroy(list_raw);
        return 0;
    }
       
    bl_prev = 1;
}

ds_list_destroy(t_list_empties);

return 1;

