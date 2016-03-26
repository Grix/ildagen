output_buffer_next_size = ds_list_size(list_raw)/4;
var t_list_raw_size = ds_list_size(list_raw)-4;

if (dac[| 1] == 0)
    {
        //riya, 12bit
        pos_scale = $FFF/$FFFF;
    }
else
    {
        pos_scale = 1;
    }

for (i = 0; i <= t_list_raw_size; i += 4)
    {
    //writing point
    xp = list_raw[| i];
    yp = list_raw[| i+1];
    bl = list_raw[| i+2];
    c = list_raw[| i+3];
    
    buffer_write(output_buffer_next,buffer_u16,xp*pos_scale);   //x
    buffer_write(output_buffer_next,buffer_u16,yp*pos_scale);   //y
    buffer_write(output_buffer_next,buffer_u8,c & $FF);         //red
    buffer_write(output_buffer_next,buffer_u8,(c >> 8) & $FF);  //green
    buffer_write(output_buffer_next,buffer_u8,c >> 16);         //blue
    //intensity
    if (bl)
        buffer_write(output_buffer_next,buffer_u8,0); 
    else
        buffer_write(output_buffer_next,buffer_u8,255);
    }
    
ds_list_destroy(list_raw);
ds_list_destroy(list_points);
