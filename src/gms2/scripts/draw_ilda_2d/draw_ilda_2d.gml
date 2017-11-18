//draws the frame surfaces

if (laseron)
{
    draw_set_halign(fa_center);
    draw_text(view_wport[4]/2,view_wport[4]/2,"Laser output active: "+string(dac[| 1]));
    draw_set_halign(fa_left);
    exit;
}
    //todo blendenable disable?
if (frame_surf_refresh) or !surface_exists(frame3d_surf) or !surface_exists(frame_surf)
{
    refresh_surfaces();
    frame_surf_refresh = 0;
}

if (viewmode != 0)
    draw_surface_part(frame3d_surf, 0,0, view_wport[4], view_wport[4], camera_get_view_x(view_camera[4]), camera_get_view_y(view_camera[4]));
if (viewmode == 0) || (viewmode == 2)
	draw_surface_part(frame_surf, 0,0, view_wport[4], view_wport[4], camera_get_view_x(view_camera[4]), camera_get_view_y(view_camera[4]));
