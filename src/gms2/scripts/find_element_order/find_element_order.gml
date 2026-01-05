// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function find_element_order(){
	// input: local variable el_list with elements
	// output: local variables order_list and polarity_list with indexes of el_list
	
	
	// find superelements (groups of connected elements)
	var t_superelements_order = ds_list_create();
	var t_superelements_polarity = ds_list_create();
	var t_element_found = array_create(ds_list_size(el_list), false);
	
	var t_i;
	for (t_i = 0; t_i < ds_list_size(el_list); t_i++)
	{
		if (t_element_found[t_i])
	        continue;
			
		list_id = el_list[| t_i];
			
		if (ds_list_size(list_id) <= 22)
		{
			t_element_found[t_i] = true; // empty, ignore
			continue;
		}
		
		xo = list_id[| 0];
	    yo = list_id[| 1];
		var t_prev_xp = xo+list_id[| 20];
	    var t_prev_yp = yo+list_id[| 21];
		
		var t_superelement_order = ds_list_create();
		var t_superelement_polarity = ds_list_create();
		ds_list_add(t_superelement_order, t_i);
		ds_list_add(t_superelement_polarity, 0);

		// find chain of connected elements to start
		var t_j;
		var t_end = false;
		while (!t_end)
		{
			t_end = true;
			for (t_j = 0; t_j < ds_list_size(el_list); t_j++)
			{
				if (t_element_found[t_j])
					continue;
				
				var t_next_list_id = el_list[| t_j];
				
				if (ds_list_size(t_next_list_id) <= 22)
				{
					t_element_found[t_j] = true; // empty, ignore
					continue;
				}
				
				var t_next_xo = t_next_list_id[| 0];
				var t_next_yo = t_next_list_id[| 1];
				var t_next_xp_start = t_next_xo+t_next_list_id[| 20];
				var t_next_yp_start = t_next_yo+t_next_list_id[| 21];
			
				if (point_distance(t_prev_xp, t_prev_yp, t_next_xp_start, t_next_yp_start) < 280)
				{
					ds_list_insert(t_superelement_order, 0, t_j);
					ds_list_insert(t_superelement_polarity, 0, 1);
					t_element_found[t_j] = true;
					t_prev_xp = t_next_xo+t_next_list_id[| ds_list_size(t_next_list_id)-4+0];
					t_prev_yp = t_next_yo+t_next_list_id[| ds_list_size(t_next_list_id)-4+1];
					t_end = false;
					break;
				}
			
				var t_next_xp_end = t_next_xo+t_next_list_id[| ds_list_size(t_next_list_id)-4+0];
				var t_next_yp_end = t_next_yo+t_next_list_id[| ds_list_size(t_next_list_id)-4+1];
			
				if (point_distance(t_prev_xp, t_prev_yp, t_next_xp_end, t_next_yp_end) < 280)
				{
					ds_list_insert(t_superelement_order, 0, t_next_list_id);
					ds_list_insert(t_superelement_polarity, 0, 0);
					t_element_found[t_j] = true;
					t_prev_xp = t_next_xp_start;
					t_prev_yp = t_next_yp_start;
					t_end = false;
					return;
				}
			}
		}
	
	    t_prev_xp = xo+list_id[| ds_list_size(list_id)-4+0];
	    t_prev_yp = yo+list_id[| ds_list_size(list_id)-4+1];
		
		// find chain of connected elements to end
		t_end = false;
		while (!t_end)
		{
			t_end = true;
			for (t_j = 0; t_j < ds_list_size(el_list); t_j++)
			{
				if (t_element_found[t_j])
					continue;
				
				var t_next_list_id = el_list[| t_j];
				
				if (ds_list_size(t_next_list_id) <= 22)
				{
					t_element_found[t_j] = true; // empty, ignore
					continue;
				}
				
				var t_next_xo = t_next_list_id[| 0];
				var t_next_yo = t_next_list_id[| 1];
				var t_next_xp_start = t_next_xo+t_next_list_id[| 20];
				var t_next_yp_start = t_next_yo+t_next_list_id[| 21];
			
				if (point_distance(t_prev_xp, t_prev_yp, t_next_xp_start, t_next_yp_start) < 280)
				{
					ds_list_add(t_superelement_order, t_j);
					ds_list_add(t_superelement_polarity, 0);
					t_element_found[t_j] = true;
					t_prev_xp = t_next_xo+t_next_list_id[| ds_list_size(t_next_list_id)-4+0];
					t_prev_yp = t_next_yo+t_next_list_id[| ds_list_size(t_next_list_id)-4+1];
					t_end = false;
					break;
				}
			
				var t_next_xp_end = t_next_xo+t_next_list_id[| ds_list_size(t_next_list_id)-4+0];
				var t_next_yp_end = t_next_yo+t_next_list_id[| ds_list_size(t_next_list_id)-4+1];
			
				if (point_distance(t_prev_xp, t_prev_yp, t_next_xp_end, t_next_yp_end) < 280)
				{
					ds_list_add(t_superelement_order, t_next_list_id);
					ds_list_add(t_superelement_polarity, 1);
					t_element_found[t_j] = true;
					t_prev_xp = t_next_xp_start;
					t_prev_yp = t_next_yp_start;
					t_end = false;
					return;
				}
			}
		}
		
		ds_list_add(t_superelements_order, t_superelement_order);
		ds_list_add(t_superelements_polarity, t_superelement_polarity);
	}
	
	
}
