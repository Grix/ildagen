if (!surface_exists(browser_grid_surf))
{
    timeline_surf = surface_create(power(2, ceil(log2(view_wport[1]+512))), power(2, ceil(log2(view_hport[1]))));
}