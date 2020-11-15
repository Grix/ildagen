function parse_parameter() {
	if (is_undefined(parameter_string(1))) exit;
	temp = 0;
	var t_showwarning = false;
	for (i = 1; i <= parameter_count(); i++)
	{
	    if (i == temp) exit;
	    else
	        temp = i;
        
	    var t_parameter = parameter_string(i);
    
	    if (is_undefined(t_parameter) or !is_string(t_parameter) )
	        continue;
			
	    if (filename_ext(t_parameter) == ".igf")
	    {
			t_showwarning = true;
			show_message_new("Warning: File was opened directly from the OS file browser, this can cause problems when saving new files. Please restart LaserShowGen and open your file using the menu buttons");
	        load_frames(t_parameter);
	        exit;
	    }
	    else if (filename_ext(t_parameter) == ".igp")
	    {
			t_showwarning = true;
			show_message_new("Warning: File was opened directly from the OS file browser, this can cause problems when saving new files. Please restart LaserShowGen and open your file using the menu buttons");
			with (seqcontrol)
				load_project(t_parameter);
	        exit;
	    }
		else if (filename_ext(t_parameter) == ".igl")
	    {
			t_showwarning = true;
			show_message_new("Warning: File was opened directly from the OS file browser, this can cause problems when saving new files. Please restart LaserShowGen and open your file using the menu buttons");
			with (livecontrol)
				load_live_project(t_parameter);
	        exit;
	    }
	    else if (filename_ext(t_parameter) == ".ild")
	    {
			t_showwarning = true;
	        import_ilda(t_parameter);
	    }
	}

	if (t_showwarning)
		show_message_new("Warning: File was opened directly from the OS file browser, this can cause problems when saving new files. Please restart LaserShowGen and open your file using the menu buttons");

}
