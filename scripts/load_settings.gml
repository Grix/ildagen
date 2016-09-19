ini_open("settings.ini");

    if (!ini_key_exists("main","projector"))
        {
        projector = 0;
        ini_write_real("projector_0", "scanrate", 20000);
        ini_write_real("projector_0", "maxdist", 500);
        ini_write_real("projector_0", "maxdwell", 6);
        ini_write_real("projector_0", "maxdwell_blank", 1);
        ini_write_real("projector_0", "blankshift", 0);
        ini_write_real("projector_0", "redshift", 0);
        ini_write_real("projector_0", "greenshift", 0);
        ini_write_real("projector_0", "blueshift", 0);
        ini_write_real("projector_0", "format", 5);
        ini_write_real("projector_0", "invert_x", false);
        ini_write_real("projector_0", "invert_y", false);
        ini_write_real("projector_0", "optimize", 1);
        ini_write_real("projector_0", "red_scale", 1);
        ini_write_real("projector_0", "green_scale", 1);
        ini_write_real("projector_0", "blue_scale", 1);
        ini_write_real("projector_0", "red_scale_lower", 0);
        ini_write_real("projector_0", "green_scale_lower", 0);
        ini_write_real("projector_0", "blue_scale_lower", 0);
        ini_write_real("projector_0", "show_tooltip", 1);
        opt_scanspeed = 20000;
        opt_maxdwell = 6;
        opt_maxdwell_blank = 1;
        opt_blankshift = 0;
        opt_redshift = 0;
        opt_greenshift = 0;
        opt_blueshift = 0;
        opt_maxdist = 500;
        exp_format = 5;
        exp_optimize = 1;
        invert_x = false;
        invert_y = false;
        red_scale = 1;
        green_scale = 1;
        blue_scale = 1;
        red_scale_lower = 0;
        green_scale_lower = 0;
        blue_scale_lower = 0;
        show_tooltip = 1;
        ini_write_string("projector_0","name","default");
        ini_write_real("main","projector",0);
        }
    else
        {
        projector = ini_read_real("main", "projector", 0);
        var t_projectorstring = "projector_"+string(projector);
        if (ini_section_exists(t_projectorstring))
            {
            projector_name = ini_read_string(t_projectorstring, "name", "name_error");
            opt_scanspeed = ini_read_real(t_projectorstring, "scanrate", 20000);
            opt_maxdwell = ini_read_real(t_projectorstring, "maxdwell", 4);
            opt_maxdwell_blank = ini_read_real(t_projectorstring, "maxdwell_blank", 1);
            opt_blankshift = ini_read_real(t_projectorstring, "blankshift", 0);
            opt_redshift = ini_read_real(t_projectorstring, "redshift", 0);
            opt_greenshift = ini_read_real(t_projectorstring, "greenshift", 0);
            opt_blueshift = ini_read_real(t_projectorstring, "blueshift", 0);
            opt_maxdist = ini_read_real(t_projectorstring, "maxdist", 1500);
            exp_format = ini_read_real(t_projectorstring, "format", 5);
            exp_optimize = ini_read_real(t_projectorstring, "optimize", 1);
            invert_y = ini_read_real(t_projectorstring, "invert_y", false);
            invert_x = ini_read_real(t_projectorstring, "invert_x", false);
            red_scale = ini_read_real(t_projectorstring, "red_scale", 1);
            green_scale = ini_read_real(t_projectorstring, "green_scale", 1);
            blue_scale = ini_read_real(t_projectorstring, "blue_scale", 1);
            red_scale_lower = ini_read_real(t_projectorstring, "red_scale_lower", 0);
            green_scale_lower = ini_read_real(t_projectorstring, "green_scale_lower", 0);
            blue_scale_lower = ini_read_real(t_projectorstring, "blue_scale_lower", 0);
            show_tooltip = ini_read_real(t_projectorstring, "show_tooltip", 1);
            }
        else
            {
            ini_write_string(t_projectorstring, "name", "name_error");
            ini_write_real(t_projectorstring, "scanrate", 20000);
            ini_write_real(t_projectorstring, "maxdist", 1500);
            ini_write_real(t_projectorstring, "maxdwell", 4);
            ini_write_real(t_projectorstring, "maxdwell_blank", 1);
            ini_write_real(t_projectorstring, "blankshift", 0);
            ini_write_real(t_projectorstring, "redshift", 0);
            ini_write_real(t_projectorstring, "greenshift", 0);
            ini_write_real(t_projectorstring, "blueshift", 0);
            ini_write_real(t_projectorstring, "format", 5);
            ini_write_real(t_projectorstring, "optimize", 1);
            ini_write_real(t_projectorstring, "invert_x", false);
            ini_write_real(t_projectorstring, "invert_y", false);
            ini_write_real(t_projectorstring, "red_scale", 1);
            ini_write_real(t_projectorstring, "green_scale", 1);
            ini_write_real(t_projectorstring, "blue_scale", 1);
            ini_write_real(t_projectorstring, "red_scale_lower", 0);
            ini_write_real(t_projectorstring, "green_scale_lower", 0);
            ini_write_real(t_projectorstring, "blue_scale_lower", 0);
            ini_write_real(t_projectorstring, "show_tooltip", 1);
            }
        }
        
    if (room == rm_options)
        {
        obj_preset.preset_name = ini_read_string("projector_"+string(projector),"name","name_error");
        }
        
ini_close();

update_colors_scalesettings();
