projector = argument0;
ini_open("settings.ini");
    var t_projectorstring = "projector_"+string(projector);
    if (ini_section_exists(t_projectorstring))
        {
        projector_name = ini_read_string(t_projectorstring, "name", "name_error");
        opt_scanspeed = ini_read_real(t_projectorstring, "scanrate", 20000);
        opt_maxdwell = ini_read_real(t_projectorstring, "maxdwell", 4);
        opt_maxdist = ini_read_real(t_projectorstring, "maxdist", 1500);
        }
    else
        show_message_async("Can't load settings, please contact developer. "+string(t_projectorstring));
ini_close();
