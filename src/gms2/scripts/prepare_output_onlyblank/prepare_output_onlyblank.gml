function prepare_output_onlyblank() {
	if (debug_mode)
	    log("prepare_output_ob");

	list_raw = ds_list_create_pool();

	order_list = ds_list_create_pool();
	polarity_list = ds_list_create_pool();

	maxpoints_static = 0;

	x_lowerbound_top = controller.scale_left_top;
	y_lowerbound_left = $FFFF-controller.scale_bottom_left;
	x_lowerbound_bottom = controller.scale_left_bottom;
	y_lowerbound_right = $FFFF-controller.scale_bottom_right;
	x_scale_top = (controller.scale_right_top-controller.scale_left_top)/$ffff;
	y_scale_left = (controller.scale_bottom_left-controller.scale_top_left)/$ffff;
	x_scale_bottom = (controller.scale_right_bottom-controller.scale_left_bottom)/$ffff;
	y_scale_right = (controller.scale_bottom_right-controller.scale_top_right)/$ffff;
	mid_x = x_lowerbound_top+(x_lowerbound_bottom-x_lowerbound_top)*($8000/$ffff)+$8000*(x_scale_top+(x_scale_bottom-x_scale_top)*($8000/$ffff));
	mid_y = y_lowerbound_left+(y_lowerbound_right-y_lowerbound_left)*($8000/$ffff)+$8000*(y_scale_left+(y_scale_right-y_scale_left)*($8000/$ffff));

	xp_prev = mid_x;
	yp_prev = mid_y;
	xp_prev_prev = mid_x;
	yp_prev_prev = mid_y;
	bl_prev = 1;
	c_prev = 0;
	new_dot = 1;

	a_ballistic = controller.opt_maxdist; //scanner acceleration

	//checking best element order
	find_element_order(el_list);

	if (ds_list_empty(order_list))
	{
	    ds_list_free_pool(order_list); order_list = -1;
		ds_list_free_pool(polarity_list); polarity_list =-1;
		ds_list_free_pool(list_raw); list_raw = -1;
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
	        ds_list_free_pool(order_list); order_list = -1;
			ds_list_free_pool(polarity_list); polarity_list =-1;
		    ds_list_free_pool(t_list_empties); t_list_empties = -1;
		    ds_list_free_pool(list_raw); list_raw = -1;
	        return 0;
	    }
       
	    bl_prev = 1;
	}

	return 1;




}
