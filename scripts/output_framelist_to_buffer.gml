output_buffer_next_size = ds_list_size(list_raw)/4;
var t_list_raw_size = ds_list_size(list_raw)-4;

var t_red_scale = controller.red_scale;
var t_green_scale = controller.green_scale;
var t_blue_scale = controller.blue_scale;

if (controller.dac[| 1] == 0) || (controller.dac[| 1] == 1)
    {
        //riya, lasdac: 12bit xy
        //var t_pos_scale = $FFF/$FFFF;
        var t_scaleshift = 4;
    }
else
    {
        //var t_pos_scale = 1;
        var t_scaleshift = 0;
    }
    
var t_blankshift = controller.opt_blankshift*4;

for (i = 0; i <= t_list_raw_size; i += 4)
    {
    //writing point
    
    if (controller.invert_x)
        xp = $FFFF - list_raw[| i];
    else
        xp = list_raw[| i];
    if (controller.invert_y)
        yp = $FFFF - list_raw[| i+1];
    else
        yp = list_raw[| i+1];
        
    bl = list_raw[| i+t_blankshift+2];
    c  = list_raw[| i+t_blankshift+3];
    if (is_undefined(c))
        {
        c = 0;
        bl = 1;
        }
    
    buffer_write(output_buffer_next,buffer_u16, xp >> t_scaleshift); //x
    buffer_write(output_buffer_next,buffer_u16, yp >> t_scaleshift); //y
        
    buffer_write(output_buffer_next,buffer_u8,(c & $FF) * t_red_scale);             //red
    buffer_write(output_buffer_next,buffer_u8,((c >> 8) & $FF) * t_green_scale);    //green
    buffer_write(output_buffer_next,buffer_u8,(c >> 16) * t_blue_scale);            //blue
    
    //intensity
    if (bl)
        buffer_write(output_buffer_next,buffer_u8,0); 
    else
        buffer_write(output_buffer_next,buffer_u8,255);
        
    }
    
ds_list_destroy(list_raw);
ds_list_destroy(list_points);
