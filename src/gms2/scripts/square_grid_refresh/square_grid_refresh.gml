if (surface_exists(squaregrid_surf))
    surface_free(squaregrid_surf);
squaregrid_surf = surface_create(512,512);
surface_set_target(squaregrid_surf);
    draw_grid();
surface_reset_target();
