maxpoints = 0;
var t_diff, t_pal_c, t_c_mapvalue;

for (i = 0; i < ds_list_size(list_raw); i += 4)
    {
    //writing point
    xp = list_raw[| i];
    yp = list_raw[| i+1];
    bl = list_raw[| i+2];
    
    xp -= $8000;
    yp -= $8000;
    xpa[0] = xp & 255;
    xp = xp >> 8;
    xpa[1] = xp & 255;
    ypa[0] = yp & 255;
    yp = yp >> 8;
    ypa[1] = yp & 255;
    buffer_write(ilda_buffer,buffer_u8,xpa[1]);
    buffer_write(ilda_buffer,buffer_u8,xpa[0]);
    buffer_write(ilda_buffer,buffer_u8,ypa[1]);
    buffer_write(ilda_buffer,buffer_u8,ypa[0]);
    
    if (bl)
        {
        blank = $40;
        if (i == ds_list_size(list_raw)-4)
            blank = $C0;
        }
    else
        {
        blank = $0;
        if (i == ds_list_size(list_raw)-4)
            blank = $80;
        }
    
    c = list_raw[| i+3];
    
    if (controller.exp_format == 5)
        {
        buffer_write(ilda_buffer,buffer_u8,blank);
        buffer_write(ilda_buffer,buffer_u8,colour_get_blue(c));
        buffer_write(ilda_buffer,buffer_u8,colour_get_green(c));
        buffer_write(ilda_buffer,buffer_u8,colour_get_red(c));
        }
    else
        {
        //find closest palette color
        if (controller.exp_format == 0)
            {
            t_c_mapvalue = c_map[? c];
            if (!is_undefined(t_c_mapvalue))
                c = t_c_mapvalue;
            else
                {
                diff_best = 200;
                for (n = 0; n < round(ds_list_size(controller.pal_list)/3); n++)
                    {
                    t_pal_c = make_colour_rgb(controller.pal_list[| n*3], controller.pal_list[| n*3+1], controller.pal_list[| n*3+2]);
                    t_diff = colors_compare_cie94(c, t_pal_c);
                    if (t_diff < 3)
                        {
                        c_n = n;
                        break;
                        }
                    else if (t_diff < diff_best)
                        {
                        c_n = n;
                        diff_best = t_diff;
                        }
                    }
                c_map[? c] = c_n;
                c = c_n;
                }
            }
        buffer_write(ilda_buffer,buffer_u16,0);
        buffer_write(ilda_buffer,buffer_u8,blank);
        buffer_write(ilda_buffer,buffer_u8,c);
        }
    maxpoints++;
    }
