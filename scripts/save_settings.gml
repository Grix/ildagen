with (controller)
    {
    ini_open("settings.ini");
    ini_write_real("main","projector",projector);
    var t_projectorstring = "projector_"+string(projector);
    
    ini_write_real(t_projectorstring, "scanrate", opt_scanspeed);
    ini_write_real(t_projectorstring, "maxdist", opt_maxdist);
    ini_write_real(t_projectorstring, "maxdwell", opt_maxdwell);
    ini_write_real(t_projectorstring, "maxdwell_blank", opt_maxdwell_blank);
    ini_write_real(t_projectorstring, "blankshift", opt_blankshift);
    ini_write_real(t_projectorstring, "redshift", opt_redshift);
    ini_write_real(t_projectorstring, "greenshift", opt_greenshift);
    ini_write_real(t_projectorstring, "blueshift", opt_blueshift);
    ini_write_real(t_projectorstring, "format", exp_format);
    ini_write_real(t_projectorstring, "optimize", exp_optimize);
    ini_write_real(t_projectorstring, "invert_y", invert_y);
    ini_write_real(t_projectorstring, "invert_x", invert_x);
    ini_write_real(t_projectorstring, "red_scale", red_scale);
    ini_write_real(t_projectorstring, "green_scale", green_scale);
    ini_write_real(t_projectorstring, "blue_scale", blue_scale);
    ini_write_real(t_projectorstring, "red_scale_lower", red_scale_lower);
    ini_write_real(t_projectorstring, "green_scale_lower", green_scale_lower);
    ini_write_real(t_projectorstring, "blue_scale_lower", blue_scale_lower);
    ini_write_real(t_projectorstring, "show_tooltip", show_tooltip);
    ini_write_real(t_projectorstring, "x_scale_start", x_scale_start);
    ini_write_real(t_projectorstring, "y_scale_start", y_scale_start);
    ini_write_real(t_projectorstring, "x_scale_end", x_scale_end);
    ini_write_real(t_projectorstring, "y_scale_end", y_scale_end);
    ini_write_string(t_projectorstring, "blindzones", ds_list_write(blindzone_list));
    
    if (room == rm_options)
        {
        obj_preset.preset_name = ini_read_string(t_projectorstring,"name","name_error");
        }
    
    ini_close();
    }
