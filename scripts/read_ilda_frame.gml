//reads the data points of the current frame in the ilda file

repeat(ds_list_find_value(frame_list_parse,0))
    {
    repeat (2)//32
        {
        ds_list_add(frame_list_parse,get_bytes_signed()); 
        i+=(2+(format == 4));
        }
    blank = ((get_byte() & $40) > 0);
    ds_list_add(frame_list_parse,blank);
    i++;
    repeat (3)//34/5
        {
        ds_list_add(frame_list_parse,get_byte());
        i++;
        }
    }
ds_list_add(ild_list,frame_list_parse);
