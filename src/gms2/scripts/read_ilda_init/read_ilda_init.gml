function read_ilda_init(argument0) {
	//initializes parsing of an ilda file
	//arg0 is scanner number
	//return 1 if successful
	
	filename = argument0;
	if (string_length(filename))
	{
		//file_copy(filename, "temp/temp.ild");
		ild_file = buffer_load(filename);
		if (ild_file == -1)
		{
			show_message_new("Could not open file");
			return 0;
		}
		
		if (buffer_get_size(ild_file) < 8)
		{
			show_message_new("File is too small, is this a valid ILDA file?");
			return 0;
		}
	
	    file_size = buffer_get_size(ild_file);
	}
	else
	    return 0;
    
	i = 0;
	if !is_wrong($49)
	    return 0;i++;
	if !is_wrong($4C)
	    return 0;i++; 
	if !is_wrong($44) 
	    return 0;i++;
	if !is_wrong($41) 
	    return 0;i++;
	if !is_wrong($0)
	    return 0;i++;
	if !is_wrong($0)
	    return 0;i++;
	if !is_wrong($0)
	    return 0;i=0;

	warning_suppress = false;
	//filename = "";

	i = 0;
	format = 0;
    
	ild_list = ds_list_create_pool();

	do
	{
	    if (read_ilda_header_first()) 
	        return 0;
	}
	until (format != 2)

	read_ilda_frame();

	return 1;



}
