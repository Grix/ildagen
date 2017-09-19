/// @description make_screenshot(buffer)
/// @function make_screenshot
/// @param buffer
//returns a surface with a preview of argument0, which is a buffer containing laser frames

temp_surf = surface_create(32,32);
el_buffer = argument0;
buffer_seek(el_buffer,buffer_seek_start,0);
buffer_ver = buffer_read(el_buffer,buffer_u8);
if (buffer_ver != 52)
{
    show_message_new("Error: Unexpected ID byte in make_screenshot. Things might get ugly. Contact developer.");
    return temp_surf;
}
buffer_maxframes = buffer_read(el_buffer,buffer_u32);
buffer_maxelements = buffer_read(el_buffer,buffer_u32);

surface_set_target(temp_surf);

draw_clear(c_black);

draw_set_alpha(1);
gpu_set_blendenable(0);

el_list = ds_list_create(); 

for (i = 0; i < buffer_maxelements;i++)
{
    numofinds = buffer_read(el_buffer,buffer_u32);
    var repeatnum = (numofinds-20)/4-1;
    var buffer_start_pos = buffer_tell(el_buffer);
    
    //2d
    xo = buffer_read(el_buffer,buffer_f32)/2048;
    yo = buffer_read(el_buffer,buffer_f32)/2048;  
    buffer_seek(el_buffer,buffer_seek_relative,42);
        
    xp = buffer_read(el_buffer,buffer_f32);
    yp = buffer_read(el_buffer,buffer_f32);
    bl = buffer_read(el_buffer,buffer_bool);
    c = buffer_read(el_buffer,buffer_u32);
    
    repeat (repeatnum)
    {
        xpp = xp;
        ypp = yp;
        blp = bl;
        
        xp = buffer_read(el_buffer,buffer_f32);
        yp = buffer_read(el_buffer,buffer_f32);
        bl = buffer_read(el_buffer,buffer_bool);
        c = buffer_read(el_buffer,buffer_u32);
        
        if (!bl)
        {
            draw_set_color(c);
            if ((xp == xpp) and (yp == ypp) and !blp)
            {
                draw_point(xo+xp/$FFFF*27, yo+yp/$FFFF*27);
            }
            else
                draw_line(xo+xpp/$FFFF*27, yo+ypp/$FFFF*27, xo+xp/$FFFF*27, yo+yp/$FFFF*27);
        }
    }
        
}
    
gpu_set_blendenable(1);
surface_reset_target();

return temp_surf;
    
    
