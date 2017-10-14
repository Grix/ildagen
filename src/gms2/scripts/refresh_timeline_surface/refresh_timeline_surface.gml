//redraws the surface containing the layer list and audio visualization in the timeline mode

if (!surface_exists(timeline_surf))
{
    timeline_surf = surface_create(2048,1024);
	timeline_surf_pos = tlx;
	timeline_surf_length = 0;
}
if (!surface_exists(timeline_surf_audio))
{
    timeline_surf_audio = surface_create(2048,128);
	timeline_surf_pos = tlx;
	timeline_surf_length = 0;
}
    
if (timeline_surf_tlzoom != tlzoom || timeline_surf_pos > tlx)
{
	timeline_surf_length = 0;
	timeline_surf_pos = tlx;
	timeline_surf_tlzoom = tlzoom;
}

var tlwdivtlzoom = tlw/tlzoom; //frames to pixels -> *
var t_tlx = timeline_surf_pos + timeline_surf_length; //in frames
var t_tlzoom = tlx+tlzoom-t_tlx + 200/tlwdivtlzoom; //in frames
var t_tlw = ceil(t_tlzoom*tlwdivtlzoom); //in pixels


if (tlx+tlzoom-t_tlx > -50/tlwdivtlzoom)
{
	if (!surface_exists(timeline_surf_temp))
		timeline_surf_temp = surface_create(2048,1024);
	if (!surface_exists(timeline_surf_audio_temp))
		timeline_surf_audio_temp = surface_create(2048,128);
	
	//if (surface_get_width(timeline_surf) - timeline_surf_length*tlwdivtlzoom < tlw+50)
	if (timeline_surf_length*tlwdivtlzoom + t_tlw > surface_get_width(timeline_surf))
	{
		var t_newpos = tlx-20 - timeline_surf_pos;
		
		surface_copy_part(timeline_surf_temp, 0, 0, timeline_surf, ceil(t_newpos*tlwdivtlzoom), 0, tlw, surface_get_height(timeline_surf));
		surface_copy_part(timeline_surf_audio_temp, 0, 0, timeline_surf_audio, ceil(t_newpos*tlwdivtlzoom), 0, tlw, surface_get_height(timeline_surf_audio));
		
		timeline_surf_pos = tlx-20;
		timeline_surf_length = tlw/tlwdivtlzoom;
		
		var t_tempsurf = timeline_surf_temp;
		timeline_surf_temp = timeline_surf;
		timeline_surf = t_tempsurf;
		t_tempsurf = timeline_surf_audio_temp;
		timeline_surf_audio_temp = timeline_surf_audio;
		timeline_surf_audio = t_tempsurf;
		
		var tlwdivtlzoom = tlw/tlzoom; //frames to pixels -> *
		var t_tlx = timeline_surf_pos + timeline_surf_length; //in frames
		var t_tlzoom = tlx+tlzoom-t_tlx + 200/tlwdivtlzoom; //in frames
		var t_tlw = round(t_tlzoom*tlwdivtlzoom); //in pixels
	}

	surface_set_target(timeline_surf_temp);

	    draw_set_alpha(1);
	    draw_set_font(fnt_small);
	    gpu_set_blendenable(false);
		draw_set_color(c_white);
		draw_rectangle(0, 0, t_tlw, surface_get_height(timeline_surf_temp), 0);
    
	    //layers
    
	    draw_set_color(c_black);
	    ypos_perm = -layerbary;
	    for (i = 0; i < ds_list_size(layer_list);i++)
	    {
	        _layer = layer_list[| i];
        
	        if (ypos_perm > -48) and (ypos_perm < lbsh)
	        {
                            
	            draw_rectangle_colour(-1,ypos_perm,t_tlw+1,ypos_perm+48,c_white,c_white,c_silver,c_silver,0);
	            draw_rectangle(-1,ypos_perm,t_tlw+1,ypos_perm+48,1);
            
	            elementlist = _layer[| 1];
	            for (j = 0; j < ds_list_size(elementlist); j++)
	            {
	                objectlist = elementlist[| j];
				
					if (!ds_exists(objectlist,ds_type_list))
					{
						ds_list_delete(elementlist, j);
						if (j > 0)
							j--;
						continue;
					}
                
	                frametime = ds_list_find_value(objectlist,0);
	                infolist = ds_list_find_value(objectlist,2);
	                duration = ds_list_find_value(infolist,0);
                
	                if (frametime < t_tlx+t_tlzoom) and (frametime+duration > t_tlx)
	                {
	                    //draw object on timeline
	                    framestartx = floor((frametime-t_tlx)*tlwdivtlzoom);
	                    frameendx = ceil((frametime-t_tlx+duration+1)*tlwdivtlzoom);
	                    draw_set_colour(c_dkgray);
	                        draw_rectangle(framestartx,ypos_perm+1,frameendx,ypos_perm+47,0);
	                    draw_set_colour(c_green);
	                        draw_rectangle(framestartx,ypos_perm+1,frameendx,ypos_perm+47,1);
	                    draw_set_colour(c_white);
						if ((duration+1)*tlwdivtlzoom > 3)
						{
		                    if (!surface_exists(infolist[| 1]))
		                        infolist[| 1] = make_screenshot(objectlist[| 1]);
		                    draw_surface_part(infolist[| 1],0,0,floor(clamp((duration+1)*tlwdivtlzoom,0,32))-1,32,framestartx+1,ypos_perm+8);
						}
	                    maxframes = infolist[| 2];
	                    draw_set_colour(c_black);
	                    if (maxframes != 1)
	                        for (k = 1; k <= duration/maxframes; k++)
	                        {
	                            linex = floor(framestartx+k*maxframes*tlwdivtlzoom);
	                            draw_line(linex,ypos_perm,linex,ypos_perm+48);
	                        }
	                    if (ds_list_find_index(somaster_list,objectlist) != -1)
	                    {
	                        draw_set_colour(c_gold);
	                        gpu_set_blendenable(true);
	                        draw_set_alpha(0.3);
	                            draw_rectangle(framestartx,ypos_perm+1,frameendx,ypos_perm+47,0);
	                        draw_set_alpha(1);
	                        gpu_set_blendenable(false);
	                        draw_set_colour(c_black);
	                    }
	                }
	            }
	        }
                        
	        ypos_perm += 48;
        
	        //envelopes
	        envelope_list = ds_list_find_value(_layer, 0);
	        for (j = 0; j < ds_list_size(envelope_list); j++)
	        {
	            if (ypos_perm > -64) and (ypos_perm < lbsh)
	            {
	                envelope = ds_list_find_value(envelope_list,j);
	                type = ds_list_find_value(envelope,0);
	                disabled = ds_list_find_value(envelope,3);
	                hidden = ds_list_find_value(envelope,4);
	                if (!disabled)
	                    draw_set_colour(c_white);
	                else
	                    draw_set_colour(c_gray);
	                if (!hidden)
	                {
	                    draw_rectangle(-1,ypos_perm,t_tlw+1,ypos_perm+64,0);
	                    draw_set_colour(c_ltgray);
	                    draw_line(-1,ypos_perm+32,t_tlw+1,ypos_perm+32);
	                    draw_set_colour(c_black);
	                    draw_rectangle(-1,ypos_perm,t_tlw+1,ypos_perm+64,1);
	                }
	                else
	                {
	                    draw_rectangle(-1,ypos_perm,t_tlw+1,ypos_perm+16,0);
	                    draw_set_colour(c_black);
	                    draw_rectangle(-1,ypos_perm,t_tlw+1,ypos_perm+16,1);
                    
	                    //ypos_perm += 16;
	                    ypos_perm += 16;
	                    continue;
	                }
                
	                //drawing envelope data
	                time_list = ds_list_find_value(envelope,1);
	                data_list = ds_list_find_value(envelope,2);
	                var default_value = ypos_perm+32;
	                if (type != "x") and (type != "y") and (type != "hue")
	                    default_value = ypos_perm;
	                draw_set_colour(c_green);
	                if (ds_list_size(time_list))
	                {
	                    //binary search algo, set t_index to the list index just before visible area
	                    var imin = 0;
	                    var imax = ds_list_size(time_list)-1;
	                    var imid;
	                    while (imin <= imax)
	                    {
	                        imid = floor(mean(imin,imax));
	                        if (ds_list_find_value(time_list,imid) <= t_tlx)
	                        {
	                            var valnext = ds_list_find_value(time_list,imid+1);
	                            if (is_undefined(valnext)) or (valnext > t_tlx)
	                                break;
	                            else
	                                imin = imid+1;
	                        }
	                        else
	                            imax = imid-1;
	                    }
	                    var t_index = imid;
	                    var t_env_y;
	                    var t_env_x;
	                    //draw envelope graph
	                    while ( (ds_list_find_value(time_list,t_index)-t_tlx) < t_tlzoom)
	                    {
	                        t_env_y = ypos_perm+ds_list_find_value(data_list,t_index);
	                        t_env_x = (ds_list_find_value(time_list,t_index)-t_tlx)*tlwdivtlzoom;
	                        if (t_index == ds_list_size(time_list)-1)
	                        {
	                            if (t_index == 0)
	                            {
	                                draw_line( -1, t_env_y, t_tlw+1, t_env_y);
	                                draw_rectangle( t_env_x-1,t_env_y-1,t_env_x+1,t_env_y+1,0);
	                                break;
	                            }
	                            draw_line(  t_env_x,t_env_y,t_tlw+1, t_env_y);
	                            draw_rectangle( t_env_x-1,t_env_y-1,t_env_x+1,t_env_y+1,0);
	                            break;
	                        }
	                        else if (t_index == 0)
	                            draw_line(  -1, t_env_y, t_env_x, t_env_y);
	                        draw_line(  t_env_x, t_env_y,
	                                    (ds_list_find_value(time_list,t_index+1)-t_tlx)*tlwdivtlzoom,
	                                    ypos_perm+ds_list_find_value(data_list,t_index+1));
	                        draw_rectangle( t_env_x-1,t_env_y-1,t_env_x+1,t_env_y+1,0);
	                        t_index++;
	                    }
	                }
	                else
	                {
	                    draw_line(-1,default_value,t_tlw+1,default_value);
	                }
	            }
	            ypos_perm += 64;
	        }
		}
		//ypos_perm += 48;
		
	surface_reset_target();
    
	surface_set_target(timeline_surf_audio_temp);
	
	    draw_set_alpha(1);
	    draw_set_font(fnt_small);
	    gpu_set_blendenable(false);
		draw_set_color(c_white);
		draw_rectangle(0, 0, t_tlw, surface_get_height(timeline_surf_audio_temp), 0);
    
		gpu_set_colorwriteenable(true,true,true,false);	
		
		draw_set_color(c_black);
		draw_rectangle(-1,tlh,t_tlw+1,tlh+15,1);
		
		gpu_set_blendenable(true);
       
	    var drawtime = floor(t_tlx/projectfps)-1;
		if (tlwdivtlzoom > 5) 
			modulus = 5/projectfps;
	    else if (tlwdivtlzoom > 0.3) 
			modulus = 5;
	    else if (tlwdivtlzoom > 0.05)
			modulus = 30;
	    else if (tlwdivtlzoom > 0.02)
			modulus = 60;
		else
			modulus = 300;
    
	    draw_set_colour(c_ltgray);
	    gpu_set_blendenable(true);
	    while (1)
	    {
	        var tempx = round((drawtime*projectfps-t_tlx)*tlwdivtlzoom);
	        if (tempx > t_tlw+10)
	            break;

	        if ((drawtime % modulus) == 0)
	        {
	            //draw timestamp
	            draw_set_colour(c_gray);
	                draw_line(tempx,0,tempx,tlh-1);
	            draw_set_halign(fa_center);
	            draw_set_valign(fa_center);
	            draw_set_colour(c_dkgray);
	            draw_text(tempx,tlh+8,string_replace(string_format(floor(drawtime/60),2,0)," ","0")+
	                                ":"+string_replace(string_format(drawtime %60,2,0)," ","0"));
	            draw_set_halign(fa_left);
	            draw_set_valign(fa_top);
	            draw_set_colour(c_ltgray);
	        }
	        else
	        {
	            if ((drawtime % (modulus/5)) == 0)
	                draw_line(tempx,0,tempx,tlh-1);
	        }
			drawtime++;
			//todo maybe add frame granulity
	    }
		
	    //audio   
	    if (song != -1)
	    {
	        for (u=0; u <= t_tlw; u++)
	        {
	            var nearesti = round((t_tlx+u*t_tlzoom/t_tlw)/projectfps*30)*3;
            
	            if (nearesti > buffer_get_size(audio_buffer)-3 || nearesti < 0)
	                break;
                
	            var v_tlhalf = tlhalf;
                
				draw_set_alpha(0.6);
	            var t_wave = buffer_peek(audio_buffer, nearesti, buffer_u8)/255;
				draw_set_color(c_green);
	            draw_line(u, v_tlhalf+t_wave*v_tlhalf, u, v_tlhalf-t_wave*v_tlhalf);
            
				draw_set_alpha(0.4);
	            var t_bass = buffer_peek(audio_buffer, nearesti+1, buffer_u8)/255;
	            draw_set_color(c_red);
	            draw_line(u, v_tlhalf+t_bass*v_tlhalf, u, v_tlhalf-t_bass*v_tlhalf);
            
				draw_set_alpha(0.4);
	            var t_treble = buffer_peek(audio_buffer, nearesti+2, buffer_u8)/255;
	            draw_set_color(c_blue);
	            draw_line(u, v_tlhalf+ t_treble*v_tlhalf, u, v_tlhalf-t_treble*v_tlhalf);    
	        }
			


	    }
	gpu_set_colorwriteenable(true,true,true,true);
	surface_reset_target();
	
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(fnt_tooltip);
	
	ypos_perm += layerbary;
	
	if (timeline_surf_length == 0)
	{
		var t_tempsurf = timeline_surf_temp;
		timeline_surf_temp = timeline_surf;
		timeline_surf = t_tempsurf;
		t_tempsurf = timeline_surf_audio_temp;
		timeline_surf_audio_temp = timeline_surf_audio;
		timeline_surf_audio = t_tempsurf;
	}
	else
	{	
		surface_copy_part(timeline_surf, floor(timeline_surf_length*tlwdivtlzoom), 0, timeline_surf_temp, 0, 0, t_tlw, surface_get_height(timeline_surf));
		surface_copy_part(timeline_surf_audio, floor(timeline_surf_length*tlwdivtlzoom), 0, timeline_surf_audio_temp, 0, 0, t_tlw, surface_get_height(timeline_surf_audio));
	}
	
	timeline_surf_length += t_tlzoom;
}