function draw_browser_grid() {
	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_set_font(fnt_bold);
	draw_surface_part(browser_surf, 0, scrollbary, camera_get_view_width(view_camera[1]), camera_get_view_height(view_camera[1]), camera_get_view_x(view_camera[1]), camera_get_view_y(view_camera[1]));

	var t_width = max(1, camera_get_view_width(view_camera[1])-scrollbarwidth+1);
	var t_ystart = camera_get_view_y(view_camera[1])-scrollbary;
	var t_cells_per_row = num_grid_columns;//ceil(t_width / (target_width_per_cell));
	var t_cell_size = t_width / t_cells_per_row;

	if (highlightfile != -1)
	{
		var t_column = highlightfile mod t_cells_per_row;
		var t_row = highlightfile div t_cells_per_row;
	
		if (t_ystart+t_row*t_cell_size >= 0)
		{
			// highlight on mouseover
			draw_set_alpha(0.2);
			draw_set_color(c_white);
				draw_rectangle(t_column*t_cell_size+1, t_ystart+t_row*t_cell_size+1, t_column*t_cell_size+t_cell_size-1, t_ystart+t_row*t_cell_size+1+t_cell_size-1, 0);
			draw_set_alpha(1);
		}
	}
	
	for (i = 0; i < ds_list_size(filelist); i++)
	{
		var t_column = i mod t_cells_per_row;
		var t_row = i div t_cells_per_row;
	
		if (t_ystart+t_row*t_cell_size < 0)
			continue;
	
		objectlist = filelist[| i];
		
		if (objectlist[| 7] && t_cell_size > 35+16)
		{
			draw_sprite(spr_loop, 0, t_column*t_cell_size+3, t_ystart+t_row*t_cell_size+35);
		}
		if (objectlist[| 8] && t_cell_size > 35+32)
		{
			draw_sprite(spr_exclusive, 0, t_column*t_cell_size+3, t_ystart+t_row*t_cell_size+35+16);
		}
		if (objectlist[| 9] && t_cell_size > 35+48)
		{
			draw_sprite(spr_resume, 0, t_column*t_cell_size+3, t_ystart+t_row*t_cell_size+35+32);
		}
		if (objectlist[| 10] && t_cell_size > 35+72)
		{
			draw_sprite(spr_hold, 0, t_column*t_cell_size+3, t_ystart+t_row*t_cell_size+35+48);
		}
		
		// timeline
		if (ds_list_find_value(objectlist, 0))
		{
			var t_positionratio = (objectlist[| 2]+1) / objectlist[| 4];
			draw_set_color(c_green);
			draw_rectangle(t_column*t_cell_size+1, t_ystart+t_row*t_cell_size+t_cell_size-7, t_column*t_cell_size+(t_cell_size-2)*t_positionratio, t_ystart+t_row*t_cell_size+t_cell_size-1, 0);
		}
		
		if (selectedfile == i)
		{
			draw_set_alpha(0.3);
			draw_set_color(controller.c_gold);
				draw_rectangle(t_column*t_cell_size+1, t_ystart+t_row*t_cell_size+1, t_column*t_cell_size-1+t_cell_size, t_ystart+t_row*t_cell_size-1+t_cell_size, 0);
			draw_set_alpha(1);
		}
		
		var t_skip_drawing_shortcut = (objectlist[| 6] == -1) || (objectlist[| 13] == -1);
		
		
		if (objectlist[| 6] == -1)
		{
			draw_set_color(controller.c_gold);
			draw_text(t_column*t_cell_size+4, t_ystart+t_row*t_cell_size+4, "Press key..");
		}
		else if (objectlist[| 6] > 0 && !t_skip_drawing_shortcut)
		{
			draw_set_color(c_white);
			draw_text(t_column*t_cell_size+4, t_ystart+t_row*t_cell_size+4, chr(objectlist[| 6]));
		}
		
		if (objectlist[| 11] != "")
		{
			draw_set_color(c_ltgray);
			draw_set_font(fnt_tooltip);
			draw_text(t_column*t_cell_size+4, t_ystart+t_row*t_cell_size+19, objectlist[| 11]);
		}
		
		if (objectlist[| 13] == -1)
		{
			draw_set_color(controller.c_gold);
			draw_set_halign(fa_right);
			draw_text(t_column*t_cell_size+t_cell_size - 4, t_ystart+t_row*t_cell_size+4, "Press MIDI key..");
			draw_set_halign(fa_left);
		}
		else if (objectlist[| 13] > 0 && !t_skip_drawing_shortcut)
		{
			draw_set_color(c_teal);
			draw_set_halign(fa_right);
			draw_text(t_column*t_cell_size+t_cell_size - 4, t_ystart+t_row*t_cell_size+4, string(objectlist[| 13] >> 8) + midi_get_note_name(objectlist[| 13] & $FF));
			draw_set_halign(fa_left);
		}
	}
	

	draw_set_font(fnt_tooltip);

	// scrollbar
	gpu_set_blendenable(false);

	var t_gridheight = camera_get_view_height(view_camera[1]);
	ypos_perm = (ceil(ds_list_size(filelist)/t_cells_per_row)) * t_cell_size;
	scrollbarw = clamp(t_gridheight/(ypos_perm+t_gridheight)*(t_gridheight-1),32,t_gridheight-1);
	var scrolly_x1 = t_width-2;
	var scrolly_x2 = scrolly_x1+scrollbarwidth;
	var scrolly_y1 = round(t_ystart+scrollbary+(scrollbary*scrollbarw/t_gridheight));
	var scrolly_y2 = round(scrolly_y1+scrollbarw);
	draw_set_color(c_white);
	draw_rectangle(scrolly_x1, t_ystart+scrollbary-1, scrolly_x2-1, t_ystart+scrollbary+t_gridheight-1, 0);
	draw_set_colour(c_gray);
	draw_rectangle(scrolly_x1,scrolly_y1,scrolly_x2,scrolly_y2,0);
	draw_set_colour(c_black);
	draw_rectangle(scrolly_x1,scrolly_y1,scrolly_x2+1,scrolly_y2,1);
	draw_rectangle(scrolly_x1, t_ystart+scrollbary, scrolly_x2-1, t_ystart+scrollbary+t_gridheight-1, 1);

	gpu_set_blendenable(true);

}
