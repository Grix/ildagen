function square_grid_refresh() {
	if (surface_exists(squaregrid_surf))
	    surface_free(squaregrid_surf);
	squaregrid_surf = surface_create(max(1, power(2, ceil(log2(view_wport[4])))), max(1, power(2, ceil(log2(view_wport[4])))));
	surface_set_target(squaregrid_surf);
	    draw_grid();
	surface_reset_target();



}
