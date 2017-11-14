if (surface_exists(squaregrid_surf))
    surface_free(squaregrid_surf);
squaregrid_surf = surface_create(power(2, ceil(log2(view_wport[4]))), power(2, ceil(log2(view_wport[4]))));
surface_set_target(squaregrid_surf);
    draw_grid();
surface_reset_target();
