//cycles through every element in frame on screen and draws them
if (frame_surf_refresh == 1)
    {
    refresh_surfaces();
    frame_surf_refresh = 0;
    }
draw_set_alpha(1);
if (viewmode != 0)
    {
    //draw_set_blend_mode(bm_add);
    draw_surface(frame3d_surf,0,0);
    //draw_set_blend_mode(bm_normal);
    }
if (viewmode == 0) or (viewmode == 2)
    draw_surface(frame_surf,0,0);
