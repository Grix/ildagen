with (controller)
{
    ini_open("settings.ini");
    
        if (!ini_section_exists("projector_0"))
        {
            ini_write_string("projector_0", "name", "default");
            ini_write_real("projector_0", "scanrate", 20000);
            ini_write_real("projector_0", "maxdist", 150);
            ini_write_real("projector_0", "maxdwell", 2);
            ini_write_real("projector_0", "maxdwell_blank", 1);
            ini_write_real("projector_0", "blankshift", 0);
            ini_write_real("projector_0", "redshift", 0);
            ini_write_real("projector_0", "greenshift", 0);
            ini_write_real("projector_0", "blueshift", 0);
            ini_write_real("projector_0", "format", 5);
            ini_write_real("projector_0", "invert_x", false);
            ini_write_real("projector_0", "invert_y", false);
            ini_write_real("projector_0", "optimize", 1);
            ini_write_real("projector_0", "onlyblanking", false);
            ini_write_real("projector_0", "red_scale", 1);
            ini_write_real("projector_0", "green_scale", 1);
            ini_write_real("projector_0", "blue_scale", 1);
            ini_write_real("projector_0", "red_scale_lower", 0);
            ini_write_real("projector_0", "green_scale_lower", 0);
            ini_write_real("projector_0", "blue_scale_lower", 0);
            ini_write_real("projector_0", "scale_top_left", 0);
			ini_write_real("projector_0", "scale_top_right", 0);
			ini_write_real("projector_0", "scale_bottom_left", $ffff);
			ini_write_real("projector_0", "scale_bottom_right", $ffff);
			ini_write_real("projector_0", "scale_left_top", 0);
			ini_write_real("projector_0", "scale_left_bottom", 0);
			ini_write_real("projector_0", "scale_right_top", $ffff);
			ini_write_real("projector_0", "scale_right_bottom", $ffff);
			ini_write_real("projector_0", "ttlpalette", 0);
            ini_write_string("projector_0", "blindzones", emptyliststring);
        }
        
        //build map of profiles
        num = 0;
        while (1)
        {
            var t_projectorstring = "projector_"+string(num);
            if (!ini_section_exists(t_projectorstring))
                break;
                
            var t_profilemap = ds_map_create();
            ds_map_add(t_profilemap, "name", ini_read_string(t_projectorstring, "name", "name_error"));
            ds_map_add(t_profilemap, "scanrate", ini_read_real(t_projectorstring, "scanrate", 20000));
            ds_map_add(t_profilemap, "maxdwell", ini_read_real(t_projectorstring, "maxdwell", 2));
            ds_map_add(t_profilemap, "maxdwell_blank", ini_read_real(t_projectorstring, "maxdwell_blank", 1));
            ds_map_add(t_profilemap, "blankshift", ini_read_real(t_projectorstring, "blankshift", 0));
            ds_map_add(t_profilemap, "redshift", ini_read_real(t_projectorstring, "redshift", 0));
            ds_map_add(t_profilemap, "greenshift", ini_read_real(t_projectorstring, "greenshift", 0));
            ds_map_add(t_profilemap, "blueshift", ini_read_real(t_projectorstring, "blueshift", 0));
            ds_map_add(t_profilemap, "maxdist", ini_read_real(t_projectorstring, "maxdist", 150));
            ds_map_add(t_profilemap, "format", ini_read_real(t_projectorstring, "format", 5));
            ds_map_add(t_profilemap, "optimize", ini_read_real(t_projectorstring, "optimize", 1));
            ds_map_add(t_profilemap, "onlyblanking", ini_read_real(t_projectorstring, "onlyblanking", false));
            ds_map_add(t_profilemap, "invert_y", ini_read_real(t_projectorstring, "invert_y", false));
            ds_map_add(t_profilemap, "invert_x", ini_read_real(t_projectorstring, "invert_x", false));
            ds_map_add(t_profilemap, "red_scale", ini_read_real(t_projectorstring, "red_scale", 1));
            ds_map_add(t_profilemap, "green_scale", ini_read_real(t_projectorstring, "green_scale", 1));
            ds_map_add(t_profilemap, "blue_scale", ini_read_real(t_projectorstring, "blue_scale", 1));
            ds_map_add(t_profilemap, "red_scale_lower", ini_read_real(t_projectorstring, "red_scale_lower", 0));
            ds_map_add(t_profilemap, "green_scale_lower", ini_read_real(t_projectorstring, "green_scale_lower", 0));
            ds_map_add(t_profilemap, "blue_scale_lower", ini_read_real(t_projectorstring, "blue_scale_lower", 0));
            ds_map_add(t_profilemap, "scale_top_left", ini_read_real(t_projectorstring, "scale_top_left", 0));
			ds_map_add(t_profilemap, "scale_top_right", ini_read_real(t_projectorstring, "scale_top_right", 0));
			ds_map_add(t_profilemap, "scale_bottom_left", ini_read_real(t_projectorstring, "scale_bottom_left", $ffff));
			ds_map_add(t_profilemap, "scale_bottom_right", ini_read_real(t_projectorstring, "scale_bottom_right", $ffff));
			ds_map_add(t_profilemap, "scale_left_top", ini_read_real(t_projectorstring, "scale_left_top", 0));
			ds_map_add(t_profilemap, "scale_left_bottom", ini_read_real(t_projectorstring, "scale_left_bottom", 0));
			ds_map_add(t_profilemap, "scale_right_top", ini_read_real(t_projectorstring, "scale_right_top", $ffff));
			ds_map_add(t_profilemap, "scale_right_bottom", ini_read_real(t_projectorstring, "scale_right_bottom", $ffff));
			ds_map_add(t_profilemap, "ttlpalette", ini_read_real(t_projectorstring, "ttlpalette", 0));
            ds_map_add(t_profilemap, "blindzones", ini_read_string(t_projectorstring, "blindzones", emptyliststring));
            ds_list_add(profile_list,t_profilemap);
            
            num++;
        }
        
        if (ini_read_real("main", "projector", 0) > num)
            projector = 0;
            
        show_tooltip = ini_read_real("main", "show_tooltip", 1);
		
		/*if (!ini_read_real("main", "window_width", 0))
		{
			window_maximize(window_handle());
		}
		else
		{
			window_set_size(ini_read_real("main", "window_width", window_get_width()),
							ini_read_real("main", "window_height", window_get_height()));
			window_set_position(ini_read_real("main", "window_x", window_get_x()),
								ini_read_real("main", "window_y", window_get_y()));
		}
		controller.forceresize = true;*/
        
    ini_close();
}

load_profile();
