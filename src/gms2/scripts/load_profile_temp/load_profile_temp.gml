/// @description load_profile_temp(projector)
/// @function load_profile_temp
/// @param projector

with (controller)
{
    var t_profile = argument[0];
    var t_profilemap = profile_list[| t_profile];
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
    opt_onlyblanking = t_profilemap[? "onlyblanking"];
	if (exp_optimize || opt_onlyblanking)
		controller.opt_warning_flag = 1;
    invert_x = t_profilemap[? "invert_y"];
    invert_y = t_profilemap[? "invert_x"];
	swapxy = t_profilemap[? "swapxy"];
    red_scale = t_profilemap[? "red_scale"];
    green_scale = t_profilemap[? "green_scale"];
    blue_scale = t_profilemap[? "blue_scale"];
    red_scale_lower = t_profilemap[? "red_scale_lower"];
    green_scale_lower = t_profilemap[? "green_scale_lower"];
    blue_scale_lower = t_profilemap[? "blue_scale_lower"];
	scale_top_left = t_profilemap[? "scale_top_left"];
	scale_top_right = t_profilemap[? "scale_top_right"];
	scale_bottom_left = t_profilemap[? "scale_bottom_left"];
	scale_bottom_right = t_profilemap[? "scale_bottom_right"];
	scale_right_top = t_profilemap[? "scale_right_top"];
	scale_right_bottom = t_profilemap[? "scale_right_bottom"];
	scale_left_top = t_profilemap[? "scale_left_top"];
	scale_left_bottom = t_profilemap[? "scale_left_bottom"];
	ttlpalette = t_profilemap[? "ttlpalette"];
	if (ttlpalette == 0)
		pal_list = pal_list_ilda;
	else
		pal_list = pal_list_ttl;
	
    ds_list_read(blindzone_list, t_profilemap[? "blindzones"]);
    
    if (!exp_optimize)
        opt_onlyblanking = false;
}
