save_profile();

with (controller)
{
    ini_open("settings.ini");
    
        ini_write_real("main", "projector",projector);
        ini_write_real("main", "show_tooltip",show_tooltip);
		/*ini_write_real("main", "window_width", window_get_width());
		ini_write_real("main", "window_height", window_get_height());
		ini_write_real("main", "window_x", window_get_x());
		ini_write_real("main", "window_y", window_get_y());*/
        
        for (i = 0; i < ds_list_size(profile_list); i++)
        {
            var t_projectorstring = "projector_"+string(i);
            var t_profilemap = profile_list[| i];
            
            ini_write_string(t_projectorstring, "name", t_profilemap[? "name"]);
            ini_write_real(t_projectorstring, "scanrate", t_profilemap[? "scanrate"]);
            ini_write_real(t_projectorstring, "maxdist", t_profilemap[? "maxdist"]);
            ini_write_real(t_projectorstring, "maxdwell", t_profilemap[? "maxdwell"]);
            ini_write_real(t_projectorstring, "maxdwell_blank", t_profilemap[? "maxdwell_blank"]);
            ini_write_real(t_projectorstring, "blankshift", t_profilemap[? "blankshift"]);
            ini_write_real(t_projectorstring, "redshift", t_profilemap[? "redshift"]);
            ini_write_real(t_projectorstring, "greenshift", t_profilemap[? "greenshift"]);
            ini_write_real(t_projectorstring, "blueshift", t_profilemap[? "blueshift"]);
            ini_write_real(t_projectorstring, "format", t_profilemap[? "format"]);
            ini_write_real(t_projectorstring, "optimize", t_profilemap[? "optimize"]);
            ini_write_real(t_projectorstring, "onlyblanking", t_profilemap[? "onlyblanking"]);
            ini_write_real(t_projectorstring, "invert_y", t_profilemap[? "invert_y"]);
            ini_write_real(t_projectorstring, "invert_x", t_profilemap[? "invert_x"]);
			ini_write_real(t_projectorstring, "swapxy", t_profilemap[? "swapxy"]);
            ini_write_real(t_projectorstring, "red_scale", t_profilemap[? "red_scale"]);
            ini_write_real(t_projectorstring, "green_scale", t_profilemap[? "green_scale"]);
            ini_write_real(t_projectorstring, "blue_scale", t_profilemap[? "blue_scale"]);
            ini_write_real(t_projectorstring, "red_scale_lower", t_profilemap[? "red_scale_lower"]);
            ini_write_real(t_projectorstring, "green_scale_lower", t_profilemap[? "green_scale_lower"]);
            ini_write_real(t_projectorstring, "blue_scale_lower", t_profilemap[? "blue_scale_lower"]);
            ini_write_real(t_projectorstring, "scale_top_left", t_profilemap[? "scale_top_left"]);
            ini_write_real(t_projectorstring, "scale_top_right", t_profilemap[? "scale_top_right"]);
            ini_write_real(t_projectorstring, "scale_bottom_left", t_profilemap[? "scale_bottom_left"]);
            ini_write_real(t_projectorstring, "scale_bottom_right", t_profilemap[? "scale_bottom_right"]);
            ini_write_real(t_projectorstring, "scale_right_top", t_profilemap[? "scale_right_top"]);
            ini_write_real(t_projectorstring, "scale_right_bottom", t_profilemap[? "scale_right_bottom"]);
            ini_write_real(t_projectorstring, "scale_left_top", t_profilemap[? "scale_left_top"]);
            ini_write_real(t_projectorstring, "scale_left_bottom", t_profilemap[? "scale_left_bottom"]);
			ini_write_real(t_projectorstring, "ttlpalette", t_profilemap[? "ttlpalette"]);
            ini_write_string(t_projectorstring, "blindzones", t_profilemap[? "blindzones"]);
        }
        
        num = i;
        while (1)
        {
            var t_projectorstring = "projector_"+string(num);
            if (ini_section_exists(t_projectorstring))
                ini_section_delete(t_projectorstring);
            else
                break;
            num++;
        }
        
        if (room == rm_options)
            obj_profiles.preset_name = ds_map_find_value(profile_list[| projector], "name");
    
    ini_close();
}
