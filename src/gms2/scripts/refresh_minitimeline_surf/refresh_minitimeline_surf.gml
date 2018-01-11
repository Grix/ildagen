if (!surface_exists(minitimeline_surf))
    minitimeline_surf = surface_create(power(2, ceil(log2(view_wport[4]))), power(2, ceil(log2(view_wport[4]/512*42))));
    
surface_set_target(minitimeline_surf);
    
    draw_clear_alpha(c_white,1);
    draw_set_alpha(1);
    draw_set_font(fnt_small);
    draw_set_colour(c_black);
    
    //timeline
    draw_set_color(c_black);
        draw_line(-1,tlh-13,tlw,tlh-13);
    draw_set_alpha(0.2);
        if (seqcontrol.selectedx >= 0)
            tlx = seqcontrol.selectedx;
        else
            tlx = ds_list_find_value(abs(seqcontrol.selectedx), 0);
        projectfps = seqcontrol.projectfps;;
        var drawtime = ceil(tlx/projectfps);
        tlzoom = maxframes;
        var modulus = ceil(maxframes/90)*0.2;
        var templine = 0;
        for (u=0; u <= tlw; u++)
        {
            temptime = u/tlw*(maxframes-1)/projectfps;
            if (floor(temptime / modulus) != templine)
            {
                templine = floor(temptime / modulus);
                if ((templine % 5) = 0)
                    draw_set_alpha(0.6);
                else
                    draw_set_alpha(0.2);
                draw_line(u,0,u,tlh-13);
                draw_set_alpha(1);
                draw_set_halign(fa_center);
                draw_set_valign(fa_center);
                draw_text(u,tlh-6,  string_replace(string_format(floor(temptime),2,0)," ","0")+
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
        minicursorx1 = lerp(0,tlw,scope_start/(maxframes-1));
        minicursorx2 = lerp(0,tlw,scope_end/(maxframes-1));
    }
    else
    {
        minicursorx1 = lerp(0,tlw,frame/(maxframes-1))-1;
        minicursorx2 = lerp(0,tlw,frame/(maxframes-1))+1;
    }
    draw_rectangle(minicursorx1,tlh-13,minicursorx2,tlh+1,0);
}
else
    draw_rectangle(0,tlh-13,tlw,tlh+1,0);
         
//audio  
if (seqcontrol.song != -1)
{
    draw_set_alpha(0.67);
    var t_tlhalf = (tlh-13)/2;
    for (u=0; u <= tlw; u++)
    {
        var nearesti = round((tlx+u*tlzoom/tlw)/projectfps*30)*3;
        
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
