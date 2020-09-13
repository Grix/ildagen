function parse_parameter() {
	if (is_undefined(parameter_string(1))) exit;
	temp = 0;
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
	        load_frames(t_parameter);
	        exit;
	    }
	    else if (filename_ext(t_parameter) == ".igp")
	    {
			with (seqcontrol)
				load_project(t_parameter);
	        exit;
	    }
		else if (filename_ext(t_parameter) == ".igl")
	    {
			with (livecontrol)
				load_live_project(t_parameter);
	        exit;
	    }
	    else if (filename_ext(t_parameter) == ".ild")
	    {
	        import_ilda(t_parameter);
	    }
	}



}
