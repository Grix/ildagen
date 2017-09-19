if (debug_mode)
    log("prepare_output");

list_raw = ds_list_create();

order_list = ds_list_create();
polarity_list = ds_list_create();

lit_length = 0;
maxpoints_static = 0;
maxpoints_dots = 0;
smallestdotsize = 100000;
currentdotsize = 0;
num_dots = 0;

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
        
    prepare_output_points();
    
    maxpoints_static++;
       
    bl_prev = 1;
}

if (xp_prev != mid_x) and (yp_prev != mid_y)
{
    //back to middle
    xp = mid_x;
    yp = mid_y;
    
    //BLANKING
    opt_dist = point_distance(xp_prev,yp_prev,xp,yp);
    
    if (opt_dist < 250) //connecting segments
    {
        var t_true_dwell = controller.opt_maxdwell;
        maxpoints_static += (   (controller.opt_maxdwell_blank)
                                +  abs(t_true_dwell - controller.opt_maxdwell_blank) );
    }
    else
    {
        if ((xp_prev_prev == xp_prev) && (yp_prev_prev == yp_prev))
        {
            t_true_dwell_rising = round(controller.opt_maxdwell*0.2);
        }
        else
        {
            angle_blank = point_direction(xp,yp, xp_prev,yp_prev);
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
             
        maxpoints_static += (   (controller.opt_maxdwell_blank) 
                                +  max(controller.opt_maxdwell_blank, t_true_dwell_rising - controller.opt_maxdwell_blank)
                                +  (t_n + t_n) 
                                + 1);
    }
}

ds_list_destroy(t_list_empties);

return 1;
