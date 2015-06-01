//draws the frame surfaces
if (frame_surf_refresh == 1) or !surface_exists(frame3d_surf) or !surface_exists(frame_surf)
    {
    refresh_surfaces();
    frame_surf_refresh = 0;
    }
draw_set_alpha(1);
if (viewmode != 0)
    {
    draw_surface(frame3d_surf,0,0);
    }
if (viewmode == 0) or (viewmode == 2)
    draw_surface(frame_surf,0,0);