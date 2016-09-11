///write_point_export(x,y,bl,c,EOF)
/*gml_pragma("forceinline");
var xp1, yp1, blank;

if (controller.invert_x)
    xp1 = $FFFF - argument0;
else
    xp1 = argument0;
if (controller.invert_y)
    yp1 = $FFFF - argument1;
else
    yp1 = argument1;
    
xp1 -= $8000;
yp1 -= $8000;
xpa[0] = xp1 & 255;
xp1 = xp1 >> 8;
xpa[1] = xp1 & 255;
ypa[0] = yp1 & 255;
yp1 = yp1 >> 8;
ypa[1] = yp1 & 255;

buffer_write(ilda_buffer,buffer_u8,xpa[1]);
buffer_write(ilda_buffer,buffer_u8,xpa[0]);
buffer_write(ilda_buffer,buffer_u8,ypa[1]);
buffer_write(ilda_buffer,buffer_u8,ypa[0]);

if (argument2)
{
    if (argument4)
        blank = $C0;
    else
        blank = $40;
}
else
{
    if (argument4)
        blank = $80;
    else
        blank = $0;
}

if (controller.exp_format == 5)
{
    if (!argument2)
    {
        cr = red_lowerbound + (argument3 & $FF) * red_scale;
        cg = green_lowerbound + ((argument3 >> 8) & $FF) * green_scale;
        cb = blue_lowerbound + (argument3 >> 16) * blue_scale;
    }
    else
    {
        cr = 0;
        cg = 0;
        cb = 0;
    }
    buffer_write(ilda_buffer,buffer_u8,blank);
    buffer_write(ilda_buffer,buffer_u8,cb);
    buffer_write(ilda_buffer,buffer_u8,cg);
    buffer_write(ilda_buffer,buffer_u8,cr);
}
else
{
    //find closest palette color
    if (argument2)
        c = 63;
    else
    {
        cr = red_lowerbound + (argument3 & $FF) * red_scale;
        cg = green_lowerbound + ((argument3 >> 8) & $FF) * green_scale;
        cb = blue_lowerbound + (argument3 >> 16) * blue_scale;
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
