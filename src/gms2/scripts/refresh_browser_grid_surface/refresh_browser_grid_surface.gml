if (!surface_exists(browser_surf))
{
    browser_surf = surface_create(power(2, ceil(log2(view_wport[1]+512))), power(2, ceil(log2(view_hport[1]))));
}

surface_set_target(browser_surf);

	draw_clear_alpha(c_white, 0);

	var t_width = view_wport[1];
	var t_cells_per_row = ceil(target_width_per_cell / t_width);
	var t_cell_size = t_width / t_cells_per_row;

	var t_row = 0;
	var t_column = 0;

	for (i = 0; i < ds_list_size(filelist); i++)
	{
		var t_infolist = filelist[| i];
		var t_duration = t_infolist[| 0];
	
		if (!surface_exists(t_infolist[| 1]))
			t_infolist[| 1] = make_screenshot(objectlist[| 1], t_cell_size);
		draw_surface_part(t_infolist[| 1],0,0,t_cell_size,t_cell_size, t_column*t_cell_size, t_row*t_cell_size);
	}

surface_reset_target();