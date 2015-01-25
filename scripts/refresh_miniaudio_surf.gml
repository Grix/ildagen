if (!surface_exists(miniaudio_surf))
    miniaudio_surf = surface_create(512,512);
    
surface_set_target(miniaudio_surf);
    
    draw_clear_alpha(c_white,1);
    draw_set_alpha(1);
    draw_set_font(fnt_small);
    draw_set_colour(c_black);
    
    //timeline
    draw_set_color(c_black);
        draw_line(0,tlh-13,tlw,tlh-13);
    draw_set_alpha(0.2);
        tlx = 0
        projectfps = seqcontrol.projectfps;;
        drawtime = ceil(tlx/projectfps);
        tlzoom = maxframes;
        /*if (tlw/tlzoom > 0.3) modulus = 5;
        else if (tlw/tlzoom > 0.05) modulus = 25;
        else modulus = 60;*/
        modulus = 1;
        while (1)
            {
            tempx = (drawtime*projectfps-tlx)*tlw/tlzoom;
            if (tempx > tlw)
                break;
                
            if ((drawtime % modulus) < 0.01)
                {
                draw_set_alpha(0.5);
                    draw_line(tempx,0,tempx,tlh-13);
                draw_set_alpha(0.8);
                draw_set_halign(fa_center);
                draw_set_valign(fa_center);
                draw_text(tempx,tlh-6,  string_replace(string_format(drawtime,2,0)," ","0")+
                                    "."+string_replace(string_format(drawtime/10,2,0)," ","0"));
                draw_set_halign(fa_left);
                draw_set_valign(fa_top);
                draw_set_alpha(0.2);
                }
            else
                {
                if ((drawtime % (modulus/5)) < 0)
                    draw_line(tempx,0,tempx,tlh-13);
                }
            drawtime += 0.01;
            }

draw_set_alpha(0.3);
draw_set_color(c_teal);
if (maxframes > 1)
    draw_rectangle(lerp(0,512,scope_start/(maxframes-1)),tlh-13,lerp(0,512,scope_end/(maxframes-1)),tlh,0);
else
    draw_rectangle(0,tlh-13,512,tlh,0);
         
    //audio  
    if (seqcontrol.song)
        {
        draw_set_alpha(0.5);
        tlhalf = (tlh-13)/2;
        tlthird = (tlh-13)/3;
        for (u=0; u <= tlw; u++)
            {
            nearesti = round((tlx+u*tlzoom/tlw/1)/projectfps*60)*3;
            
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
        draw_set_color(c_dkgray);
        }
        
        
surface_reset_target();
draw_set_color(c_white);
draw_set_font(fnt_tooltip);
