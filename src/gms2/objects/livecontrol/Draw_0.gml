if (room != rm_live) 
    exit;

if (view_current == 4)
{	
    gpu_set_blendenable(false);
	draw_clear(c_black);
	
    //draws laser preview
    if  (!controller.laseron) and 
        ((frame_surf_refresh == 1) | !surface_exists(frame_surf) || !surface_exists(frame3d_surf))
    {
        refresh_live_surface();
        frame_surf_refresh = false;
    }
	
	
	gpu_set_blendenable(true);
    if (controller.laseron)
    {
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_text(view_wport[4]/2,view_hport[2]/2,"Laser output active: "+string(controller.dac[| 1]));
        draw_set_halign(fa_left);
    }
    else
    {
        if (viewmode != 0)
            draw_surface_part(frame3d_surf,0,0,view_wport[4],view_hport[4],0,0);
            
        if (viewmode != 1)
            draw_surface_part(frame_surf,0,0,view_wport[4],view_hport[4],0,0);
    }
	draw_set_alpha(0.8);
	draw_set_color(c_ltgray);
	draw_text(12,7,"FPS: "+string(controller.projectfps));
	if (playing && (fps != controller.projectfps) && controller.laseron)
	{
	    draw_set_color(c_red);
	    draw_text(32,7,"Warning: Dropping frames. Actual FPS: "+string(fps));
	}
	draw_set_color(c_black);
	draw_set_alpha(1);
}
else if (view_current == 1)
{
	gpu_set_blendenable(false);
	
	draw_clear(controller.c_ltltgray);

	gpu_set_blendenable(true);
	
	refresh_browser_grid_surface();
	draw_browser_grid();
	
	var t_width = view_wport[1];
	var t_ystart = camera_get_view_y(view_camera[1]);
	var t_cells_per_row = ceil(t_width / target_width_per_cell);
	var t_cell_size = t_width / t_cells_per_row;
	
	if (highlightfile != -1)
	{
		var t_column = highlightfile mod t_cells_per_row;
		var t_row = highlightfile div t_cells_per_row;
		
		// highlight on mouseover
		draw_set_alpha(0.2);
		draw_set_color(c_white);
			draw_rectangle(t_column*t_cell_size+1, t_ystart+t_row*t_cell_size+1, t_column*t_cell_size+t_cell_size-1, t_ystart+t_row*t_cell_size+1+t_cell_size-1, 0);
		draw_set_alpha(1);
	}
	
	draw_set_color(c_green);
	for (i = 0; i < ds_list_size(filelist); i++)
	{
		// timeline
		if (ds_list_find_value(filelist[| i], 0))
		{
			var t_column = i mod t_cells_per_row;
			var t_row = i div t_cells_per_row;
			var t_positionratio = ds_list_find_value(ds_list_find_value(filelist[| i], 2), 0) / ds_list_find_value(ds_list_find_value(filelist[| i], 2), 2);
			draw_rectangle(t_column*t_cell_size+1, t_ystart+t_row*t_cell_size+t_cell_size-7, t_column*t_cell_size+(t_cell_size-2)*t_positionratio, t_ystart+t_row*t_cell_size+t_cell_size-1, 0);
		}
	}
}
else if (view_current == 0)
{
	
	gpu_set_blendenable(false);
	draw_clear(controller.c_ltltgray);
	
	//separator lines
	draw_set_color(c_white);
	var t_h0 = view_hport[0];
	var t_w0 = view_wport[0];
	var t_x0 = camera_get_view_x(view_camera[0]);
	var t_y0 = camera_get_view_y(view_camera[0]);
	draw_line(t_x0+10, t_y0+424, t_x0+t_w0-10, t_y0+424);
	draw_line(t_x0+10, t_y0+567, t_x0+t_w0-10, t_y0+567);
	draw_set_color(c_ltgray);
	draw_line(t_x0+10, t_y0+423, t_x0+t_w0-10, t_y0+423);
	draw_line(t_x0+10, t_y0+566, t_x0+t_w0-10, t_y0+566);
	draw_set_color(controller.c_gold);
	draw_line(t_x0+1, t_y0-1, t_x0+1, t_y0+t_h0+1);
	draw_set_color(c_black);
	draw_line(t_x0, t_y0-1, t_x0, t_y0+t_h0+1);
	draw_line(t_x0+2, t_y0-1, t_x0+2, t_y0+t_h0+1);
	
	with (obj_section1_parent)
	{
		if (!transparent && !visible)
		{
			if (_visible)
				draw_self();
		}
	}
	with (obj_section0_parent)
	{
		if (!transparent && !visible)
		{
			if (_visible)
				draw_self();
		}
	}
	gpu_set_blendenable(true);
}
else if (view_current == 6)
{
	gpu_set_blendenable(false);
	
	draw_clear(controller.c_ltltgray);
	
	//separator lines
	var t_h6 = view_hport[6];
	var t_x0 = camera_get_view_x(view_camera[0]);
	var t_y6 = camera_get_view_y(view_camera[6]);
	draw_set_color(controller.c_gold);
	draw_line(t_x0+1, t_y6-1, t_x0+1, t_y6+t_h6+1);
	draw_set_color(c_black);
	draw_line(t_x0, t_y6-1, t_x0, t_y6+t_h6+1);
	draw_line(t_x0+2, t_y6-1, t_x0+2, t_y6+t_h6+1);
	
	gpu_set_blendenable(true);
}
else if (view_current == 3)
{
    //menu
	draw_set_color(c_black);
	draw_set_alpha(1);
	var t_ypos = camera_get_view_y(view_camera[3]);
	gpu_set_blendenable(false);
	draw_clear(controller.c_ltltgray);
	draw_line(0, t_ypos+22, view_wport[3], t_ypos+22);
	gpu_set_blendenable(true);
    draw_text(0,t_ypos+4,menu_string);
    if (mouse_y < 0)   
    {
        draw_set_colour(c_teal);
        if (mouse_x > menu_width_start[0]) && (mouse_x < menu_width_start[1])
        {
            draw_rectangle(menu_width_start[0],t_ypos+1,menu_width_start[1],t_ypos+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[0],t_ypos+1,menu_width_start[1],t_ypos+20,0);
        }
        else if (mouse_x > menu_width_start[1]) && (mouse_x < menu_width_start[2])
        {
            draw_rectangle(menu_width_start[1],t_ypos+1,menu_width_start[2],t_ypos+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[1],t_ypos+1,menu_width_start[2],t_ypos+20,0);
        }
        else if (mouse_x > menu_width_start[2]) && (mouse_x < menu_width_start[3])
        {
            draw_rectangle(menu_width_start[2],t_ypos+1,menu_width_start[3],t_ypos+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[2],t_ypos+1,menu_width_start[3],t_ypos+20,0);
        }
        else if (mouse_x > menu_width_start[3]) && (mouse_x < menu_width_start[4])
        {
            draw_rectangle(menu_width_start[3],t_ypos+1,menu_width_start[4],t_ypos+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[3],t_ypos+1,menu_width_start[4],t_ypos+20,0);
        }
        else if (mouse_x > menu_width_start[4]) && (mouse_x < menu_width_start[5])
        {
            draw_rectangle(menu_width_start[4],t_ypos+1,menu_width_start[5],t_ypos+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[4],t_ypos+1,menu_width_start[5],t_ypos+20,0);
        }
        else if (mouse_x > menu_width_start[5]) && (mouse_x < menu_width_start[6])
        {
            draw_rectangle(menu_width_start[5],t_ypos+1,menu_width_start[6],t_ypos+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[5],t_ypos+1,menu_width_start[6],t_ypos+20,0);
        }
        draw_set_alpha(1);
    }
}