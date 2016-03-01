ini_open("settings.ini");

    if (!ini_key_exists("main","projector"))
        {
        projector = 0;
        ini_write_real("projector_0","scanrate",20000);
        ini_write_real("projector_0","maxdist",1500);
        ini_write_real("projector_0","maxdwell",4);
        ini_write_real("projector_0", "format", 5);
        ini_write_real("projector_0", "optimize", 1);
        opt_scanspeed = 20000;
        opt_maxdwell = 4;
        opt_maxdist = 1500;
        exp_format = 5;
        exp_optimize = 1;
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
            opt_maxdist = ini_read_real(t_projectorstring, "maxdist", 1500);
            exp_format = ini_read_real(t_projectorstring, "format", 5);
            exp_optimize = ini_read_real(t_projectorstring, "optimize", 1);
            }
        else
            {
            ini_write_string(t_projectorstring, "name", "name_error");
            ini_write_real(t_projectorstring, "scanrate", 20000);
            ini_write_real(t_projectorstring, "maxdist", 1500);
            ini_write_real(t_projectorstring, "maxdwell", 4);
            ini_write_real(t_projectorstring, "format", 5);
            ini_write_real(t_projectorstring, "optimize", 1);
            }
        }
        
if (room == rm_options)
    {
    obj_preset.preset_name = ini_read_string("projector_"+string(projector),"name","name_error");
    }
        
ini_close();
