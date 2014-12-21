if (!surface_exists(audio_surf))
    audio_surf = surface_create(1024,1024);
    
surface_set_target(audio_surf);
    draw_clear_alpha(c_white,0);
    draw_set_color(c_white);
    draw_rectangle(0,0,tlw,tlh,0);
    draw_set_alpha(0.6);
    for (u=0; u < tlw; u++)
        {
        nearesti = round((tlx+u*tlzoom/tlw/1)/projectfps*60)*3;
        
        if (nearesti > ds_list_size(audio_list)-3)
            break;
            
        v = ds_list_find_value(audio_list,nearesti);
        draw_set_color(c_black);
        draw_line(u,tlhalf+v*tlthird,u,tlhalf-v*tlthird);
        
        v = ds_list_find_value(audio_list,nearesti+1);
        draw_set_color(c_red);
        draw_line(u,tlhalf+v*tlthird,u,tlhalf-v*tlthird);
        
        v = ds_list_find_value(audio_list,nearesti+2);
        draw_set_color(c_blue);
        draw_line(u,tlhalf+v*tlthird,u,tlhalf-v*tlthird);
        }
        
surface_reset_target();
draw_set_alpha(1);
draw_set_color(c_white);