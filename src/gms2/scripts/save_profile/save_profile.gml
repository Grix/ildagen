with (controller)
{
    var t_profilemap = profile_list[| projector];
    t_profilemap[? "scanrate"] = opt_scanspeed;
    t_profilemap[? "maxdwell"] = opt_maxdwell;
    t_profilemap[? "maxdwell_blank"] = opt_maxdwell_blank;
    t_profilemap[? "blankshift"] = opt_blankshift;
    t_profilemap[? "redshift"] = opt_redshift;
    t_profilemap[? "greenshift"] = opt_greenshift;
    t_profilemap[? "blueshift"] = opt_blueshift;
    t_profilemap[? "maxdist"] = opt_maxdist;
    t_profilemap[? "format"] = exp_format;
    t_profilemap[? "optimize"] = exp_optimize;
    t_profilemap[? "onlyblanking"] = opt_onlyblanking;
    t_profilemap[? "invert_y"] = invert_x;
    t_profilemap[? "invert_x"] = invert_y;
    t_profilemap[? "red_scale"] = red_scale;
    t_profilemap[? "green_scale"] = green_scale;
    t_profilemap[? "blue_scale"] = blue_scale;
    t_profilemap[? "red_scale_lower"] = red_scale_lower;
    t_profilemap[? "green_scale_lower"] = green_scale_lower;
    t_profilemap[? "blue_scale_lower"] = blue_scale_lower;
    t_profilemap[? "x_scale_start"] = x_scale_start;
    t_profilemap[? "x_scale_end"] = x_scale_end;
    t_profilemap[? "y_scale_start"] = y_scale_start;
    t_profilemap[? "y_scale_end"] = y_scale_end;
    t_profilemap[? "blindzones"] = ds_list_write(blindzone_list);
}
