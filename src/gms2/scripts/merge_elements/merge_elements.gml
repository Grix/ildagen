function merge_elements() {
	temp_undof_list = ds_list_create_pool();

	for (i = scope_start; i <= scope_end; i++)
	{
		el_list = frame_list[| i];
		var t_found = false;
		for (j = 0; j < ds_list_size(el_list); j++)
		{
			var t_element = el_list[| j];
			if (ds_list_find_index(semaster_list, t_element[| 9]) != -1)
				t_found = true;
		}
		if (!t_found)
			continue;

		new_list = ds_list_create_pool();
		repeat(9)
			ds_list_add(new_list, 0);
		ds_list_add(new_list, el_id); 
		repeat(10)
			ds_list_add(new_list, 0);
		
		ymax = 0;
		xmax = 0;
		ymin = $ffff;
		xmin = $ffff;
	
		for (j = 0; j < ds_list_size(el_list); j++)
		{
			var t_element = el_list[| j];
			if (ds_list_find_index(semaster_list, t_element[| 9]) == -1)
				continue;
			
			xo = t_element[| 0];
			yo = t_element[| 1];
		
			xmin = min(xo+t_element[| 4], xmin);
			xmax = max(xo+t_element[| 5], xmax);
			ymin = min(yo+t_element[| 6], ymin);
			ymax = max(yo+t_element[| 7], ymax);
			
			for (k = 20; k < ds_list_size(t_element); k += 4)
			{
				if (k == 20)
				{
					ds_list_add(new_list, xo + t_element[| k]);
					ds_list_add(new_list, yo + t_element[| k+1]);
					ds_list_add(new_list, 1);
					ds_list_add(new_list, c_black);
				}
				ds_list_add(new_list, xo + t_element[| k]);
				ds_list_add(new_list, yo + t_element[| k+1]);
				ds_list_add(new_list, t_element[| k+2]);
				ds_list_add(new_list, t_element[| k+3]);
				if (k == ds_list_size(t_element) - 4)
				{
					ds_list_add(new_list, xo + t_element[| k]);
					ds_list_add(new_list, yo + t_element[| k+1]);
					ds_list_add(new_list, 1);
					ds_list_add(new_list, c_black);
				}
			}
			ds_list_add(t_element, i);
			ds_list_add(temp_undof_list, t_element);
			ds_list_delete(el_list, j);
			j--;
		}
	
		new_list[| 4] = xmin;
		new_list[| 5] = xmax;
		new_list[| 6] = ymin;
		new_list[| 7] = ymax;
		ds_list_add(el_list, new_list);
	}

	ds_list_add(undo_list,"l"+string(temp_undof_list));

	ds_list_clear(semaster_list);
	ds_list_add(semaster_list, el_id);
	ds_list_add(undo_list,el_id);
	el_id++;

	el_list = frame_list[| frame];


}
