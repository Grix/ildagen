/// @description make_screenshot(buffer)
/// @function make_screenshot
/// @param buffer
/// @param size
function make_screenshot(argument0, argument1) {
	//returns a surface with a preview of argument0, which is a buffer containing laser frames

	el_buffer = argument0;
	var t_size = argument1;


	temp_surf = surface_create(power(2, ceil(log2(t_size))),power(2, ceil(log2(t_size))));

	buffer_seek(el_buffer,buffer_seek_start,0);
	buffer_ver = buffer_read(el_buffer,buffer_u8);
	if (buffer_ver != 52)
	{
	    show_message_new("Error: Unexpected ID byte in make_screenshot. Things might get ugly. Please contact developer.");
	    return temp_surf;
	}
	buffer_maxframes = buffer_read(el_buffer,buffer_u32);
	buffer_maxelements = buffer_read(el_buffer,buffer_u32);

	surface_set_target(temp_surf);

	draw_clear(c_black);

	draw_set_alpha(1);
	gpu_set_blendenable(0);

	el_list = ds_list_create_pool(); 

	var t_i
	for (t_i = 0; t_i < buffer_maxelements; t_i++)
	{
	    numofinds = buffer_read(el_buffer,buffer_u32);
	    var repeatnum = (numofinds-20)/4-1;
    
	    //2d
	    xo = buffer_read(el_buffer,buffer_f32)/$FFFF*t_size;
	    yo = buffer_read(el_buffer,buffer_f32)/$FFFF*t_size;  
	    buffer_seek(el_buffer,buffer_seek_relative,42);
        
		if (repeatnum >= 0)
		{
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
		                draw_rectangle(xo+xp/$FFFF*t_size+1, yo+yp/$FFFF*t_size+1,xo+xp/$FFFF*t_size-1, yo+yp/$FFFF*t_size-1, 0);
		            }
		            else
		                draw_line(xo+xpp/$FFFF*t_size, yo+ypp/$FFFF*t_size, xo+xp/$FFFF*t_size, yo+yp/$FFFF*t_size);
		        }
		    }
		}
	}
    
	gpu_set_blendenable(1);
	surface_reset_target();

	return temp_surf;

}
