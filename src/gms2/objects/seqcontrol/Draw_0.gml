if (room != rm_seq) 
    exit;
	
if (window_get_height() != controller.window_heightprev || window_get_width() != controller.window_widthprev) || true
{
	if (window_get_height() < controller.default_window_h || window_get_width() < controller.default_window_w)
		window_set_size(controller.default_window_w, controller.default_window_h);
	
	view_hport[0] = 706;
	view_wport[0] = 316;
	view_wport[1] = window_get_width()-view_wport[0];
	view_hport[1] = (window_get_height()-view_hport[3])/706*(706-136);
	view_yport[1] = view_hport[4]+view_hport[3];
	view_wport[4] = view_wport[1];
	view_hport[4] = window_get_height()-view_hport[3]-view_hport[1];
	view_xport[0] = view_wport[1];
	view_wport[6] = view_wport[0];
	view_hport[6] = window_get_height()-view_hport[3]-view_hport[0];
	view_xport[6] = view_xport[0];
	view_yport[6] = view_hport[3]+view_hport[0];
	view_wport[3] = window_get_width();
	view_yport[3] = 0;
	camera_set_view_size(view_camera[0], view_wport[0], view_hport[0]);
	camera_set_view_size(view_camera[3], view_wport[3], view_hport[3]);
	camera_set_view_size(view_camera[4], view_wport[4], view_hport[4]);
	camera_set_view_size(view_camera[1], view_wport[1], view_hport[1]);
	camera_set_view_size(view_camera[6], view_wport[6], view_hport[6]);
	camera_set_view_pos(view_camera[6], 987, view_yport[6]-view_hport[3]);
	tlw = view_wport[1];
	tlh = view_hport[1]/570*136;
	tlsurf_y = ybar;
	tls = tlh+tlsurf_y+16; //start of layer area, seen from outside surface
	lbh = view_hport[1]-32-tlh-tlsurf_y;
	lbsh = tlh+15+lbh; //start of bottom scrollbar, seen from inside surface
	tlhalf = tlh/2;
	tlthird = tlh/3;
	
	controller.window_heightprev = window_get_height();
	controller.window_widthprev = window_get_width();
	/*view_hport[4] = window_get_height()/970*136-view_hport[3];
	view_wport[4] = view_hport[4]-tlh-1;
	view_wport[3] = window_get_width();
	view_wport[0] = 316;
	view_hport[0] = 706;//default_window_h-view_hport[3]; //window_get_height()-view_hport[3];
	view_hport[6] = window_get_height()-view_hport[3]-view_hport[0];
	view_wport[6] = view_wport[0];
	view_hport[1] = 136; //window_get_height()-view_hport[4];
	view_wport[1] = view_wport[4];
	view_yport[1] = view_hport[4]+view_hport[3];
	view_yport[6] = view_hport[3]+view_hport[0];
	tlw = view_wport[1]-16;
	tlh = view_hport[1]/705*136-16;
	camera_set_view_size(view_camera[0], view_wport[0], view_hport[0]);
	camera_set_view_size(view_camera[3], view_wport[3], view_hport[3]);
	camera_set_view_size(view_camera[4], view_wport[4], view_hport[4]);
	camera_set_view_size(view_camera[1], view_wport[1], view_hport[1]);
	camera_set_view_size(view_camera[6], view_wport[6], view_hport[6]);
	//camera_set_view_pos(view_camera[3], 0, -25);
	view_xport[0] = view_wport[4];
	view_xport[6] = view_xport[0];
	camera_set_view_pos(view_camera[6], 512, view_yport[6]-view_hport[3]);
	
	controller.window_heightprev = window_get_height();
	controller.window_widthprev = window_get_width();
	
	*/
}

if (view_current == 4)
{	
    gpu_set_blendenable(false);
	draw_clear(c_black);
	
    //draws laser preview
    if  (!controller.laseron) and 
        ((frame_surf_refresh == 1) or !surface_exists(frame_surf) or !surface_exists(frame_surf_large) or !surface_exists(frame3d_surf_large) or !surface_exists(frame3d_surf))
    {
        if (largepreview)
            refresh_seq_surface_large();
        else
            refresh_seq_surface();
            
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
    
    draw_set_alpha(0.8);
    draw_set_color(c_ltgray);
    
    draw_text(12,view_hport[4]-20,"Frame: "+string(frameprev-startframe+1)+"/"+string(endframe-startframe+1));
    
    draw_text(12,7,"FPS: "+string(projectfps));
    if (playing && (fps != projectfps) && controller.laseron)
    {
        draw_set_color(c_red);
        draw_text(32,7,"Warning: Dropping frames. Actual FPS: "+string(fps));
    }
}
else if (view_current == 1)
{
	gpu_set_blendenable(false);
	draw_clear(controller.c_ltltgray);
	gpu_set_blendenable(true);
	
	refresh_timeline_surface();
	
    draw_timeline();
	
    /*else if (largepreview)
    {
        draw_set_colour(c_black);
        draw_rectangle(89,49,691,651,0);
        draw_set_color(c_white);
        
        if (viewmode != 0)
            draw_surface_part(frame3d_surf_large,0,0,600,600,90,50);
            
        if (viewmode != 1)
            draw_surface_part(frame_surf_large,0,0,600,600,90,50);
    }
    else
    {
        if (viewmode != 0)
            draw_surface_part(frame3d_surf,0,0,509,135,0,0);
            
        if (viewmode != 1)
            draw_surface_part(frame_surf,0,0,509,135,0,0);
    }*/
}
else if (view_current == 0)
{
	gpu_set_blendenable(false);
	draw_clear(controller.c_ltltgray);
	
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
	draw_clear(controller.c_ltltgray);
}
else if (view_current == 3)
{
    //menu
	gpu_set_blendenable(false);
	draw_clear(controller.c_ltltgray);
	gpu_set_blendenable(true);
	var t_ypos = camera_get_view_y(view_camera[3]);
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
        else if (mouse_x > menu_width_start[6]) and (mouse_x < menu_width_start[7])
        {
            draw_rectangle(menu_width_start[6],t_ypos+1,menu_width_start[7],t_ypos+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[6],t_ypos+1,menu_width_start[7],t_ypos+20,0);
        }
        draw_set_alpha(1);
    }
}