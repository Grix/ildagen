save_profile();

with (controller)
{
    ini_open("settings.ini");
    
        ini_write_real("main","projector",projector);
        ini_write_real("main","show_tooltip",show_tooltip);
        
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
            ini_write_real(t_projectorstring, "invert_y", t_profilemap[? "invert_y"]);
            ini_write_real(t_projectorstring, "invert_x", t_profilemap[? "invert_x"]);
            ini_write_real(t_projectorstring, "red_scale", t_profilemap[? "red_scale"]);
            ini_write_real(t_projectorstring, "green_scale", t_profilemap[? "green_scale"]);
            ini_write_real(t_projectorstring, "blue_scale", t_profilemap[? "blue_scale"]);
            ini_write_real(t_projectorstring, "red_scale_lower", t_profilemap[? "red_scale_lower"]);
            ini_write_real(t_projectorstring, "green_scale_lower", t_profilemap[? "green_scale_lower"]);
            ini_write_real(t_projectorstring, "blue_scale_lower", t_profilemap[? "blue_scale_lower"]);
            ini_write_real(t_projectorstring, "x_scale_start", t_profilemap[? "x_scale_start"]);
            ini_write_real(t_projectorstring, "y_scale_start", t_profilemap[? "y_scale_start"]);
            ini_write_real(t_projectorstring, "x_scale_end", t_profilemap[? "x_scale_end"]);
            ini_write_real(t_projectorstring, "y_scale_end", t_profilemap[? "y_scale_end"]);
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
