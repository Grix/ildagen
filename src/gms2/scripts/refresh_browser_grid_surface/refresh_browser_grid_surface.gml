function refresh_browser_grid_surface() {
	if (!surface_exists(browser_surf))
	{
	    browser_surf = surface_create(clamp(power(2, ceil(log2(camera_get_view_width(view_get_camera(1))))), 1, 8192), clamp(power(2, ceil(log2(ypos_perm+camera_get_view_height(view_get_camera(1))))), 1, 8192));
	}
	else
		exit; // Don't need to refresh

	surface_set_target(browser_surf);

		draw_set_alpha(1);
		draw_clear_alpha(c_white, 0);

		var t_width = max(1, camera_get_view_width(view_camera[1])-scrollbarwidth);
		var t_height = max(1, surface_get_height(browser_surf));
		var t_cells_per_row = ceil(t_width / (target_width_per_cell));
		var t_cells_per_column = ceil(t_height / (target_width_per_cell));
		var t_cell_size = t_width / t_cells_per_row;

		var t_row;
		var t_column;
	
		draw_set_color(c_ltgray);
		for (i=1; i <= t_cells_per_row; i++)
		{
		    draw_line(t_cell_size*i, 0, t_cell_size*i, t_height);
		}
		for (i=1; i <= t_cells_per_column; i++)
		{
		    draw_line(0, t_cell_size*i, t_width, t_cell_size*i);
		}

		for (i = 0; i < ds_list_size(filelist); i++)
		{
			objectlist = filelist[| i];
		
			t_column = i mod t_cells_per_row;
			t_row = i div t_cells_per_row;
		
			var t_infolist = objectlist[| 2];
	
			if (!surface_exists(t_infolist[| 1]))
				t_infolist[| 1] = make_screenshot(objectlist[| 1], t_cell_size-1);
			draw_surface_part(t_infolist[| 1],0,0,t_cell_size-1,t_cell_size-1, t_column*t_cell_size+1, t_row*t_cell_size+1);
		
		}

	surface_reset_target();

	draw_set_alpha(1);
	draw_set_color(c_white);


}
