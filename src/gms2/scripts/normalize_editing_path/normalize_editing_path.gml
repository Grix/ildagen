
function normalize_editing_path(t_list){
	// normalize the pace of the recorded editing path
	var t_total_translation = 0;
	var t_total_scale = 0;
	var t_total_rotation = 0;
	
	if (ds_list_exists(t_list) && !ds_list_empty(t_list))
	{
		var t_newlist = ds_list_create();
		
		for (var t_i = 5; t_i < ds_list_size(t_list)-4; t_i += 5)
		{
			t_total_translation += point_distance(t_list[| t_i+0], t_list[| t_i+1], t_list[| t_i-5+0], t_list[| t_i-5+1]);
			t_total_scale += point_distance(t_list[| t_i+2], t_list[| t_i+3], t_list[| t_i-5+2], t_list[| t_i-5+3]);
			t_total_rotation += abs(t_list[| t_i+4] - t_list[| t_i-5+4]);
		}
		
		var t_translation = 0;
		var t_scale = 0;
		var t_rotation = 0;
		
		ds_list_add(t_newlist, t_list[| 0]);
		ds_list_add(t_newlist, t_list[| 1]);
		ds_list_add(t_newlist, t_list[| 2]);
		ds_list_add(t_newlist, t_list[| 3]);
		ds_list_add(t_newlist, t_list[| 4]);
		
		var t_x = t_list[| 0];
		var t_y = t_list[| 1];
		var t_scalex = t_list[| 2];
		var t_scaley = t_list[| 3];
		var t_rot = t_list[| 4];
		
		for (var t_i = 5; t_i < ds_list_size(t_list)-9; t_i += 5)
		{
			var t_temp_translation = 0;
			var t_temp_scale = 0;
			var t_temp_rotation = 0;
			if (t_total_translation != 0)
			{
				for (var t_j = 5; t_j < ds_list_size(t_list)-4; t_j += 5)
				{
					var t_point_distance = point_distance(t_list[| t_j+0], t_list[| t_j+1], t_list[| t_j-5+0], t_list[| t_j-5+1]);
					t_temp_translation += t_point_distance;
					if (t_temp_translation > t_translation)
					{
						t_x = lerp(t_list[| t_j+0], t_list[| t_j-5+0], (t_temp_translation-t_translation)/t_point_distance);
						t_y = lerp(t_list[| t_j+1], t_list[| t_j-5+1], (t_temp_translation-t_translation)/t_point_distance);
						break;
					}
				} 
			}
			ds_list_add(t_newlist, t_x);
			ds_list_add(t_newlist, t_y);
			
			if (t_total_scale != 0)
			{
				for (var t_j = 5; t_j < ds_list_size(t_list)-4; t_j += 5)
				{
					var t_point_distance = point_distance(t_list[| t_j+2], t_list[| t_j+3], t_list[| t_j-5+2], t_list[| t_j-5+3]);
					t_temp_scale += t_point_distance;
					if (t_temp_scale > t_scale)
					{
						t_scalex = lerp(t_list[| t_j+2], t_list[| t_j-5+2], (t_temp_scale-t_scale)/t_point_distance);
						t_scaley = lerp(t_list[| t_j+3], t_list[| t_j-5+3], (t_temp_scale-t_scale)/t_point_distance);
						break;
					}
				} 
			}
			ds_list_add(t_newlist, t_scalex);
			ds_list_add(t_newlist, t_scaley);
			
			if (t_total_rotation != 0)
			{
				for (var t_j = 5; t_j < ds_list_size(t_list)-4; t_j += 5)
				{
					var t_point_distance = t_list[| t_j+4] - t_list[| t_j-5+4];
					t_temp_rotation += t_point_distance;
					if (t_temp_rotation > t_rotation)
					{
						t_rot = lerp(t_list[| t_j+4], t_list[| t_j-5+4], (t_temp_rotation-t_rotation)/t_point_distance);
						break;
					}
				} 
			}
			ds_list_add(t_newlist, t_rot);
			
			t_translation += t_total_translation/(ds_list_size(t_list)/5 - 2);
			t_scale += t_total_scale/(ds_list_size(t_list)/5 - 2);
			t_rotation += t_total_rotation/(ds_list_size(t_list)/5 - 2);
		}
		
		ds_list_add(t_newlist, t_list[| ds_list_size(t_list)-5]);
		ds_list_add(t_newlist, t_list[| ds_list_size(t_list)-4]);
		ds_list_add(t_newlist, t_list[| ds_list_size(t_list)-3]);
		ds_list_add(t_newlist, t_list[| ds_list_size(t_list)-2]);
		ds_list_add(t_newlist, t_list[| ds_list_size(t_list)-1]);
		
		return t_newlist;
	}
	else
		return ds_list_create();
}