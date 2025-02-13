function draw_timeline() {
	if (high_performance)
		exit;

	var tlwdivtlzoom = tlw/tlzoom; //frames to pixels -> *

	draw_surface_part(timeline_surf, floor(tlx*tlwdivtlzoom - timeline_surf_pos*tlwdivtlzoom), 0, tlw-17, clamp(ypos_perm-layerbary+1, 0, lbsh-(tlh+16)), 0, tlsurf_y+tlh+15);
    
	startframex = (startframe-tlx)*tlwdivtlzoom;
	endframex = (endframe-tlx)*tlwdivtlzoom;

	//start and end frame lines
	draw_set_font(fnt_bold);
	gpu_set_blendenable(true);


	if (startframex == clamp(startframex,0,tlw-16))
	{
		draw_set_color(c_blue);
		draw_line_width(startframex,tls-1,startframex,tlsurf_y+lbsh, 2);
		draw_text(startframex+4,tlsurf_y+lbsh-20,"Start");
	}

	if (endframex == clamp(endframex,0,tlw-16))
	{
		draw_set_color(c_red);
		draw_line_width(endframex,tls-1,endframex,tlsurf_y+lbsh, 2);
		draw_text(endframex-25,tlsurf_y+lbsh-20,"End");
	}

	//markers timeline
	draw_set_alpha(0.9);
	draw_set_colour(c_fuchsia);
	for (i = 0; i < ds_list_size(marker_list); i++)
	{
		if (ds_list_find_value(marker_list,i) == clamp(ds_list_find_value(marker_list,i),tlx,tlx+tlzoom))
		{
		    var markerpostemp = (ds_list_find_value(marker_list,i)-tlx)*tlwdivtlzoom;
		    //draw_rectangle(markerpostemp,tlsurf_y,markerpostemp+1,tlh-1+tlsurf_y,0);
		    draw_rectangle(markerpostemp,tls-2,markerpostemp+1,tlsurf_y+lbsh,0);
		}
	}
	
	// jump points
	for (i = 0; i < ds_list_size(jump_button_list); i += 2)
	{
		if (jump_button_list[| i+1] == clamp(jump_button_list[| i+1], tlx, tlx+tlzoom))
		{
		    var markerpostemp = (jump_button_list[| i+1]-tlx)*tlwdivtlzoom;
		    //draw_rectangle(markerpostemp,tlsurf_y,markerpostemp+1,tlh-1+tlsurf_y,0);
			
			draw_set_alpha(0.8);
			draw_set_colour(c_orange);
		    draw_rectangle(markerpostemp,tls-2,markerpostemp+1,tlsurf_y+lbsh,0);
			
			draw_set_colour(c_maroon);
			if (jump_button_list[| i] == -1)
				draw_text(markerpostemp+4,tlsurf_y+lbsh-20,"[ Press shortcut button... ]");
			else
				draw_text(markerpostemp+4,tlsurf_y+lbsh-20,"[ " + chr(jump_button_list[| i]) + " ]");
		}
	}
	for (i = 0; i < ds_list_size(jump_button_list_midi); i += 2)
	{
		if (jump_button_list_midi[| i+1] == clamp(jump_button_list_midi[| i+1], tlx, tlx+tlzoom))
		{
		    var markerpostemp = (jump_button_list_midi[| i+1]-tlx)*tlwdivtlzoom;
		    //draw_rectangle(markerpostemp,tlsurf_y,markerpostemp+1,tlh-1+tlsurf_y,0);
			
			draw_set_alpha(0.8);
			draw_set_colour(c_orange);
		    draw_rectangle(markerpostemp,tls-2,markerpostemp+1,tlsurf_y+lbsh,0);
			
			draw_set_colour(c_maroon);
			if (jump_button_list_midi[| i] == -1)
				draw_text(markerpostemp+4,tlsurf_y+lbsh-20,"[ Press shortcut MIDI key... ]");
			else
				draw_text(markerpostemp+4,tlsurf_y+lbsh-20,"[ " + string(jump_button_list_midi[| i] >> 8) + midi_get_note_name(jump_button_list_midi[| i] & $FF) + " ]");
		}
	}

	//scope fog main
	gpu_set_blendenable(true);
	draw_set_alpha(0.3);
	draw_set_colour(c_black);
	if (startframex > 0)
		draw_rectangle(0,tlsurf_y+tlh+16,clamp(startframex,0,tlw-16),lbsh+tlsurf_y,0);
	if (endframex < tlw-17)
		draw_rectangle(clamp(endframex,0,tlw-17),tlsurf_y+tlh+16,tlw-17,lbsh+tlsurf_y,0);


	draw_set_font(fnt_tooltip);

	gpu_set_blendenable(true);
        
	draw_set_alpha(0.8);
	//tlpos cursor main
	cursorlinex = tlpos/1000*projectfps;
	cursorlinexdraw = (cursorlinex-tlx)/tlzoom*tlw;
	if (cursorlinexdraw == clamp(cursorlinexdraw,0,tlw))
	{
	    //draw_line(cursorlinexdraw,tlsurf_y,cursorlinexdraw,tlsurf_y+tlh);
	    draw_line(cursorlinexdraw,tls-1,cursorlinexdraw,lbsh+tlsurf_y);
	    if (cursorlinexdraw > (tlw/2)) and (playing) and (!scroll_moving) and (!mouse_check_button(mb_any))
	    {
	        tlx = cursorlinex-(tlw/2)*tlzoom/tlw;
	        if ((tlx+tlzoom) > length) 
				length = tlx+tlzoom;
	    }
	}
        
	draw_set_colour(c_teal);
    
	if (draw_mouseline = 1)
	{
	    draw_set_alpha(0.2);
	    draw_line(mouse_x,tls,mouse_x,lbsh+tlsurf_y-1);
	}
	if (draw_cursorline = 1)
	{
	    draw_set_alpha(0.3);
	    floatingcursorxcorrected = (floatingcursorx-tlx)/tlzoom*tlw;
	    draw_line(floatingcursorxcorrected,floatingcursory,floatingcursorxcorrected,floatingcursory+48);
	}


	gpu_set_blendenable(false);
	draw_set_alpha(1);
	var t_ypos = tlh+16-layerbary+tlsurf_y;
	var mouse_on_button_hor = (mouse_x == clamp(mouse_x,tlw-56,tlw-24));
	for (i = 0; i <= ds_list_size(layer_list);i++)
	{
		if (i == ds_list_size(layer_list))
		{
			var mouse_on_button_ver = (mouse_y == clamp(mouse_y,t_ypos+8,t_ypos+40)) && mouse_y > tlsurf_y+tlh+16;
		    if (t_ypos > tlh+16-48+tlsurf_y) and (t_ypos < lbsh+tlsurf_y)
		        draw_sprite(spr_addlayer,
		                    mouse_on_button_hor && mouse_on_button_ver,
		                    tlw-56,t_ypos+8);
		    t_ypos += 48;
		    break;
		}
            
		_layer = layer_list[| i];
          
		if (t_ypos > tlh+16-48+tlsurf_y) and (t_ypos < lbsh+tlsurf_y)
		{
			if (selectedlayer == i && ds_list_empty(somaster_list))
			{
			    draw_set_colour(c_maroon);
			    var drawcursorxcorrected = (selectedx-tlx)/tlzoom*tlw;
			    if (drawcursorxcorrected == clamp(drawcursorxcorrected,0,tlw))
			        draw_line_width(drawcursorxcorrected,t_ypos-2,drawcursorxcorrected,t_ypos+47, 2);
			    draw_set_colour(c_black);
			}
		
			var mouse_on_button_ver = (mouse_y == clamp(mouse_y,t_ypos+8,t_ypos+40)) && mouse_y > tlsurf_y+tlh+16;
			draw_sprite(spr_deletelayer,
			                mouse_on_button_ver and mouse_on_button_hor,
			                tlw-56, t_ypos+8);
			draw_sprite(spr_addenvelope,
			                mouse_on_button_ver and (mouse_x == clamp(mouse_x,tlw-96,tlw-64)),
			                tlw-96, t_ypos+8);
                            
			var t_name = _layer[| 4];
			var t_stringlength = string_width(t_name)+5;
			var t_stringx = 5;//tlw-96-t_stringlength-5;
			draw_set_colour($eeeeee);
			draw_rectangle(t_stringx,t_ypos+3,t_stringx+t_stringlength+5,t_ypos+17,0);
			draw_set_colour($bbbbbb);
			draw_rectangle(t_stringx,t_ypos+3,t_stringx+t_stringlength+5,t_ypos+17,1);
                    
			gpu_set_blendenable(true);
			
				if (moving_object == 13 && selectedlayer == i)
				{
					draw_set_colour($666666);
					floatingcursorxcorrected = (floatingcursorx-tlx)/tlzoom*tlw;
					draw_rectangle(mouse_x,t_ypos+5,floatingcursorxcorrected,t_ypos+42,1);
				}
				
			draw_set_colour(c_black);
			draw_text(t_stringx+5, t_ypos+4, t_name);
			
			gpu_set_blendenable(false);
		}

                     
		t_ypos += 48;
        
		//envelopes
		envelope_list = ds_list_find_value(_layer, 0);
		for (j = 0; j < ds_list_size(envelope_list); j++)
		{
		    if (t_ypos > tlh+16-64+tlsurf_y) and (t_ypos < lbsh+tlsurf_y)
		    {
		        envelope = ds_list_find_value(envelope_list,j);
		        type = ds_list_find_value(envelope,0);
		        disabled = ds_list_find_value(envelope,3);
		        hidden = ds_list_find_value(envelope,4);
				
				if (selectedlayer == i)
				{
				    draw_set_colour(c_maroon);
				    var drawcursorxcorrected = (selectedx-tlx)/tlzoom*tlw;
				    if (drawcursorxcorrected == clamp(drawcursorxcorrected,0,tlw))
				        draw_line(drawcursorxcorrected,t_ypos-1,drawcursorxcorrected,t_ypos + ((hidden == 0) ? 62 : 15));
				    draw_set_colour(c_black);
				}
			
		        if (hidden)
		        {
		            var typedraw = ds_map_find_value(env_type_map,type);
		            var t_stringlength = string_width(typedraw)+5;
		            var t_stringx = tlw-25-t_stringlength-5;
		            draw_set_colour($eeeeee);
		            draw_rectangle(t_stringx,t_ypos+1,t_stringx+t_stringlength+5,t_ypos+15,0);
		            draw_set_colour($bbbbbb);
		            draw_rectangle(t_stringx,t_ypos+1,t_stringx+t_stringlength+5,t_ypos+15,1);
                            
		            draw_set_colour(c_black);
		            gpu_set_blendenable(true);
		            draw_text(t_stringx+5, t_ypos+2, typedraw);
		            gpu_set_blendenable(false);
                    
		            t_ypos += 16;
		            continue;
		        }
                    
		        var typedraw = ds_map_find_value(env_type_map,type);
		        var t_stringlength = string_width(typedraw)+5;
		        var t_stringx = tlw-25-t_stringlength-5;
		        draw_set_colour($eeeeee);
		        draw_rectangle(t_stringx,t_ypos+42,t_stringx+t_stringlength+5,t_ypos+60,0);
		        draw_set_colour($bbbbbb);
		        draw_rectangle(t_stringx,t_ypos+42,t_stringx+t_stringlength+5,t_ypos+60,1);
                        
		        draw_set_colour(c_black);
		        gpu_set_blendenable(1);
		        draw_text(t_stringx+5, t_ypos+45, typedraw);
		        if (moving_object == 7) and (envelopetoedit == envelope)
		        {
		            draw_set_colour(c_red);
		            draw_set_alpha(0.3);
		            draw_rectangle(mouse_xprevious,t_ypos,mouse_x,t_ypos+63,0);
		            draw_set_colour(c_black);
		            draw_set_alpha(1);
		        }
				else if (moving_object == 9) and (envelopetoedit == envelope)
		        {
		            draw_set_colour(c_gray);
		            draw_set_alpha(0.3);
		            draw_rectangle(mouse_xprevious,t_ypos,mouse_x,t_ypos+63,0);
		            draw_set_colour(c_black);
		            draw_set_alpha(1);
		        }
				else if (moving_object == 10) and (envelopetoedit == envelope)
		        {
		            draw_set_colour(c_gray);
		            draw_set_alpha(0.3);
		            draw_rectangle(mouse_xprevious,t_ypos,(envelopexpos - tlx)*tlw/tlzoom,t_ypos+63,0);
		            draw_set_colour(c_black);
		            draw_set_alpha(1);
		        }
				else if (moving_object == 11) and (envelopetoedit == envelope)
		        {
					var t_newxposprev = round(/*tlx+*/mouse_x/tlw*tlzoom);
					var t_newxpos = t_newxposprev + (envelopexpos - xposprev);
				
		            draw_set_colour(make_color_rgb(230,230,230));
		            draw_rectangle(t_newxposprev*tlw/tlzoom,t_ypos,t_newxpos*tlw/tlzoom,t_ypos+62,0);
		            draw_set_colour(c_black);
					
					// draw preview of selected envelope section when moving
					type = ds_list_find_value(envelopetoedit,0);
					var default_value = t_ypos+32;
		            if (type != "x") and (type != "y") and (type != "hue")
		                default_value = t_ypos;
					time_list = ds_list_find_value(envelopetoedit,1);
					data_list = ds_list_find_value(envelopetoedit,2);
					if (xposprev > envelopexpos)
					{
						var t_temp = xposprev;
						xposprev = envelopexpos;
						envelopexpos = t_temp;
					}
					//binary search algo, set t_index to the list index just before visible area
		            var imin = 0;
		            var imax = ds_list_size(time_list)-1;
		            var imid;
		            while (imin <= imax)
		            {
		                imid = floor(mean(imin,imax));
		                if (ds_list_find_value(time_list,imid) <= xposprev)
		                {
		                    var valnext = ds_list_find_value(time_list,imid+1);
		                    if (is_undefined(valnext)) or (valnext >= xposprev)
		                        break;
		                    else
		                        imin = imid+1;
		                }
		                else
		                    imax = imid-1;
		            }
		            var t_index = imid;
					if (t_index != 0 && t_index < ds_list_size(time_list)-1)
						t_index += 1;
					//log(t_index, imid);
		            var t_env_y;
		            var t_env_x;
		            //draw envelope graph
		            while ( (ds_list_find_value(time_list,t_index)) <= envelopexpos)
		            {
		                t_env_y = t_ypos+ds_list_find_value(data_list,t_index);
		                t_env_x = (ds_list_find_value(time_list,t_index) - xposprev + t_newxposprev)*tlwdivtlzoom;

						if (ds_list_find_value(time_list,t_index+1) <= envelopexpos)
						{
			                draw_line(  t_env_x, t_env_y,
			                            (ds_list_find_value(time_list,t_index+1) - xposprev + t_newxposprev)*tlwdivtlzoom,
			                            t_ypos+ds_list_find_value(data_list,t_index+1));
						}
						draw_rectangle( t_env_x-1,t_env_y-1,t_env_x+1,t_env_y+1,0);
		                t_index++;
		            }
		        }
				else if (moving_object == 12) and (envelopetoedit == envelope)
		        {
					var t_newxposprev = round(tlx+mouse_x/tlw*tlzoom);
					var t_newxpos = t_newxposprev + envelope_copy_duration;
				
		            draw_set_colour(make_color_rgb(230,230,230));
		            draw_rectangle(t_newxposprev*tlw/tlzoom,t_ypos,t_newxpos*tlw/tlzoom,t_ypos+62,0);
		            draw_set_colour(c_black);
					
					// draw preview of selected envelope section when pasting
					type = ds_list_find_value(envelopetoedit,0);
					var default_value = t_ypos+32;
		            if (type != "x") and (type != "y") and (type != "hue")
		                default_value = t_ypos;
					
		            var t_env_y;
		            var t_env_x;
		            //draw envelope graph
		            for (var t_index = 0; t_index < ds_list_size(envelope_copy_list_data); t_index++)
		            {
		                t_env_y = t_ypos+ds_list_find_value(envelope_copy_list_data,t_index);
		                t_env_x = (ds_list_find_value(envelope_copy_list_time,t_index) + t_newxposprev)*tlwdivtlzoom;

						if (ds_list_find_value(envelope_copy_list_time,t_index+1) <= envelopexpos)
						{
			                draw_line(  t_env_x, t_env_y,
			                            (ds_list_find_value(envelope_copy_list_time,t_index+1) + t_newxposprev)*tlwdivtlzoom,
			                            t_ypos+ds_list_find_value(envelope_copy_list_data,t_index+1));
						}
						draw_rectangle( t_env_x-1,t_env_y-1,t_env_x+1,t_env_y+1,0);
		            }
		        }
		        gpu_set_blendenable(0);
		        mouse_on_button_ver = (mouse_y == clamp(mouse_y,8+t_ypos,40+t_ypos));
		        draw_sprite(spr_deletelayer,
		                    mouse_on_button_ver and mouse_on_button_hor,
		                    tlw-56,t_ypos+8);
		    }
		    t_ypos += 64;
		}
	}

	draw_set_alpha(1);
	draw_surface_part(timeline_surf_audio, floor(tlx*tlwdivtlzoom - timeline_surf_pos*tlwdivtlzoom), 0, tlw, tlh+16, 0, tlsurf_y);
        
	//markers audio
	draw_set_alpha(0.9);
	draw_set_colour(c_fuchsia);
	for (i = 0; i < ds_list_size(marker_list); i++)
	{
		if (ds_list_find_value(marker_list,i) == clamp(ds_list_find_value(marker_list,i),tlx,tlx+tlzoom))
		{
		    var markerpostemp = (ds_list_find_value(marker_list,i)-tlx)*tlwdivtlzoom;
		    draw_line_width(markerpostemp,tlsurf_y-1,markerpostemp,tlsurf_y+tlh-2, 2);
		}
	}


	// start/end lines audio
	if (startframex == clamp(startframex,0,tlw-16))
	{
		draw_set_color(c_blue);
		draw_line_width(startframex,tlsurf_y-1,startframex,tlsurf_y+tlh-2,2);
	}
	if (endframex == clamp(endframex,0,tlw-16))
	{
		draw_set_color(c_red);
		draw_line_width(endframex,tlsurf_y-1,endframex,tlsurf_y+tlh-2, 2);
	}

	//scope fog audio
	gpu_set_blendenable(true);
	draw_set_alpha(0.3);
	draw_set_colour(c_black);
	if (startframex > 0)
		draw_rectangle(0,tlsurf_y,clamp(startframex,0,tlw-16),tlsurf_y+tlh+16,0);
	if (endframex < tlw)
		draw_rectangle(clamp(endframex,0,tlw),tlsurf_y,tlw,tlsurf_y+tlh+16,0);
	
	
	draw_set_alpha(0.8);
	//tlpos cursor audio
	if (cursorlinexdraw == clamp(cursorlinexdraw,0,tlw))
	    draw_line(cursorlinexdraw,tlsurf_y-1,cursorlinexdraw,tlsurf_y-1+tlh);
	draw_set_colour(c_teal);
	draw_set_alpha(0.3);
	if (draw_mouseline = 1)
	{
	    draw_line(mouse_x,tlsurf_y-1,mouse_x,tlsurf_y-1+tlh);
		draw_mouseline = 0;
	}
	
	
	draw_set_alpha(1);
	gpu_set_blendenable(false);

	//scroll
	var t_width = 18;

	scrollbarw = clamp(((tlzoom+t_width)/length)*tlw-t_width-2,32,tlw-t_width-2);
	if (length != tlzoom)
		scrollbarx = (tlw-t_width-2-scrollbarw)*(tlx)/(length-tlzoom);
	layerbarw = clamp(lbh/(ypos_perm+lbh)*(lbh),32,lbh);
		
	var scrollx_x1 = round(scrollbarx);
	var scrollx_x2 = round(scrollx_x1+scrollbarw);
	var scrollx_y1 = lbsh+t_width-1+tlsurf_y;
	var scrolly_x1 = tlw-t_width;
	var scrolly_y1 = round(tls+(layerbary*layerbarw/lbh));
	var scrolly_y2 = round(scrolly_y1+layerbarw);
	draw_set_colour(c_white);
	draw_rectangle(0, scrollx_y1, tlw-t_width-1, lbsh+tlsurf_y, 0);
	draw_rectangle(scrolly_x1, tls, scrolly_x1+t_width-1, lbsh+tlsurf_y+t_width-1, 0);
	draw_set_colour(c_black);
	draw_rectangle(0, scrollx_y1, tlw-t_width-2, lbsh+tlsurf_y, 1);
	draw_rectangle(scrolly_x1, tls, scrolly_x1+t_width-1, lbsh+tlsurf_y-1, 1);
	draw_rectangle(scrollx_x1,scrollx_y1,scrollx_x2,lbsh+tlsurf_y,1);
	draw_rectangle(scrolly_x1,scrolly_y1,tlw,scrolly_y2,1);
	draw_set_colour(c_gray);
	draw_rectangle(scrollx_x1,scrollx_y1,scrollx_x2,lbsh+tlsurf_y,0);
	draw_rectangle(scrolly_x1,scrolly_y1,tlw,scrolly_y2,0);

	gpu_set_blendenable(true);
	draw_set_colour(c_black);

	var t_x = camera_get_view_width(view_camera[1])-1;
	var t_y = camera_get_view_y(view_camera[1]);
	draw_line(t_x, t_y, t_x, t_y+camera_get_view_height(view_camera[1]));


}
