output_buffer_next_size = ds_list_size(list_raw)/4;
var t_diff, t_pal_c, t_c_mapvalue;
var t_list_raw_size = ds_list_size(list_raw)-4;

for (i = 0; i <= t_list_raw_size; i += 4)
    {
    //writing point
    xp = list_raw[| i];
    yp = list_raw[| i+1];
    bl = list_raw[| i+2];
    
    if (dac[| 1] == 0)
        {
            //riya, 12bit
            pos_scale = $FFF/$FFFF;
        }
    else
        {
            pos_scale = 1;
        }
    
    buffer_write(output_buffer_next,buffer_u16,xp*pos_scale);
    buffer_write(output_buffer_next,buffer_u16,yp*pos_scale);
    
    if (bl)
        intensity = 0;
    else
        intensity = 255;
    
    c = list_raw[| i+3];
    
    buffer_write(output_buffer_next,buffer_u8,colour_get_red(c));
    buffer_write(output_buffer_next,buffer_u8,colour_get_green(c));
    buffer_write(output_buffer_next,buffer_u8,colour_get_blue(c));
    buffer_write(output_buffer_next,buffer_u8,intensity);
    
    }
    
ds_list_destroy(list_raw);
ds_list_destroy(list_points);
