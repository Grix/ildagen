//reads the data points of the current frame in the ilda file

repeat(maxpoints)
    {
    repeat (2)//32
        {
        bytes = get_bytes_signed();
        if (bytes >= $7FFF)
            bytes -= $7FFF;
        else
            bytes += $7FFF;
        ds_list_add(frame_list_parse,bytes); 
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
