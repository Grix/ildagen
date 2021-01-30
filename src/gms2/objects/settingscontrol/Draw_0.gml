if (room != rm_options)
    exit;
    
//menu
if (view_current == 3)
{
	draw_set_colour(c_black);
	draw_set_alpha(1);
	var t_ypos = camera_get_view_y(view_camera[3]);
	var t_height = max(1, camera_get_view_height(view_camera[3]));
	draw_line(0, t_ypos+t_height-2, view_wport[3], t_ypos+t_height-2);
	draw_text(0, t_ypos+4, menu_string);
	if (mouse_y > t_ypos)   
	{
	    draw_set_colour(c_teal);
	    if (mouse_x > menu_width_start[0]) and (mouse_x < menu_width_start[1])
	    {
			controller.tooltip = ".";
	        draw_rectangle(menu_width_start[0], t_ypos+1,menu_width_start[1], t_ypos+t_height-3,1);
	        draw_set_alpha(0.3);
	        draw_rectangle(menu_width_start[0], t_ypos+1,menu_width_start[1], t_ypos+t_height-3,0);
	    }
	    else if (mouse_x > menu_width_start[1]) and (mouse_x < menu_width_start[2])
	    {
			controller.tooltip = ".";
	        draw_rectangle(menu_width_start[1], t_ypos+1,menu_width_start[2], t_ypos+t_height-3,1);
	        draw_set_alpha(0.3);
	        draw_rectangle(menu_width_start[1], t_ypos+1,menu_width_start[2], t_ypos+t_height-3,0);
	    }
	    draw_set_alpha(1);
	}
}
else if (view_current == 1)
{
	gpu_set_blendenable(false);
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
else if (view_current == 0)
{
	//draw_clear(controller.c_ltltgray);
}
