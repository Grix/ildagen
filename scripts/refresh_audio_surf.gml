if (!surface_exists(audio_surf))
    audio_surf = surface_create(1024,1024);
    
surface_set_target(audio_surf);
    
    draw_clear_alpha(c_white,0);
    draw_set_alpha(1);
    draw_set_font(fnt_small);
    draw_set_colour(c_black);
    
    //layers
    //tempstartx and layerbarx are really Y values
    tempstartx = tlh+16-layerbarx//tlh+16-floor(layerbarx);
    for (i = 0; i <= ds_list_size(layer_list);i++)
        {
        if (i < floor(layerbarx/48))
            continue;
        
        mouseover = (mouse_x == clamp(mouse_x,8,40)) && (mouse_y == clamp(mouse_y,138+tempstartx+i*48+8,138+tempstartx+i*48+40))
        if (i == ds_list_size(layer_list))
            {
            draw_sprite(spr_addlayer,mouseover,8,tempstartx+i*48+8);
            break;
            }
        
        draw_rectangle_color(0,tempstartx+i*48,tlw-17,tempstartx+i*48+48,c_white,c_white,c_silver,c_silver,0);
        draw_set_colour(c_black);
        draw_rectangle(0,tempstartx+i*48,tlw-17,tempstartx+i*48+48,1);
        draw_sprite(spr_deletelayer,mouseover,8,tempstartx+i*48+8);
        }
        
    //timeline
    draw_set_color(c_white);
        draw_rectangle(0,0,tlw,tlh+16,0);
    draw_set_color(c_black);
        draw_line(0,tlh,tlw,tlh);
        draw_line(0,tlh+16,tlw,tlh+16);
        
    drawtime = ceil(tlx/projectfps);
    if (tlw/tlzoom > 0.3) modulus = 5;
    else if (tlw/tlzoom > 0.05) modulus = 25;
    else modulus = 60;
    
    draw_set_alpha(0.2);
        while (1)
            {
            tempx = (drawtime*projectfps-tlx)*tlw/tlzoom;
            if (tempx > tlw)
                break;

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

         
    //audio   
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
