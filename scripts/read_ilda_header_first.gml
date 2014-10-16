
    if !is_wrong($49) return 0;
i++;
    if !is_wrong($4C) return 0;
i += 6; //7
    byte = get_byte();
    if (byte == 4 or byte == 5) { format = byte; }
    else {show_message("We don't support this ILDA format yet, try converting to format 4 or 5"); format=5; errorflag=1; return 0;}
    if (byte == 0 and (file_size-(i)) > 50) needpal = 1;
    i+=17;
/*repeat(8) //8
    {
    name+= chr(get_byte());
    i++
    }
repeat(8) //16
    {
    author+= chr(get_byte());
    i++
    }*/
bytes = get_bytes(); //24
if (bytes != 0)
    {
    frame_list_parse = ds_list_create();
    maxpoints = bytes
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

ds_list_add(frame_list_parse,0);
ds_list_add(frame_list_parse,0);
ds_list_add(frame_list_parse,0);
ds_list_add(frame_list_parse,0);
ds_list_add(frame_list_parse,0);
ds_list_add(frame_list_parse,0);
ds_list_add(frame_list_parse,0);
ds_list_add(frame_list_parse,0);
ds_list_add(frame_list_parse,0); 
ds_list_add(frame_list_parse,el_id); //id

    
return 0;
