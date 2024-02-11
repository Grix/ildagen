function read_ilda_header_first() {
	if !is_wrong($49) return 1;
	i++;
	if !is_wrong($4C) return 1;
	i += 6; //7
	byte = get_byte();
	if (byte == 4 or byte == 5 or byte == 1 or byte == 0) { format = byte; }
	else if (byte == 2)
	{
	    //palette
	    format = 2;
	    i+=17; //24
	    bytes = get_bytes();
	    i+=8;
	    repeat(bytes)
	        i+=3;
	    if (!warning_suppress)
			show_message_new("Custom palette detected but parsing of such is not supported yet, using default palette instead.");
	    warning_suppress = true;
	    return 0;
	}
	else 
	{
		if (!warning_suppress)
			show_message_new("We don't support this format yet, try converting to ILDA format 0, 1, 4 or 5."); 
	    warning_suppress = true;
		format=5; 
	    errorflag=1; 
	    return 1;
	}
	
	var t_framename = chr(buffer_peek(ild_file, i+1, buffer_u8)) +
						chr(buffer_peek(ild_file, i+2, buffer_u8)) +
						chr(buffer_peek(ild_file, i+3, buffer_u8)) +
						chr(buffer_peek(ild_file, i+4, buffer_u8)) +
						chr(buffer_peek(ild_file, i+5, buffer_u8)) +
						chr(buffer_peek(ild_file, i+6, buffer_u8)) +
						chr(buffer_peek(ild_file, i+7, buffer_u8)) +
						chr(buffer_peek(ild_file, i+8, buffer_u8));
	
	
	i+=17;
	/*
	repeat(8) //16
	    {
	    author+= chr(get_byte());
	    i++
	    }*/

	bytes = get_bytes(); //24
	if (bytes != 0)
	{
	    frame_list_parse = ds_list_create_pool();
	    maxpoints = bytes;
	}
	else
	    return 1;
    
	i+=2;
	//26
	frame_number = get_bytes();
	i+=2;
	//28
	maxframes_parse = get_bytes();
	i+=2; //30

	ilda_scanner = get_byte();
	i+=2;



	repeat (8) 
		ds_list_add(frame_list_parse,	0); 
	try
	{
		t_framename = real("0x"+string_lettersdigits(t_framename));
		ds_list_add(frame_list_parse,	t_framename);
	}
	catch(t_ex)
	{
		ds_list_add(frame_list_parse,	0); 
	}
	ds_list_add(frame_list_parse,		el_id); //id
	ds_list_add(frame_list_parse,		0); 
	ds_list_add(frame_list_parse,		1); //force polarity
	repeat (8) 
		ds_list_add(frame_list_parse,	0); 

    
	return 0;



}
