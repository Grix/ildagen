if (!surface_exists(browser_surf))
{
    browser_surf = surface_create(power(2, ceil(log2(view_wport[1]+512))), power(2, ceil(log2(view_hport[1]))));
}
else
	exit; // Don't need to refresh

surface_set_target(browser_surf);

	draw_set_alpha(1);
	draw_clear_alpha(c_white, 0);

	var t_width = view_wport[1];
	var t_cells_per_row = ceil(t_width / target_width_per_cell);
	var t_cell_size = t_width / t_cells_per_row;

	var t_row;
	var t_column;
	
	//todo draw empty grid?

	for (i = 0; i < ds_list_size(filelist); i++)
	{
		objectlist = filelist[| i];
		
		t_column = i mod t_cells_per_row;
		t_row = i div t_cells_per_row;
		
		var t_infolist = objectlist[| 2];
	
		if (!surface_exists(t_infolist[| 1]))
			t_infolist[| 1] = make_screenshot(objectlist[| 1], t_cell_size-1);
		draw_surface_part(t_infolist[| 1],0,0,t_cell_size-1,t_cell_size-1, t_column*t_cell_size+1, t_row*t_cell_size+1);
		
		if (selectedfile == i)
		{
			draw_set_alpha(0.3);
			draw_set_color(controller.c_gold);
				draw_rectangle(t_column*t_cell_size+1, t_row*t_cell_size+1, t_column*t_cell_size-1+t_cell_size, t_row*t_cell_size-1+t_cell_size, 0);
			draw_set_alpha(1);
		}
		
		
		if (objectlist[| 3] == -1)
		{
			draw_set_color(controller.c_gold);
			draw_text(t_column*t_cell_size+3, t_row*t_cell_size+3, "Press key...");
		}
		else if (objectlist[| 3] > 0)
		{
			draw_set_color(c_white);
			draw_text(t_column*t_cell_size+3, t_row*t_cell_size+3, chr(objectlist[| 3]));
		}
		
		if (objectlist[| 4])
		{
			draw_set_color(c_white);
			draw_sprite(spr_loop, 0, t_column*t_cell_size+3, t_row*t_cell_size+32);
		}
		if (objectlist[| 5])
		{
			draw_set_color(c_white);
			draw_sprite(spr_exclusive, 0, t_column*t_cell_size+3, t_row*t_cell_size+48);
		}
		if (objectlist[| 6])
		{
			draw_set_color(c_white);
			draw_sprite(spr_resume, 0, t_column*t_cell_size+3, t_row*t_cell_size+64);
		}
	}

surface_reset_target();

draw_set_alpha(1);
draw_set_color(c_white);