function refresh_minitimeline_surf() {
	if (!surface_exists(minitimeline_surf))
	    minitimeline_surf = surface_create(max(1, power(2, ceil(log2(view_wport[4]/dpi_multiplier)))), max(1, power(2, ceil(log2(view_wport[4]/512*42/dpi_multiplier)))));
    
	var t_tlw = tlw / dpi_multiplier;
	var t_tlh = tlh / dpi_multiplier;
	
	surface_set_target(minitimeline_surf);
    
	    draw_clear_alpha(c_white,1);
	    draw_set_alpha(1);
	    draw_set_font(fnt_small);
	    draw_set_colour(c_black);
    
	    //timeline
	    draw_set_color(c_black);
	        draw_line(-1, t_tlh-15, t_tlw, t_tlh-15);
			draw_line(t_tlw-1, -1, t_tlw-1, t_tlh);
			draw_line(-1, t_tlh-1, t_tlw, t_tlh-1);
	    draw_set_alpha(0.2);
	        if (seqcontrol.selectedx >= 0)
	            tlx = seqcontrol.selectedx;
	        else
	            tlx = ds_list_find_value(abs(seqcontrol.selectedx), 0);
	        projectfps = seqcontrol.projectfps;;
	        //var drawtime = ceil(tlx/projectfps);
	        tlzoom = maxframes;
	        var modulus = ceil(maxframes/90)*0.2;
	        var templine = 0;
	        for (u=0; u <= t_tlw; u++)
	        {
	            temptime = u/t_tlw*(maxframes-1)/projectfps;
	            if (floor(temptime / modulus) != templine)
	            {
	                templine = floor(temptime / modulus);
	                if ((templine % 5) = 0)
	                    draw_set_alpha(0.6);
	                else
	                    draw_set_alpha(0.2);
	                draw_line(u,0,u,t_tlh-15);
	                draw_set_alpha(1);
	                draw_set_halign(fa_center);
	                draw_set_valign(fa_center);
	                draw_text(u,t_tlh-7,  string_replace(string_format(floor(temptime),2,0)," ","0")+
	                                    "."+string_replace(string_format(frac(temptime)*100,2,0)," ","0"));
	                draw_set_halign(fa_left);
	                draw_set_valign(fa_top);
	                draw_set_alpha(0.2);
	            }
            
	        }

	//scope marking
	draw_set_alpha(0.3);
	draw_set_color(c_teal);
	if (maxframes > 1)
	{
	    if (fillframes)
	    {
	        minicursorx1 = lerp(0,t_tlw,scope_start/(maxframes-1));
	        minicursorx2 = lerp(0,t_tlw,scope_end/(maxframes-1));
	    }
	    else
	    {
	        minicursorx1 = lerp(0,t_tlw,frame/(maxframes-1))-1;
	        minicursorx2 = lerp(0,t_tlw,frame/(maxframes-1))+1;
	    }
	    draw_rectangle(minicursorx1,t_tlh-15,minicursorx2,t_tlh+1,0);
	}
	else
	    draw_rectangle(0,t_tlh-15,t_tlw,t_tlh+1,0);
         
	//audio  
	if (seqcontrol.song != -1)
	{
	    draw_set_alpha(0.67);
	    var t_tlhalf = (t_tlh-15)/2;
	    for (u=0; u <= t_tlw; u++)
	    {
	        var nearesti = round((tlx+u*tlzoom/t_tlw)/projectfps*60)*3;
        
	        if (nearesti > buffer_get_size(seqcontrol.audio_buffer)-3 || nearesti < 0)
	            break;
            
	        v = buffer_peek(seqcontrol.audio_buffer, nearesti, buffer_u8)/255;
	        draw_set_color(c_green);
	        draw_line(u,t_tlhalf+v*t_tlhalf,u,t_tlhalf-v*t_tlhalf);
        
	        v = buffer_peek(seqcontrol.audio_buffer, nearesti+1, buffer_u8)/255;
	        draw_set_color(c_red);
	        draw_line(u,t_tlhalf+v*t_tlhalf,u,t_tlhalf-v*t_tlhalf);
        
	        v = buffer_peek(seqcontrol.audio_buffer, nearesti+2, buffer_u8)/255;
	        draw_set_color(c_blue);
	        draw_line(u,t_tlhalf+v*t_tlhalf,u,t_tlhalf-v*t_tlhalf);    
	    }
	}
    
     
	surface_reset_target();
	draw_set_color(c_black);
	draw_set_alpha(1);   
	draw_set_font(fnt_tooltip);



}
