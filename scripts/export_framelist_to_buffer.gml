maxpoints = ds_list_size(list_raw)/4;
var t_diff, t_pal_c, t_c_mapvalue;
var t_list_raw_size = ds_list_size(list_raw)-4;

var t_red_lowerbound = round(controller.red_scale_lower*255);
var t_green_lowerbound = round(controller.green_scale_lower*255);
var t_blue_lowerbound = round(controller.blue_scale_lower*255);
var t_red_scale = controller.red_scale*(255-t_red_lowerbound)/255;
var t_green_scale = controller.green_scale*(255-t_green_lowerbound)/255;
var t_blue_scale = controller.blue_scale*(255-t_blue_lowerbound)/255;

if (controller.exp_optimize)
{
    var t_blankshift = controller.opt_blankshift*4;
    var t_redshift = controller.opt_redshift*4;
    var t_greenshift = controller.opt_greenshift*4;
    var t_blueshift = controller.opt_blueshift*4;
    
    safe_bottom_boundary = abs(min(controller.opt_redshift,controller.opt_greenshift,controller.opt_blueshift,controller.opt_blankshift))*4;
    safe_top_boundary = t_list_raw_size-max(controller.opt_redshift,controller.opt_greenshift,controller.opt_blueshift,controller.opt_blankshift)*4;
}
var t_bl;

if (controller.exp_optimize)
{
    for (i = 0; i <= t_list_raw_size; i += 4)
    {
        //writing point
        if (controller.invert_x)
            xp = t_x_lowerbound+($FFFF - list_raw[| i])*t_x_scale;
        else
            xp = t_x_lowerbound+(list_raw[| i])*t_x_scale;
            
        if (controller.invert_y)
            yp = t_y_lowerbound+($FFFF - list_raw[| i+1])*t_y_scale;
        else
            yp = t_y_lowerbound+(list_raw[| i+1])*t_y_scale;
            
        if ((i < safe_bottom_boundary) || (i > safe_top_boundary))
        {
            cr = 0;
            cg = 0;
            cb = 0;
            bl = 1;
        }    
        else
        {
            cr = t_red_lowerbound + (list_raw[| i+t_redshift+3] & $FF) * t_red_scale;
            cg = t_green_lowerbound + ((list_raw[| i+t_greenshift+3] >> 8) & $FF) * t_green_scale;
            cb = t_blue_lowerbound + (list_raw[| i+t_blueshift+3] >> 16) * t_blue_scale;
            bl = list_raw[| i+t_blankshift+2]
        }
        
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
            if (i == t_list_raw_size)
                blank = $C0;
            else
                blank = $40;
        }
        else
        {
            if (i == t_list_raw_size)
                blank = $80;
            else
                blank = $0;
        }
            
        if (controller.exp_format == 5)
        {
            buffer_write(ilda_buffer,buffer_u8,blank);
            buffer_write(ilda_buffer,buffer_u8,cb);
            buffer_write(ilda_buffer,buffer_u8,cg);
            buffer_write(ilda_buffer,buffer_u8,cr);
        }
        else
        {
            //find closest palette color
            if (bl)
                c = 63;
            else
            {
                c = make_colour_rgb(cr,cg,cb);
                if (ds_map_exists(c_map, c))
                    c = c_map[? c];
                else
                {
                    diff_best = 200;
                    for (n = 0; n < round(ds_list_size(controller.pal_list)/3); n++)
                    {
                        t_pal_c = make_colour_rgb(controller.pal_list[| n*3], controller.pal_list[| n*3+1], controller.pal_list[| n*3+2]);
                        t_diff = colors_compare_cie94(c, t_pal_c);
                        if (t_diff < diff_best)
                        {
                            c_n = n;
                            if (t_diff == 0)
                                break;
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
    }
}
else //not optimized
{
    for (i = 0; i <= t_list_raw_size; i += 4)
    {
        //writing point
        if (controller.invert_x)
            xp = t_x_lowerbound+($FFFF - list_raw[| i])*t_x_scale;
        else
            xp = t_x_lowerbound+(list_raw[| i])*t_x_scale;
        if (controller.invert_y)
            yp = t_y_lowerbound+($FFFF - list_raw[| i+1])*t_y_scale;
        else
            yp = t_y_lowerbound+(list_raw[| i+1])*t_y_scale;
            
        t_bl = list_raw[| i+2];
        if (is_undefined(t_bl))
        {
            c = 0;
            bl = 0;
        }
        else
        {
            c = list_raw[| i+3];
            bl = t_bl;
        }
        
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
            if (i == t_list_raw_size)
                blank = $C0;
            else
                blank = $40;
        }
        else
        {
            if (i == t_list_raw_size)
                blank = $80;
            else
                blank = $0;
        }
            
        if (controller.exp_format == 5)
        {
            buffer_write(ilda_buffer,buffer_u8,blank);
            buffer_write(ilda_buffer,buffer_u8,t_red_lowerbound + (c & $FF) * t_red_scale);
            buffer_write(ilda_buffer,buffer_u8,t_green_lowerbound + ((c >> 8) & $FF) * t_green_scale);
            buffer_write(ilda_buffer,buffer_u8,t_blue_lowerbound + (c >> 16) * t_blue_scale);
        }
        else
        {
            //find closest palette color
            if (bl)
                c = 63;
            else
            {
                cr = t_red_lowerbound + (c & $FF) * t_red_scale;
                cg = t_green_lowerbound + ((c >> 8) & $FF) * t_green_scale;
                cb = t_blue_lowerbound + (c >> 16) * t_blue_scale;
                c = make_colour_rgb(cr,cg,cb);
                if (ds_map_exists(c_map, c))
                    c = c_map[? c];
                else
                {
                    diff_best = 200;
                    for (n = 0; n < round(ds_list_size(controller.pal_list)/3); n++)
                    {
                        t_pal_c = make_colour_rgb(controller.pal_list[| n*3], controller.pal_list[| n*3+1], controller.pal_list[| n*3+2]);
                        t_diff = colors_compare_cie94(c, t_pal_c);
                        if (t_diff < diff_best)
                        {
                            c_n = n;
                            if (t_diff == 0)
                                break;
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
    }
}
    
ds_list_destroy(list_raw);

