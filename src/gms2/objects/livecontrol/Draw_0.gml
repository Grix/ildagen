if (room != rm_live) 
    exit;

if (view_current == 4)
{	
    gpu_set_blendenable(false);
	draw_clear(c_black);
	
    //draws laser preview
    if  (!controller.laseron || controller.preview_while_laser_on) and 
        ((frame_surf_refresh == 1) | !surface_exists(frame_surf) || !surface_exists(frame3d_surf))
    {
        refresh_live_surface();
        frame_surf_refresh = false;
    }
	
	
	gpu_set_blendenable(true);
    if (controller.laseron && !controller.preview_while_laser_on)
    {
        draw_set_halign(fa_center);
		draw_set_valign(fa_center);
        draw_set_color(c_red);
		draw_set_font(fnt_big);
        draw_text(view_wport[4]/2,min(view_hport[2]/2, 64),"Laser output active:\n"+string(controller.dac[| 1]));
        draw_set_font(fnt_tooltip);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
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
	draw_set_halign(fa_right);
	draw_text(view_wport[4] - 12,7,"FPS: "+string(controller.projectfps/controller.fpsmultiplier));
	if (playing && (fps != controller.projectfps/controller.fpsmultiplier) && controller.laseron)
	{
	    draw_set_color(c_red);
	    draw_text(view_wport[4] - 12,24,"Warning: Dropping frames. Actual FPS: "+string(fps));
	}
	draw_set_color(c_black);
	draw_set_halign(fa_left);
	draw_set_alpha(1);
}
else if (view_current == 1)
{
	refresh_browser_grid_surface();
	draw_browser_grid();
	
}
else if (view_current == 0)
{
	gpu_set_blendenable(false);
	
	//separator lines
	draw_set_color(c_white);
	var t_w0 = view_wport[0];
	var t_x0 = camera_get_view_x(view_camera[0]);
	var t_y0 = camera_get_view_y(view_camera[0]);
	draw_line(t_x0+10, t_y0+434, t_x0+t_w0-10, t_y0+434);
	draw_line(t_x0+10, t_y0+567, t_x0+t_w0-10, t_y0+567);
	draw_set_color(c_ltgray);
	draw_line(t_x0+10, t_y0+433, t_x0+t_w0-10, t_y0+433);
	draw_line(t_x0+10, t_y0+566, t_x0+t_w0-10, t_y0+566);
	draw_set_color(c_black);
	
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
else if (view_current == 3)
{
    //menu
	draw_set_color(c_black);
	draw_set_alpha(1);
	var t_ypos = camera_get_view_y(view_camera[3]);
	var t_height = max(1, camera_get_view_height(view_camera[3]));
	draw_line(0, t_ypos+t_height-1, view_wport[3], t_ypos+t_height-1);
    draw_text(0,t_ypos+4,menu_string);
    if (mouse_y < 0)   
    {
        draw_set_colour(c_teal);
        if (mouse_x > menu_width_start[0]) && (mouse_x < menu_width_start[1])
        {
			controller.tooltip = ".";
            draw_rectangle(menu_width_start[0],t_ypos+1,menu_width_start[1],t_ypos+t_height-3,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[0],t_ypos+1,menu_width_start[1],t_ypos+t_height-3,0);
        }
        else if (mouse_x > menu_width_start[1]) && (mouse_x < menu_width_start[2])
        {
			controller.tooltip = ".";
            draw_rectangle(menu_width_start[1],t_ypos+1,menu_width_start[2],t_ypos+t_height-3,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[1],t_ypos+1,menu_width_start[2],t_ypos+t_height-3,0);
        }
        else if (mouse_x > menu_width_start[2]) && (mouse_x < menu_width_start[3])
        {
			controller.tooltip = ".";
            draw_rectangle(menu_width_start[2],t_ypos+1,menu_width_start[3],t_ypos+t_height-3,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[2],t_ypos+1,menu_width_start[3],t_ypos+t_height-3,0);
        }
        else if (mouse_x > menu_width_start[3]) && (mouse_x < menu_width_start[4])
        {
			controller.tooltip = ".";
            draw_rectangle(menu_width_start[3],t_ypos+1,menu_width_start[4],t_ypos+t_height-3,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[3],t_ypos+1,menu_width_start[4],t_ypos+t_height-3,0);
        }
        else if (mouse_x > menu_width_start[4]) && (mouse_x < menu_width_start[5])
        {
			controller.tooltip = ".";
            draw_rectangle(menu_width_start[4],t_ypos+1,menu_width_start[5],t_ypos+t_height-3,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[4],t_ypos+1,menu_width_start[5],t_ypos+t_height-3,0);
        }
        draw_set_alpha(1);
    }
}