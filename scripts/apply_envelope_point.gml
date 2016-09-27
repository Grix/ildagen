gml_pragma("forceinline");

//apply envelope transforms to point data
if (env_hue)
{
    c = make_colour_hsv((colour_get_hue(c)+env_hue_val) mod 255,colour_get_saturation(c),colour_get_value(c));
}
if (env_a)
{
    c = merge_colour(c,c_black,env_a_val);
}
if (env_r) //todo optimize color functions (use direct operators)
{
    c = make_colour_rgb(colour_get_red(c)*env_r_val,colour_get_green(c),colour_get_blue(c));
}
if (env_g)
{
    c = make_colour_rgb(colour_get_red(c),colour_get_green(c)*env_g_val,colour_get_blue(c));
}
if (env_b)
{
    c = make_colour_rgb(colour_get_red(c),colour_get_green(c),colour_get_blue(c)*env_b_val);
}
if (env_rotabs)
{
    var t_actualanchor_x = $8000 - (xo-187)*480;
    var t_actualanchor_y = $8000 - yo*480;
    angle = degtorad(point_direction(t_actualanchor_x, t_actualanchor_y, xp, yp));
    dist = point_distance(t_actualanchor_x, t_actualanchor_y, xp, yp);
    xp = t_actualanchor_x+cos(env_rotabs_val-angle)*dist;
    yp = t_actualanchor_y+sin(env_rotabs_val-angle)*dist;
}
