if (is_undefined(parameter_string(1))) exit;
temp = 0;
fastload = 0;
for (i = 1; i <= parameter_count(); i++)
    {
    if (i == temp) exit;
    else
        temp = i;
        
    parameter = parameter_string(i);
    
    if (!file_exists(parameter) or is_undefined(parameter))
        continue;
        
    if (filename_ext(parameter) == ".igf")
        {
        load_frames(parameter);
        }
    else if (filename_ext(parameter) == ".ild")
        {
        import_ilda(parameter);
        }
    }
    
fastload = 1;
