if (!surface_exists(frame_surf))
    frame_surf = surface_create(power(2, ceil(log2(view_wport[4]))), power(2, ceil(log2(view_hport[4]))));
if (!surface_exists(frame3d_surf))
    frame3d_surf = surface_create(power(2, ceil(log2(view_wport[4]))), power(2, ceil(log2(view_hport[4]))));
	
	
if (viewmode != 1)
{
    surface_set_target(frame_surf);
    draw_clear_alpha(c_white,0);
    surface_reset_target();
}

if (viewmode != 0)
{
    surface_set_target(frame3d_surf);
    draw_clear(c_black);
    surface_reset_target();
}

if (playingfile < 0 || playingfile >= ds_list_size(filelist))
	exit;

var t_scaley = 1/$FFFF*view_hport[4];
var t_centerx = view_wport[4]/2;
var t_centery = view_hport[4]/2;
var t_scalediag = sqrt(view_hport[4]*view_hport[4]+view_wport[4]*view_wport[4])/2;

objectlist = filelist[| playingfile];

infolist =  ds_list_find_value(objectlist, 2);
object_length = ds_list_find_value(infolist, 0);
object_maxframes = ds_list_find_value(infolist, 2);
        
        
//draw object
el_buffer = ds_list_find_value(objectlist, 1);
fetchedframe = frame mod object_maxframes;
buffer_seek(el_buffer,buffer_seek_start,0);
buffer_ver = buffer_read(el_buffer,buffer_u8);
if (buffer_ver != 52)
{
	show_message_new("Error: Unexpected version id reading buffer in refresh_seq_surface: "+string(buffer_ver)+". Things might get ugly. Contact developer.");
	exit;
}
buffer_maxframes = buffer_read(el_buffer,buffer_u32);
        
//skip to correct frame
for (i = 0; i < fetchedframe;i++)
{
	numofel = buffer_read(el_buffer,buffer_u32);
	for (u = 0; u < numofel; u++)
	{
	    numofdata = buffer_read(el_buffer,buffer_u32)-20;
	    buffer_seek(el_buffer,buffer_seek_relative,50+numofdata*3.25);
	}
}
            
buffer_maxelements = buffer_read(el_buffer,buffer_u32);
        
draw_set_alpha(1);
        
//actual elements
for (i = 0; i < buffer_maxelements;i++)
{
	numofinds = buffer_read(el_buffer,buffer_u32);
	var repeatnum = (numofinds-20)/4-1;
	var buffer_start_pos = buffer_tell(el_buffer);
            
	//2d
	gpu_set_blendenable(0);
	if (viewmode != 1)
	{
	    xo = view_wport[4]/2-view_hport[4]/2+buffer_read(el_buffer,buffer_f32)*t_scaley;
	    yo = buffer_read(el_buffer,buffer_f32)*t_scaley;  
	    buffer_seek(el_buffer,buffer_seek_relative,42);
                
	    xp = buffer_read(el_buffer,buffer_f32);
	    yp = buffer_read(el_buffer,buffer_f32);
	    bl = buffer_read(el_buffer,buffer_bool);
	    c = buffer_read(el_buffer,buffer_u32);
		
	    surface_set_target(frame_surf);
                
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
	                draw_point(xo+xp*t_scaley,yo+yp*t_scaley);
	            }
	            else
	                draw_line(xo+ xpp*t_scaley,yo+ ypp*t_scaley,xo+ xp*t_scaley,yo+ yp*t_scaley);
	        }
	    }
                
	    surface_reset_target();
	}
	gpu_set_blendenable(1);
                
	//3d
	if (viewmode != 0)
	{
	    buffer_seek(el_buffer,buffer_seek_start,buffer_start_pos);
                
	    xo = view_wport[4]/2-view_hport[4]/2+buffer_read(el_buffer,buffer_f32)*t_scaley;
	    yo = buffer_read(el_buffer,buffer_f32)*t_scaley;  
	    buffer_seek(el_buffer,buffer_seek_relative,42);
                
	    xp = buffer_read(el_buffer,buffer_f32);
	    yp = buffer_read(el_buffer,buffer_f32);
	    bl = buffer_read(el_buffer,buffer_bool);
	    c = buffer_read(el_buffer,buffer_u32);
                
	    gpu_set_blendmode(bm_add);
	    draw_set_alpha(0.7);
	    surface_set_target(frame3d_surf);
                
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
	            pdir = point_direction(t_centerx, t_centery, xo+ xp*t_scaley,yo+ yp*t_scaley);
	            xxp = t_centerx+cos(degtorad(-pdir))*t_scalediag;
	            yyp = t_centery+sin(degtorad(-pdir))*t_scalediag;
                        
	            if (xpp == xp) and (ypp == yp) and !(blp)
	            {
	                draw_set_alpha(0.9);
	                draw_line_colour(t_centerx, t_centery, xxp,yyp,c,c_black);
	                draw_set_alpha(0.7);
	            }
	            else
	            {
	                pdir_p = point_direction(t_centerx,t_centery,xo+ xpp*t_scaley,yo+ ypp*t_scaley);
	                xxp_p = t_centerx+cos(degtorad(-pdir_p))*t_scalediag;
	                yyp_p = t_centery+sin(degtorad(-pdir_p))*t_scalediag;
	                draw_triangle_colour(t_centerx,t_centery,xxp_p,yyp_p,xxp,yyp,c,c_black,c_black,0);
	            }
	        }
	    }
	    gpu_set_blendmode(bm_normal);
	    draw_set_alpha(1);
	    surface_reset_target();  
	}
}

draw_set_alpha(1);
gpu_set_blendmode(bm_normal);
draw_set_color(c_black);