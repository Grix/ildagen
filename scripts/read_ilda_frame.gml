//reads the data points of the current frame in the ilda file

if (format > 2)
    {
    repeat(maxpoints)
        {
        //x
        bytes = get_bytes_signed();
        if (bytes >= $7FFF)
            bytes -= $7FFF;
        else
            bytes += $7FFF;
        ds_list_add(frame_list_parse,bytes); 
        i+=(2);
        //y
        bytes = get_bytes_signed();
        if (bytes >= $7FFF)
            bytes -= $7FFF;
        else
            bytes += $7FFF;
        bytes = $ffff-bytes;
        ds_list_add(frame_list_parse,bytes); 
        i+=(2+(format == 4)*2);
        
        //blank
        blank = ((get_byte() & $40) > 0);
        ds_list_add(frame_list_parse,blank);
        i++;
        //rgb
        repeat (3)//34/5
            {
            ds_list_add(frame_list_parse,get_byte());
            i++;
            }
        }
    }
else
    {
    repeat(maxpoints)
        {
        //x
        bytes = get_bytes_signed();
        if (bytes >= $7FFF)
            bytes -= $7FFF;
        else
            bytes += $7FFF;
        ds_list_add(frame_list_parse,bytes); 
        i+=(2);
        //y
        bytes = get_bytes_signed();
        if (bytes >= $7FFF)
            bytes -= $7FFF;
        else
            bytes += $7FFF;
        bytes = $ffff-bytes;
        ds_list_add(frame_list_parse,bytes); 
        i+=(2+(format == 0)*2);
        
        //blank
        blank = ((get_byte() & $40) > 0);
        ds_list_add(frame_list_parse,blank);
        i++;
        
        //color lookup
        color = clamp(get_byte(),0,ds_list_size(pal_list));
        show_message(color)
        i++;
               
        //rgb
        ds_list_add(frame_list_parse,ds_list_find_value(pal_list,color));
        ds_list_add(frame_list_parse,ds_list_find_value(pal_list,color+1));
        ds_list_add(frame_list_parse,ds_list_find_value(pal_list,color+2));
        }
    }
    
ds_list_replace(frame_list_parse,2,ds_list_find_value(frame_list_parse,ds_list_size(frame_list_parse)-6));
ds_list_replace(frame_list_parse,3,ds_list_find_value(frame_list_parse,ds_list_size(frame_list_parse)-5));
ds_list_add(ild_list,frame_list_parse);
