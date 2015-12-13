optimize_middle3();
    
list_id = ds_list_find_value(el_list,0);
xo = ds_list_find_value(list_id,0);
yo = ds_list_find_value(list_id,1);
xpe = xo+ds_list_find_value(list_id,20);
ype = $ffff-(yo+ds_list_find_value(list_id,21));

c = ds_list_find_value(list_id,23);
//find closest palette color
if (controller.exp_format == 0)
    {
    var t_c_mapvalue = c_map[? c];
    if (!is_undefined(t_c_mapvalue))
        c = t_c_mapvalue;
    else
        {
        diff_best = 200;
        var t_diff;
        var t_pal_c;
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
blank = ds_list_find_value(list_id,22);
if (blank)
    {
    bl = $40;
    }
else
    {
    bl = 0;
    }

opt_dist = point_distance($ffff/2,$ffff/2,xpe,ype);
opt_vectorx = ($ffff/2-xpe)/opt_dist;
opt_vectory = ($ffff/2-ype)/opt_dist;

trav = -controller.opt_maxdist;    
for (trav_dist = trav/2;trav_dist >= -opt_dist; trav_dist += trav;)
    {
    xp = $ffff/2+opt_vectorx*trav_dist;
    yp = $ffff/2+opt_vectory*trav_dist;
    
    if ((yp > (512*128)) or (yp < 0) or (xp > (512*128)) or (xp < 0))
        {
        continue;
        }
    
    xp -= $8000;
    yp -= $8000;
    xpa[0] = xp & 255;
    xp = xp >> 8;
    xpa[1] = xp & 255;
    ypa[0] = yp & 255;
    yp = yp >> 8;
    ypa[1] = yp & 255;

    
    //writing point
    buffer_write(ilda_buffer,buffer_u8,xpa[1]);
    buffer_write(ilda_buffer,buffer_u8,xpa[0]);
    buffer_write(ilda_buffer,buffer_u8,ypa[1]);
    buffer_write(ilda_buffer,buffer_u8,ypa[0]);
    if (controller.exp_format == 5)
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
    
xp = xpe;
yp = ype;

xp -= $8000;
yp -= $8000;
xpa[0] = xp & 255;
xp = xp >> 8;
xpa[1] = xp & 255;
ypa[0] = yp & 255;
yp = yp >> 8;
ypa[1] = yp & 255;
//writing point
buffer_write(ilda_buffer,buffer_u8,xpa[1]);
buffer_write(ilda_buffer,buffer_u8,xpa[0]);
buffer_write(ilda_buffer,buffer_u8,ypa[1]);
buffer_write(ilda_buffer,buffer_u8,ypa[0]);
if (controller.exp_format == 5)
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
for (m = 0;m < controller.opt_maxdwell-1;m++)
    {
    buffer_write(ilda_buffer,buffer_u8,xpa[1]);
    buffer_write(ilda_buffer,buffer_u8,xpa[0]);
    buffer_write(ilda_buffer,buffer_u8,ypa[1]);
    buffer_write(ilda_buffer,buffer_u8,ypa[0]);
    if (controller.exp_format == 5)
        {
        buffer_write(ilda_buffer,buffer_u8,bl);
        buffer_write(ilda_buffer,buffer_u8,colour_get_blue(c));
        buffer_write(ilda_buffer,buffer_u8,colour_get_green(c));
        buffer_write(ilda_buffer,buffer_u8,colour_get_red(c));
        }
    else
        {
        buffer_write(ilda_buffer,buffer_u16,0);
        buffer_write(ilda_buffer,buffer_u8,bl);
        buffer_write(ilda_buffer,buffer_u8,c);
        }
    maxpoints++;
    }
