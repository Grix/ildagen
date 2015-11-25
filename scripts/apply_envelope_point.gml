//apply envelope transforms to point data
if (env_hue)
    {
    c = make_colour_hsv((colour_get_hue(c)+env_hue_val) mod 255,colour_get_saturation(c),colour_get_value(c));
    }
if (env_a)
    {
    c = merge_colour(c,c_black,env_a_val);
    }
if (env_r)
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
