if (!surface_exists(audio_surf))
    audio_surf = surface_create(tlw+1,95);
    
surface_set_target(audio_surf);
    draw_clear_alpha(c_white,1);
    draw_set_alpha(0.6);
    for (u=0; u < tlw; u++)
        {
        nearesti = (tlx+u*tlzoom/tlw)/projectfps*60*3;
        
        if (nearesti > ds_list_size(audio_list)-5)
            break;
            
        v = ds_list_find_value(audio_list,nearesti);
        draw_set_color(c_black);
        draw_line(u,46+v*45,u,46-v*45);
        
        v = ds_list_find_value(audio_list,nearesti+1);
        draw_set_color(c_red);
        draw_line(u,46+v*45,u,46-v*45);
        
        v = ds_list_find_value(audio_list,nearesti+2);
        draw_set_color(c_blue);
        draw_line(u,46+v*45,u,46-v*45);
        

        }
        
surface_reset_target();
draw_set_alpha(1);
draw_set_color(c_white);
