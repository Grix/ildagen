//draws the frame surfaces

var t_y = camera_get_view_y(view_camera[4]);

if (laseron)
{
    draw_set_halign(fa_center);
    draw_text(view_wport[4]/2,t_y+view_wport[4]/2,"Laser output active: "+string(dac[| 1]));
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
    draw_surface_part(frame3d_surf, 0,0, view_wport[4], view_wport[4], 0, t_y);
if (viewmode == 0) || (viewmode == 2)
	draw_surface_part(frame_surf, 0,0, view_wport[4], view_wport[4], 0, t_y);
