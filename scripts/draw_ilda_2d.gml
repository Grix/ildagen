//draws the frame surfaces
if (laseron)
    {
    draw_set_halign(fa_center);
    draw_text(256,250,"Laser output active: "+string(dac_string));
    draw_set_halign(fa_left);
    exit;
    }
    
if (frame_surf_refresh) or !surface_exists(frame3d_surf) or !surface_exists(frame_surf)
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
