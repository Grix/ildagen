if (!surface_exists(miniaudio_surf))
    miniaudio_surf = surface_create(512,512);
    
surface_set_target(miniaudio_surf);
    
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
            tlx = ds_list_find_value(abs(seqcontrol.selectedx),0);
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
    minicursorx1 = lerp(0,512,scope_start/(maxframes-1));
    minicursorx2 = lerp(0,512,scope_end/(maxframes-1));
    draw_rectangle(minicursorx1,tlh-13,minicursorx2,tlh+1,0);
}
else
    draw_rectangle(0,tlh-13,512,tlh+1,0);
         
//audio  
if (seqcontrol.song)
{
    draw_set_alpha(0.5);
    var tlhalf = (tlh-13)/2;
    var tlthird = (tlh-13)/3;
    for (u=0; u <= tlw; u++)
    {
        var nearesti = round((tlx+u*tlzoom/tlw)/projectfps*60)*3;
        
        if (nearesti > ds_list_size(seqcontrol.audio_list)-3)
            break;
            
        v = ds_list_find_value(seqcontrol.audio_list,nearesti);
        draw_set_color(c_green);
        draw_line(u,tlhalf+v*tlthird,u,tlhalf-v*tlthird);
        
        v = ds_list_find_value(seqcontrol.audio_list,nearesti+1);
        draw_set_color(c_red);
        draw_line(u,tlhalf+v*tlthird,u,tlhalf-v*tlthird);
        
        v = ds_list_find_value(seqcontrol.audio_list,nearesti+2);
        draw_set_color(c_blue);
        draw_line(u,tlhalf+v*tlthird,u,tlhalf-v*tlthird);    
    }
    draw_set_alpha(1);
}
    
        
surface_reset_target();
draw_set_color(c_white);
draw_set_font(fnt_tooltip);
