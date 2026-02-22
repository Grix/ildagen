// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function find_element_order(t_original_list){
	// input: t_original_list with elements
	// output: local variables order_list and polarity_list with indexes of t_original_list (lists must be created first!)
	
	// find superelements (groups of connected elements)
	var t_superelements_order_lists = ds_list_create_pool();
	var t_superelements_polarity_lists = ds_list_create_pool();
	var t_element_found = array_create(ds_list_size(t_original_list), false);
	
	var t_i;
	for (t_i = 0; t_i < ds_list_size(t_original_list); t_i++)
	{
		if (t_element_found[t_i])
	        continue;
			
		list_id = t_original_list[| t_i];
			
		if (ds_list_size(list_id) <= 22)
		{
			t_element_found[t_i] = true; // empty, ignore
			continue;
		}
		
		xo = list_id[| 0];
	    yo = list_id[| 1];
		var t_prev_xp = xo+list_id[| 20];
	    var t_prev_yp = yo+list_id[| 21];
		
		var t_superelement_order_list = ds_list_create_pool();
		var t_superelement_polarity_list = ds_list_create_pool();
		ds_list_add(t_superelement_order_list, t_i);
		ds_list_add(t_superelement_polarity_list, 0);
		t_element_found[t_i] = true;

		// find chain of connected elements to start
		var t_j;
		var t_end = false;
		while (!t_end)
		{
			t_end = true;
			for (t_j = 0; t_j < ds_list_size(t_original_list); t_j++)
			{
				if (t_element_found[t_j])
					continue;
				
				var t_next_list_id = t_original_list[| t_j];
				
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
					ds_list_insert(t_superelement_order_list, 0, t_j);
					ds_list_insert(t_superelement_polarity_list, 0, 1);
					t_element_found[t_j] = true;
					t_prev_xp = t_next_xo+t_next_list_id[| ds_list_size(t_next_list_id)-4+0];
					t_prev_yp = t_next_yo+t_next_list_id[| ds_list_size(t_next_list_id)-4+1];
					t_end = false;
					break;
				}
			
				if (!t_next_list_id[| 11])
				{
					var t_next_xp_end = t_next_xo+t_next_list_id[| ds_list_size(t_next_list_id)-4+0];
					var t_next_yp_end = t_next_yo+t_next_list_id[| ds_list_size(t_next_list_id)-4+1];
			
					if (point_distance(t_prev_xp, t_prev_yp, t_next_xp_end, t_next_yp_end) < 280)
					{
						ds_list_insert(t_superelement_order_list, 0, t_j);
						ds_list_insert(t_superelement_polarity_list, 0, 0);
						t_element_found[t_j] = true;
						t_prev_xp = t_next_xp_start;
						t_prev_yp = t_next_yp_start;
						t_end = false;
						break;
					}
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
			for (t_j = 0; t_j < ds_list_size(t_original_list); t_j++)
			{
				if (t_element_found[t_j])
					continue;
				
				var t_next_list_id = t_original_list[| t_j];
				
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
					ds_list_add(t_superelement_order_list, t_j);
					ds_list_add(t_superelement_polarity_list, 0);
					t_element_found[t_j] = true;
					t_prev_xp = t_next_xo+t_next_list_id[| ds_list_size(t_next_list_id)-4+0];
					t_prev_yp = t_next_yo+t_next_list_id[| ds_list_size(t_next_list_id)-4+1];
					t_end = false;
					break;
				}
			
				if (!t_next_list_id[| 11])
				{
					var t_next_xp_end = t_next_xo+t_next_list_id[| ds_list_size(t_next_list_id)-4+0];
					var t_next_yp_end = t_next_yo+t_next_list_id[| ds_list_size(t_next_list_id)-4+1];
			
					if (point_distance(t_prev_xp, t_prev_yp, t_next_xp_end, t_next_yp_end) < 280)
					{
						ds_list_add(t_superelement_order_list, t_j);
						ds_list_add(t_superelement_polarity_list, 1);
						t_element_found[t_j] = true;
						t_prev_xp = t_next_xp_start;
						t_prev_yp = t_next_yp_start;
						t_end = false;
						break;
					}
				}
			}
		}
		
		ds_list_add(t_superelements_order_lists, t_superelement_order_list);
		ds_list_add(t_superelements_polarity_lists, t_superelement_polarity_list);
	}
	
	//finding best superelement order
	
	var t_pol = 0;
	var t_order = 0;
	var t_lowestdist, t_dist;
	var t_remaining = ds_list_size(t_superelements_order_lists);
	var t_firstelement = true;

	while (t_remaining > 0)
	{
		if (t_firstelement)
		{
			t_order = 0;
			t_pol = 0;
		}
		else
		{
		    t_lowestdist = $fffff;
			// find next closest superelement
			// todo take angle dwell into account
		    for (t_i = 0; t_i < ds_list_size(t_superelements_order_lists); t_i++)
		    {
				var t_superelement_order_list = t_superelements_order_lists[| t_i];
			
				if (t_superelement_order_list < 0)
					continue;
				
				var t_superelement_polarity_list = t_superelements_polarity_lists[| t_i];
			
				// checking distance to start point of superelement
		        var t_start_list_id = t_original_list[| (t_superelement_order_list[| 0])];
        
		        xo = t_start_list_id[| 0];
		        yo = t_start_list_id[| 1];
			
				if (t_superelement_polarity_list[| 0] == 0)
				{
			        xp = xo+t_start_list_id[| 20];
			        yp = yo+t_start_list_id[| 21];
				}
				else
				{
					currentpos = ds_list_size(t_start_list_id)-4;
			        xp = xo+t_start_list_id[| currentpos+0];
		            yp = yo+t_start_list_id[| currentpos+1];
				}
			
				t_dist = point_distance(xp_prev,yp_prev,xp,yp);
				if (t_dist < t_lowestdist || t_lowestdist == $fffff)
				{
				    t_order = t_i;
				    t_pol = 0;
				    t_lowestdist = t_dist;
				}
			
				// checking distance to end point of superelement
		        var t_end_list_id = t_original_list[| (t_superelement_order_list[| ds_list_size(t_superelement_order_list)-1])];
        
		        xo = t_end_list_id[| 0];
		        yo = t_end_list_id[| 1];
			
				if (t_superelement_polarity_list[| ds_list_size(t_superelement_polarity_list)-1] != 0)
				{
			        xp = xo+t_end_list_id[| 20];
			        yp = yo+t_end_list_id[| 21];
				}
				else
				{
					currentpos = ds_list_size(t_end_list_id)-4;
			        xp = xo+t_end_list_id[| currentpos+0];
		            yp = yo+t_end_list_id[| currentpos+1];
				}
        
				t_dist = point_distance(xp_prev,yp_prev,xp,yp);
				if (t_dist < (t_lowestdist-10))
				{
				    t_order = t_i;
				    t_pol = 1;
				    t_lowestdist = t_dist;
				}
		    }
		}
		
		// add the found nearest superelement to the order list
		var t_superelement_order_list = t_superelements_order_lists[| t_order];
		var t_superelement_polarity_list = t_superelements_polarity_lists[| t_order];
		var t_superelement_size = ds_list_size(t_superelement_order_list);
		
		for (t_i = 0; t_i < t_superelement_size; t_i++)
		{
			var t_index;
			if (t_pol == 1)
				t_index = t_superelement_size - 1 - t_i;
			else
				t_index = t_i;
				
			ds_list_add(order_list, t_superelement_order_list[| t_index]);
			ds_list_add(polarity_list, t_pol xor t_superelement_polarity_list[| t_index]);
			
			if (t_i == t_superelement_size - 1)
			{
				var t_list_id = t_original_list[| t_superelement_order_list[| t_index]];
				if (t_pol xor t_superelement_polarity_list[| t_index])
			        currentpos = ds_list_size(t_list_id)-4;
			    else
			        currentpos = 20;
				xp_prev = t_list_id[| 0]+t_list_id[| currentpos+0];
			    yp_prev = t_list_id[| 1]+t_list_id[| currentpos+1];
			}
		}
		
		ds_list_destroy(t_superelement_order_list);
		ds_list_destroy(t_superelement_polarity_list);
		t_superelements_order_lists[| t_order] = -1;
		t_firstelement = false;
		t_remaining -= 1;
		
	}
	
	ds_list_destroy(t_superelements_order_lists);
	ds_list_destroy(t_superelements_polarity_lists);
	
	
}
