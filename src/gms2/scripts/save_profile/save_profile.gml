function save_profile() {
	with (controller)
	{
		opt_blankshift = round(mean(opt_redshift, opt_greenshift, opt_blueshift));
		log(opt_blankshift);
		
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
		t_profilemap[? "swapxy"] = swapxy;
	    t_profilemap[? "red_scale"] = red_scale;
	    t_profilemap[? "green_scale"] = green_scale;
	    t_profilemap[? "blue_scale"] = blue_scale;
	    t_profilemap[? "intensity_master_scale"] = intensity_master_scale;
	    t_profilemap[? "red_scale_lower"] = red_scale_lower;
	    t_profilemap[? "green_scale_lower"] = green_scale_lower;
	    t_profilemap[? "blue_scale_lower"] = blue_scale_lower;
		t_profilemap[? "scale_top_left"] = scale_top_left;
		t_profilemap[? "scale_top_right"] = scale_top_right;
		t_profilemap[? "scale_bottom_left"] = scale_bottom_left;
		t_profilemap[? "scale_bottom_right"] = scale_bottom_right;
		t_profilemap[? "scale_right_top"] = scale_right_top;
		t_profilemap[? "scale_right_bottom"] = scale_right_bottom;
		t_profilemap[? "scale_left_top"] = scale_left_top;
		t_profilemap[? "scale_left_bottom"] = scale_left_bottom;
		t_profilemap[? "ttlpalette"] = ttlpalette;
	    t_profilemap[? "blindzones"] = ds_list_write(blindzone_list);
	}



}
