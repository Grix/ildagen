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
    ini_write_real(t_projectorstring, "format", exp_format);
    ini_write_real(t_projectorstring, "optimize", exp_optimize);
    ini_write_real(t_projectorstring, "invert_y", invert_y);
    ini_write_real(t_projectorstring, "invert_x", invert_x);
    ini_write_real(t_projectorstring, "red_scale", red_scale);
    ini_write_real(t_projectorstring, "green_scale", green_scale);
    ini_write_real(t_projectorstring, "blue_scale", blue_scale);
    
    if (room == rm_options)
        {
        obj_preset.preset_name = ini_read_string(t_projectorstring,"name","name_error");
        }
    
    ini_close();
    }
