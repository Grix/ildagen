output_buffer_next_size = ds_list_size(list_raw)/4;
var t_list_raw_size = ds_list_size(list_raw)-4;

if (controller.dac[| 1] == 0)
    {
        //riya, 12bit
        var t_pos_scale = $FFF/$FFFF;
        var t_fullrange = $FFF;
    }
else
    {
        var t_pos_scale = 1;
        var t_fullrange = $FFFF;
    }
    
var t_blankshift = controller.opt_blankshift*4;

for (i = 0; i <= t_list_raw_size; i += 4)
    {
    //writing point
    
    xp = list_raw[| i];
    yp = list_raw[| i+1];
    bl = list_raw[| i+t_blankshift+2];
    c  = list_raw[| i+t_blankshift+3];
    if (is_undefined(c))
        {
        c = 0;
        bl = 1;
        }
    
    
    //x
    if (controller.invert_x)
        buffer_write(output_buffer_next,buffer_u16,t_fullrange-xp*t_pos_scale);
    else
        buffer_write(output_buffer_next,buffer_u16,xp*t_pos_scale);
    //y
    if (controller.invert_y)
        buffer_write(output_buffer_next,buffer_u16,t_fullrange-yp*t_pos_scale);
    else
        buffer_write(output_buffer_next,buffer_u16,yp*t_pos_scale);
        
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
