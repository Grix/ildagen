function merge_elements() {
	temp_undof_list = ds_list_create_pool();

	for (i = scope_start; i <= scope_end; i++)
	{
		el_list = frame_list[| i];
		
		var t_selected_el_list = ds_list_create();
		
		for (j = 0; j < ds_list_size(el_list); j++)
		{
			var t_element = el_list[| j];
			if (ds_list_find_index(semaster_list, t_element[| 9]) != -1)
			{
				ds_list_add(t_selected_el_list, t_element);
			}
		}
		if (ds_list_empty(t_selected_el_list))
		{
			ds_list_free_pool(t_selected_el_list);
			continue;
		}
			
		order_list = ds_list_create_pool();
		polarity_list = ds_list_create_pool();

		new_list = ds_list_create_pool();
		repeat(9)
			ds_list_add(new_list, 0);
		ds_list_add(new_list, el_id); 
		repeat(10)
			ds_list_add(new_list, 0);
		
		find_element_order(t_selected_el_list);
		
		ymax = 0;
		xmax = 0;
		ymin = $ffff;
		xmin = $ffff;
		
		var t_x_prev = -10000;
		var t_y_prev = -10000;
		var t_first = true;
	
		for (j = 0; j < ds_list_size(order_list); j++)
		{
			var t_element = t_selected_el_list[| (order_list[| j])];
			
			xo = t_element[| 0];
			yo = t_element[| 1];
		
			xmin = min(xo+t_element[| 4], xmin);
			xmax = max(xo+t_element[| 5], xmax);
			ymin = min(yo+t_element[| 6], ymin);
			ymax = max(yo+t_element[| 7], ymax);
			
			var t_startpos = 20;
			var t_posincrement = 4;
			var t_endpos = ds_list_size(t_element);
			
			if (polarity_list[| j] == 1)
			{
				t_startpos = ds_list_size(t_element) - 4;
				t_posincrement = -4;
				t_endpos = 20;
			}
			
			for (k = t_startpos; (t_endpos == 20) ? (k >= t_endpos) : (k < t_endpos); k += t_posincrement)
			{
				var t_x = xo + t_element[| k];
				var t_y = yo + t_element[| k+1];
				if (!t_first && k == t_startpos)
				{
					if ((abs(t_x - t_x_prev) > 280 || abs(t_y - t_y_prev) > 280))
					{
						ds_list_add(new_list, t_x);
						ds_list_add(new_list, t_y);
						ds_list_add(new_list, 1);
						ds_list_add(new_list, c_black);
						
						ds_list_add(new_list, t_x);
						ds_list_add(new_list, t_y);
						ds_list_add(new_list, t_element[| k+2]);
						ds_list_add(new_list, t_element[| k+3]);
					}
				}
				else
				{
					ds_list_add(new_list, t_x);
					ds_list_add(new_list, t_y);
					ds_list_add(new_list, t_element[| k+2]);
					ds_list_add(new_list, t_element[| k+3]);
				}
				/*if (k == ds_list_size(t_element) - 4)
				{
					ds_list_add(new_list, xo + t_element[| k]);
					ds_list_add(new_list, yo + t_element[| k+1]);
					ds_list_add(new_list, 1);
					ds_list_add(new_list, c_black);
				}*/
				t_x_prev = t_x;
				t_y_prev = t_y;
			}
			ds_list_add(t_element, i);
			ds_list_add(temp_undof_list, t_element);
			
			for (var t_k = 0; t_k < ds_list_size(el_list); t_k++)
			{
				if (el_list[| t_k][| 9] == t_element[| 9])
				{
					ds_list_delete(el_list, t_k);
					break;
				}
			}
			
			t_first = false;
		}
	
		new_list[| 4] = xmin;
		new_list[| 5] = xmax;
		new_list[| 6] = ymin;
		new_list[| 7] = ymax;
		ds_list_add(el_list, new_list);
		
		ds_list_free_pool(order_list); order_list = -1;
		ds_list_free_pool(polarity_list); polarity_list =-1;
		ds_list_free_pool(t_selected_el_list);
	}

	add_action_history_ilda("ILDA_merge");

	ds_list_add(undo_list,"l"+string(temp_undof_list));

	ds_list_clear(semaster_list);
	ds_list_add(semaster_list, el_id);
	ds_list_add(undo_list,el_id);
	el_id++;

	el_list = frame_list[| frame];


}
