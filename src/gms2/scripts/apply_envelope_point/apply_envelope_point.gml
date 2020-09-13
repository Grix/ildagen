function apply_envelope_point() {
	gml_pragma("forceinline");

	//apply envelope transforms to point data
	if (env_hue)
	{
	    c = make_colour_hsv((colour_get_hue(c)+env_hue_val+255) % 255,colour_get_saturation(c),colour_get_value(c));
	}
	if (env_a)
	{
	    c = merge_colour(c,c_black,env_a_val);
	}
	if (env_r)
	{
	    c = (c & $FFFF00) | ((c & $FF)*env_r_val);
	}
	if (env_g)
	{
	    c = (c & $FF00FF) | ((((c >> 8) & $FF)*env_g_val) << 8);
	}
	if (env_b)
	{
	    c = (c & $00FFFF) | (((c >> 16)*env_b_val) << 16);
	}
	if (env_rotabs)
	{
	    var t_actualanchor_x = $8000 - xo_raw;
	    var t_actualanchor_y = $8000 - yo_raw;
	    angle = degtorad(point_direction(t_actualanchor_x, t_actualanchor_y, xp, yp));
	    dist = point_distance(t_actualanchor_x, t_actualanchor_y, xp, yp);
	    xp = t_actualanchor_x+cos(env_rotabs_val-angle)*dist;
	    yp = t_actualanchor_y+sin(env_rotabs_val-angle)*dist;
	}



}
