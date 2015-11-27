exit;
//todo fix maybe? sandboxed so doesn't work
if (is_undefined(parameter_string(1))) exit;
temp = 0;
for (i = 1; i <= parameter_count(); i++)
    {
    if (i == temp) exit;
    else
        temp = i;
        
    parameter = parameter_string(i);
    
    if (is_undefined(parameter) or !is_string(parameter) /*or !FS_file_exists(parameter)*/)
        continue;
        
    if (filename_ext(parameter) == ".igf")
        {
        load_frames(parameter);
        exit;
        }
    else if (filename_ext(parameter) == ".igp")
        {
        load_project(parameter);
        exit;
        }
    else if (filename_ext(parameter) == ".ild")
        {
        import_ilda(parameter);
        }
    }
