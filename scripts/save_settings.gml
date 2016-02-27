with (controller)
    {
    ini_open("settings.ini");
    ini_write_real("main","projector",projector);
    var t_projectorstring = "projector_"+string(projector);
    
    ini_write_real(t_projectorstring, "scanrate", opt_scanspeed);
    ini_write_real(t_projectorstring, "maxdist", opt_maxdist);
    ini_write_real(t_projectorstring, "maxdwell", opt_maxdwell);
    ini_write_real(t_projectorstring, "format", exp_format);
    ini_write_real(t_projectorstring, "optimize", exp_optimize);
    
    if (room == rm_options)
        {
        obj_preset.preset_name = ini_read_string(t_projectorstring,"name","name_error");
        }
    
    ini_close();
    }
