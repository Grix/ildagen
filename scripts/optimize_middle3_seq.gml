for (m = 0;m < 3;m++)
    {
    var t_xp = $8000;
    var t_yp = $8000;
    
    t_xp -= $8000;
    t_yp -= $8000;
    xpa[0] = t_xp & 255;
    t_xp = t_xp >> 8;
    xpa[1] = t_xp & 255;
    ypa[0] = t_yp & 255;
    t_yp = t_yp >> 8;
    ypa[1] = t_yp & 255;
    
    //writing point
    buffer_write(ilda_buffer,buffer_u8,xpa[1]);
    buffer_write(ilda_buffer,buffer_u8,xpa[0]);
    buffer_write(ilda_buffer,buffer_u8,ypa[1]);
    buffer_write(ilda_buffer,buffer_u8,ypa[0]);
    if (exp_format == 5)
        {
        buffer_write(ilda_buffer,buffer_u8,$40);
        buffer_write(ilda_buffer,buffer_u8,0);
        buffer_write(ilda_buffer,buffer_u8,0);
        buffer_write(ilda_buffer,buffer_u8,0);
        }
    else
        {
        buffer_write(ilda_buffer,buffer_u16,0);
        buffer_write(ilda_buffer,buffer_u8,$40);
        buffer_write(ilda_buffer,buffer_u8,0);
        }
    maxpoints++;
    }
