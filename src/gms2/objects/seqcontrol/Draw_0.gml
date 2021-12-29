if (room != rm_seq) 
    exit;

if (view_current == 4)
{	
    gpu_set_blendenable(false);
	draw_clear(c_black);
	
    //draws laser preview
    if  (!controller.laseron || controller.preview_while_laser_on) and 
        ((frame_surf_refresh == 1) or !surface_exists(frame_surf) or !surface_exists(frame_surf_large) or !surface_exists(frame3d_surf_large) or !surface_exists(frame3d_surf))
    {
        if (largepreview)
            refresh_seq_surface_large();
        else
            refresh_seq_surface();
            
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
		
		draw_set_alpha(0.8);
	    draw_set_color(c_ltgray);
	    draw_text_transformed(12,view_hport[4]-20*controller.dpi_multiplier,"Frame: "+string(frameprev-startframe+1)+"/"+string(endframe-startframe+1),controller.dpi_multiplier, controller.dpi_multiplier, 0);
		draw_text_transformed(300,view_hport[4]-20*controller.dpi_multiplier,"FPS: "+string(projectfps/controller.fpsmultiplier),controller.dpi_multiplier, controller.dpi_multiplier, 0);
    
		if (playing && (fps != projectfps/controller.fpsmultiplier) && controller.laseron)
		{
		    draw_set_color(c_red);
		    draw_text_transformed(300 + 100*controller.dpi_multiplier,view_hport[4]-20*controller.dpi_multiplier,"Warning: Dropping frames. Actual FPS: "+string(fps),controller.dpi_multiplier, controller.dpi_multiplier, 0);
		}
	}
	else if (largepreview)
    {
        if (viewmode != 0 && surface_exists(frame3d_surf_large))
            draw_surface_part(frame3d_surf_large,0,0,view_wport[4],view_hport[4]+view_hport[1],0,0);
            
        if (viewmode != 1 && surface_exists(frame_surf_large))
            draw_surface_part(frame_surf_large,0,0,view_wport[4],view_hport[4]+view_hport[1],0,0);
			
		draw_set_alpha(0.8);
	    draw_set_color(c_ltgray);
	    draw_text_transformed(12,7+16,"Frame: "+string(frameprev-startframe+1)+"/"+string(endframe-startframe+1),controller.dpi_multiplier, controller.dpi_multiplier, 0);
		draw_text_transformed(300,7+16,"FPS: "+string(projectfps/controller.fpsmultiplier),controller.dpi_multiplier, controller.dpi_multiplier, 0);
    
		if (playing && (fps != projectfps/controller.fpsmultiplier) && controller.laseron)
		{
		    draw_set_color(c_red);
		    draw_text_transformed(300+100*controller.dpi_multiplier,7+16,"Warning: Dropping frames. Actual FPS: "+string(fps),controller.dpi_multiplier, controller.dpi_multiplier, 0);
		}
	}
    else
    {
        if (viewmode != 0 && surface_exists(frame3d_surf))
            draw_surface_part(frame3d_surf,0,0,view_wport[4],view_hport[4],0,0);
            
        if (viewmode != 1 && surface_exists(frame_surf))
            draw_surface_part(frame_surf,0,0,view_wport[4],view_hport[4],0,0);
			
		draw_set_alpha(0.8);
	    draw_set_color(c_ltgray);
	    draw_text_transformed(12,view_hport[4]-20*controller.dpi_multiplier,"Frame: "+string(frameprev-startframe+1)+"/"+string(endframe-startframe+1),controller.dpi_multiplier, controller.dpi_multiplier, 0);
		draw_text_transformed(300,view_hport[4]-20*controller.dpi_multiplier,"FPS: "+string(projectfps/controller.fpsmultiplier),controller.dpi_multiplier, controller.dpi_multiplier, 0);
		
		if (playing && (fps != projectfps/controller.fpsmultiplier) && controller.laseron)
		{
		    draw_set_color(c_red);
		    draw_text_transformed(300+100*controller.dpi_multiplier,view_hport[4]-20*controller.dpi_multiplier,"Warning: Dropping frames. Actual FPS: "+string(fps),controller.dpi_multiplier, controller.dpi_multiplier, 0);
		}
	}
	draw_set_color(c_black);
}
else if (view_current == 1)
{
	gpu_set_blendenable(false);
	
	if (largepreview)
		draw_clear(c_black);
    //else
		//draw_clear(controller.c_ltltgray);
		
	gpu_set_blendenable(true);
	
	if (largepreview)
    {
	    if  (!controller.laseron) and ((frame_surf_refresh == 1) or !surface_exists(frame_surf_large) or !surface_exists(frame3d_surf_large))
	    {
	        refresh_seq_surface_large();
	        frame_surf_refresh = false;
	    }
	
        if (viewmode != 0 && surface_exists(frame3d_surf_large))
            draw_surface_part(frame3d_surf_large,0,0,view_wport[4],view_hport[4]+view_hport[1],0,camera_get_view_y(view_camera[1])-view_hport[4]);
            
        if (viewmode != 1 && surface_exists(frame_surf_large))
            draw_surface_part(frame_surf_large,0,0,view_wport[4],view_hport[4]+view_hport[1],0,camera_get_view_y(view_camera[1])-view_hport[4]);
    }
	else
	{
		refresh_timeline_surface();
	
	    draw_timeline();
	}
}
else if (view_current == 0)
{
	gpu_set_blendenable(false);
	//draw_clear(controller.c_ltltgray);
	
	//separator lines
	var t_w0 = max(1, camera_get_view_width(view_camera[0]));
	var t_x0 = camera_get_view_x(view_camera[0]);
	var t_y0 = camera_get_view_y(view_camera[0]);
	draw_set_color(c_ltgray);
	draw_line(t_x0+10, t_y0+433, t_x0+t_w0-10, t_y0+433);
	draw_line(t_x0+10, t_y0+566, t_x0+t_w0-10, t_y0+566);
	draw_set_color(c_white);
	draw_line(t_x0+10, t_y0+434, t_x0+t_w0-10, t_y0+434);
	draw_line(t_x0+10, t_y0+567, t_x0+t_w0-10, t_y0+567);
	
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
/*else if (view_current == 6)
{
	gpu_set_blendenable(false);
	
	//draw_clear(controller.c_ltltgray);
	
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
}*/
else if (view_current == 3)
{
    //menu
	var t_ypos = camera_get_view_y(view_camera[3]);
	var t_height = max(1, camera_get_view_height(view_camera[3]));
	//gpu_set_blendenable(false);
	//draw_clear(controller.c_ltltgray);
	draw_line(0, t_ypos+t_height-1, view_wport[3], t_ypos+t_height-1);
	//gpu_set_blendenable(true);
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
        else if (mouse_x > menu_width_start[5]) && (mouse_x < menu_width_start[6])
        {
			controller.tooltip = ".";
            draw_rectangle(menu_width_start[5],t_ypos+1,menu_width_start[6],t_ypos+t_height-3,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[5],t_ypos+1,menu_width_start[6],t_ypos+t_height-3,0);
        }
        draw_set_alpha(1);
    }
}