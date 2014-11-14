//reads the data points of the current frame in the ilda file

xmax = 0;
xmin = $ffff;
ymax = 0;
ymin = $ffff;
    
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
            
        //max and min
        if (bytes/128 > xmax)
            xmax = bytes/128;
        if (bytes/128 < xmin)
            xmin = bytes/128;
            
        i+=(2);
        //y
        bytes = get_bytes_signed();
        if (bytes >= $7FFF)
            bytes -= $7FFF;
        else
            bytes += $7FFF;
        bytes = $ffff-bytes;
        ds_list_add(frame_list_parse,bytes); 
        
        if (bytes/128 > ymax)
            ymax = bytes/128;
        if (bytes/128 < ymin)
            ymin = bytes/128;
            
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
        
        //max and min
        if (bytes/128 > xmax)
            xmax = bytes/128;
        if (bytes/128 < xmin)
            xmin = bytes/128;
            
            
        //y
        bytes = get_bytes_signed();
        if (bytes >= $7FFF)
            bytes -= $7FFF;
        else
            bytes += $7FFF;
        bytes = $ffff-bytes;
        ds_list_add(frame_list_parse,bytes); 
        i+=(2+(format == 0)*2);
        
        if (bytes/128 > ymax)
            ymax = bytes/128;
        if (bytes/128 < ymin)
            ymin = bytes/128;
        
        //blank
        blank = ((get_byte() & $40) > 0);
        i++;
        
        //color lookup
        color = clamp(get_byte(),0,ds_list_size(pal_list)/3);
        i++;     
            
        if (color == 64)
            {
            blank = 1;
            }
            
        ds_list_add(frame_list_parse,blank);
        
        //rgb
        ds_list_add(frame_list_parse,ds_list_find_value(pal_list,3*color+2));
        ds_list_add(frame_list_parse,ds_list_find_value(pal_list,3*color+1));
        ds_list_add(frame_list_parse,ds_list_find_value(pal_list,3*color));
        
        }
    }
    
ds_list_replace(frame_list_parse,2,ds_list_find_value(frame_list_parse,ds_list_size(frame_list_parse)-6));
ds_list_replace(frame_list_parse,3,ds_list_find_value(frame_list_parse,ds_list_size(frame_list_parse)-5));

ds_list_replace(frame_list_parse,4,xmin);
ds_list_replace(frame_list_parse,5,xmax);
ds_list_replace(frame_list_parse,6,ymin);
ds_list_replace(frame_list_parse,7,ymax);

ds_list_add(ild_list,frame_list_parse);
