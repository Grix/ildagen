function draw_ilda_2d() {
	//draws the frame surfaces

	var t_y = camera_get_view_y(view_camera[4]);

	if (laseron && !preview_while_laser_on)
	{
	    draw_set_halign(fa_center);
		draw_set_valign(fa_center);
		draw_set_color(c_red);
		draw_set_font(fnt_big);
	    draw_text_transformed(view_wport[4]/2,t_y+view_wport[4]/2,"Laser output active:\n"+string(dac[| 1]), dpi_multiplier, dpi_multiplier, 0);
	    draw_set_font(fnt_tooltip);
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	    exit;
	}

	if (frame_surf_refresh) or !surface_exists(frame3d_surf) or !surface_exists(frame_surf)
	{
	    refresh_surfaces();
	    frame_surf_refresh = 0;
	}

	if (viewmode != 0)
	    draw_surface_part(frame3d_surf, 0,0, view_wport[4], view_wport[4], 0, t_y);
	if (viewmode == 0) || (viewmode == 2)
		draw_surface_part(frame_surf, 0,0, view_wport[4], view_wport[4], 0, t_y);



}
