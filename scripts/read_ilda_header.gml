//reads the header of the ilda frame, returns 1 if error

if (i >= file_size)
    return 1;
    
if !is_wrong($49) return 1;
i += 7; //7
byte = get_byte();
if (byte == 4 or byte == 5 or byte == 1 or byte == 0) 
{ 
    format = byte; 
}
else if (byte == 2)
{
    //palette
    format = 2;
    i+=17; //24
    bytes = get_bytes();
    i+=8;
    repeat(bytes)
        i+=3;
    show_message_new("Custom palette detected but parsing of such is not supported yet, using default palette instead.");
    return 0;
}
else 
{
    show_message_new("We don't support this format yet, try converting to ILDA format 0, 1, 4 or 5."); 
    format=5; 
    errorflag=1; 
    return 1;
}
i += 17;

//24
if (get_bytes() != 0)
{
    frame_list_parse = ds_list_create();
    maxpoints = get_bytes();
}
else
{
    if (i >= file_size-32)// or (frame_number >= maxframes_parse)
    {
        return 1;
    }
    else 
    {
        frame_list_parse = ds_list_create();
        maxpoints = get_bytes();
    }
}
    
i+=2;//26
frame_number = get_bytes();
i+=6;//32

repeat (9) ds_list_add(frame_list_parse,0); 
ds_list_add(frame_list_parse,el_id); //id
ds_list_add(frame_list_parse,0); 
ds_list_add(frame_list_parse,1); //force polarity
repeat (8) ds_list_add(frame_list_parse,0); 
    
return 0;
