with (controller)
{
    var t_profilemap = profile_list[| projector];
    opt_scanspeed = t_profilemap[? "scanrate"];
    opt_maxdwell = t_profilemap[? "maxdwell"];
    opt_maxdwell_blank = t_profilemap[? "maxdwell_blank"];
    opt_blankshift = t_profilemap[? "blankshift"];
    opt_redshift = t_profilemap[? "redshift"];
    opt_greenshift = t_profilemap[? "greenshift"];
    opt_blueshift = t_profilemap[? "blueshift"];
    opt_maxdist = t_profilemap[? "maxdist"];
    exp_format = t_profilemap[? "format"];
    exp_optimize = t_profilemap[? "optimize"];
    invert_x = t_profilemap[? "invert_y"];
    invert_y = t_profilemap[? "invert_x"];
    red_scale = t_profilemap[? "red_scale"];
    green_scale = t_profilemap[? "green_scale"];
    blue_scale = t_profilemap[? "blue_scale"];
    red_scale_lower = t_profilemap[? "red_scale_lower"];
    green_scale_lower = t_profilemap[? "green_scale_lower"];
    blue_scale_lower = t_profilemap[? "blue_scale_lower"];
    x_scale_start = t_profilemap[? "x_scale_start"];
    x_scale_end = t_profilemap[? "x_scale_end"];
    y_scale_start = t_profilemap[? "y_scale_start"];
    y_scale_end = t_profilemap[? "y_scale_end"];
    ds_list_read(blindzone_list, t_profilemap[? "blindzones"]);
}

update_colors_scalesettings();

with (obj_profiles)
    surface_free(surf_profilelist);
