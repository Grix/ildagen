if (!surface_exists(audio_surf))
    audio_surf = surface_create(1024,1024);
    
surface_set_target(audio_surf);
    draw_clear_alpha(c_white,0);
    draw_set_alpha(1);
    draw_set_font(fnt_small);
    draw_set_color(c_white);
        draw_rectangle(0,0,tlw,tlh+16,0);
    draw_set_color(c_black);
        draw_line(0,tlh,tlw,tlh);
    
    draw_set_alpha(0.2);
        drawtime = ceil(tlx/projectfps);
        while (1)
            {
            tempx = (drawtime*projectfps-tlx)*tlw/tlzoom;
            if (tempx > tlw)
                break;
            if (tlw/tlzoom > 0.3) modulus = 5;
            else if (tlw/tlzoom > 0.05) modulus = 25;
            else modulus = 60;
            if ((drawtime % modulus) == 0)
                {
                draw_set_alpha(0.5);
                    draw_line(tempx,0,tempx,tlh);
                draw_set_alpha(0.8);
                draw_set_halign(fa_center);
                draw_set_valign(fa_center);
                draw_text(tempx,tlh+9,string_replace(string_format(floor(drawtime/60),2,0)," ","0")+
                                    ":"+string_replace(string_format(drawtime %60,2,0)," ","0"));
                draw_set_halign(fa_left);
                draw_set_valign(fa_top);
                draw_set_alpha(0.2);
                }
            else
                {
                if ((drawtime % (modulus/5)) == 0)
                    draw_line(tempx,0,tempx,tlh);
                }
            drawtime++;
            }
            
    if (song)
        {
        draw_set_alpha(0.6);
        for (u=0; u <= tlw; u++)
            {
            nearesti = round((tlx+u*tlzoom/tlw/1)/projectfps*60)*3;
            
            if (nearesti > ds_list_size(audio_list)-3)
                break;
                
            v = ds_list_find_value(audio_list,nearesti);
            draw_set_color(c_green);
            draw_line(u,tlhalf+v*tlthird,u,tlhalf-v*tlthird);
            
            v = ds_list_find_value(audio_list,nearesti+1);
            draw_set_color(c_red);
            draw_line(u,tlhalf+v*tlthird,u,tlhalf-v*tlthird);
            
            v = ds_list_find_value(audio_list,nearesti+2);
            draw_set_color(c_blue);
            draw_line(u,tlhalf+v*tlthird,u,tlhalf-v*tlthird);    
            }
        draw_set_alpha(1);
        draw_set_color(c_dkgray);
        }
        
        
surface_reset_target();
draw_set_color(c_white);
draw_set_font(fnt_tooltip);
