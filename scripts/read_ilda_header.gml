//reads the header of the ilda frame, returns 1 if error

if !is_wrong($49) return 1;
i += 24;

//24
if (get_bytes() != 0)
    {
    frame_list_parse = ds_list_create();
    maxpoints = get_bytes();
    }
else
    {
    if (i >= file_size-32) or (frame_number >= maxframes_parse)
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
repeat (10) ds_list_add(frame_list_parse,0);
    
return 0;
