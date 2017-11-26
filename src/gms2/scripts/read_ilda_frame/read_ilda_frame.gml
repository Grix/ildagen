//reads the data points of the current frame in the ilda file

xmax = 0;
xmin = $ffff;
ymax = 0;
ymin = $ffff;
//blankprev = 1;
    
if (format > 2)
{
    repeat(maxpoints)
    {
        //x
        byte0 = get_byte();
        byte1 = buffer_peek(ild_file, i+1, buffer_u8);
        bytes = ((byte0 << 8) + byte1)-1;
        if (bytes >= $7FFF)
            bytes -= $7FFF;
        else
            bytes += $7FFF;
        ds_list_add(frame_list_parse, bytes); 
            
        //max and min
        if (bytes > xmax)
            xmax = bytes;
        if (bytes < xmin)
            xmin = bytes;
            
        i+=(2);
        //y
        byte0 = get_byte();
        byte1 = buffer_peek(ild_file, i+1, buffer_u8);
        bytes = ((byte0 << 8) + byte1)-1;
        if (bytes >= $7FFF)
            bytes -= $7FFF;
        else
            bytes += $7FFF;
        bytes = $ffff-bytes;
        ds_list_add(frame_list_parse, bytes); 
        
        if (bytes> ymax)
            ymax = bytes;
        if (bytes < ymin)
            ymin = bytes;
            
        i+=(2+(format == 4)*2);
        
        //blank
        blank = ((get_byte() & $40) > 0);
        /*if (blank && blankprev)
        {
            
        }*/
        ds_list_add(frame_list_parse,blank);
        i++;
        //rgb//34/5
        cb = get_byte(); i++;
        cg = get_byte(); i++;
        cr = get_byte(); i++;
        ds_list_add(frame_list_parse,make_colour_rgb(cr,cg,cb));
    }
}
else
{
    repeat(maxpoints)
    {
        //x
        byte0 = get_byte();
        byte1 = buffer_peek(ild_file, i+1, buffer_u8);
        bytes = ((byte0 << 8) + byte1)-1;
        if (bytes >= $7FFF)
            bytes -= $7FFF;
        else
            bytes += $7FFF;
        ds_list_add(frame_list_parse, bytes); 
        i+=(2);
        
        //max and min
        if (bytes > xmax)
            xmax = bytes;
        if (bytes < xmin)
            xmin = bytes;
            
            
        //y
        byte0 = get_byte();
        byte1 = buffer_peek(ild_file, i+1, buffer_u8);
        bytes = ((byte0 << 8) + byte1)-1;
        if (bytes >= $7FFF)
            bytes -= $7FFF;
        else
            bytes += $7FFF;
        bytes = $ffff-bytes;
        ds_list_add(frame_list_parse, bytes); 
        i+=(2+(format == 0)*2);
        
        if (bytes > ymax)
            ymax = bytes;
        if (bytes < ymin)
            ymin = bytes;
        
        //blank
        blank = ((get_byte() & $40) > 0);
        i++;
        
        //color lookup
        color = get_byte();
        i++;
        
        //rgb
        if (3*color+3 > ds_list_size(pal_list)) or (color < 0)
        {
            if (color == 64)
                color_res = 0;
            else
                color_res = c_white;
        }
        else
            color_res = make_colour_rgb(ds_list_find_value(pal_list,3*color),
                                        ds_list_find_value(pal_list,3*color+1),
                                        ds_list_find_value(pal_list,3*color+2));
        if (color_res == 0)
        {
            blank = 1;
        }
            
        ds_list_add(frame_list_parse,blank);
        
        ds_list_add(frame_list_parse,color_res);
    }
}
    

ds_list_replace(frame_list_parse,2,ds_list_find_value(frame_list_parse,ds_list_size(frame_list_parse)-6));
ds_list_replace(frame_list_parse,3,ds_list_find_value(frame_list_parse,ds_list_size(frame_list_parse)-5));

ds_list_replace(frame_list_parse,4,xmin);
ds_list_replace(frame_list_parse,5,xmax);
ds_list_replace(frame_list_parse,6,ymin);
ds_list_replace(frame_list_parse,7,ymax);

ds_list_add(ild_list,frame_list_parse);

