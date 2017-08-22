if (debug_mode)
    log("prepare_output_unopt");

list_raw = ds_list_create();

maxpoints_static = 0;

order_list = ds_list_create();
polarity_list = ds_list_create();

x_lowerbound = controller.x_scale_start;
y_lowerbound = $FFFF-controller.y_scale_end;
x_scale = controller.x_scale_end/$FFFF*($FFFF-x_lowerbound)/$FFFF;
y_scale = ($FFFF-controller.y_scale_start)/$FFFF*($FFFF-y_lowerbound)/$FFFF;
mid_x = x_lowerbound+$8000*x_scale;
mid_y = y_lowerbound+$8000*y_scale;

c_prev = 0;
new_dot = 1;

t_pol = 0;
t_order = 0;
var t_lowestdist, t_dist, t_tempxp_prev_other, t_tempyp_prev_other, t_tempxp_prev, t_tempyp_prev;
var t_found = 0;
var t_list_empties = ds_list_create();

if ((ds_list_size(el_list)-ds_list_size(t_list_empties)) <= 0)
{
    ds_list_destroy(order_list);
    ds_list_destroy(polarity_list);
    ds_list_destroy(t_list_empties);
    ds_list_destroy(list_raw);
    return 0;
}

//parse elements
var t_numofelems = ds_list_size(el_list);
    
for (i = 0; i < t_numofelems; i++)
{
    list_id = ds_list_find_value(el_list,i); 
        
    if (is_undefined(list_id))
        continue;

    xo = ds_list_find_value(list_id,0);
    yo = ds_list_find_value(list_id,1);
        
    if (!prepare_output_points_unopt())
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

