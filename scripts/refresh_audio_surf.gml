if (!surface_exists(audio_surf))
    audio_surf = surface_create(1024,1024);
    
surface_set_target(audio_surf);

    tlwdivtlzoom = tlw/tlzoom;    

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
            
        draw_rectangle_colour(0,tempstartx+i*48,tlw-17,tempstartx+i*48+48,c_white,c_white,c_silver,c_silver,0);
        
        layer = ds_list_find_value(layer_list, i);
        for (j = 0; j < ds_list_size(layer); j += 3)
            {
            infolist = ds_list_find_value(layer,j+2);
            duration = ds_list_find_value(infolist,0);
            frametime = round(ds_list_find_value(layer,j));
            draw_set_colour(c_dkgray);
            if (frametime < tlx+tlzoom) and (frametime+duration > tlx)
                {
                //draw object on timeline
                framedelta = (frametime-tlx)/tlzoom*tlw;
                draw_rectangle(framedelta,tempstartx+i*48,framedelta+duration/tlzoom*tlw,tempstartx+i*48+48,0);
                if (!surface_exists(ds_list_find_value(infolist,1)))
                    ds_list_replace(infolist,1,make_screenshot(ds_list_find_value(layer,j+1)));
                draw_surface_part(ds_list_find_value(infolist,1),0,0,clamp(duration,1,32)/tlzoom*tlw,32,framedelta,tempstartx+i*48+8);
                if (selectedlayer == i) and (selectedx == -j)
                    {
                    draw_set_color(c_gold);
                    draw_set_alpha(0.3);
                        draw_rectangle(framedelta,tempstartx+i*48,framedelta+duration/tlzoom*tlw,tempstartx+i*48+48,0);
                    draw_set_alpha(1);
                    draw_set_color(c_black);
                    }
                }
            }
        
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
    if (tlwdivtlzoom > 0.3) modulus = 5;
    else if (tlwdivtlzoom > 0.05) modulus = 25;
    else modulus = 60;
    
    draw_set_alpha(0.2);
    while (1)
        {
        tempx = (drawtime*projectfps-tlx)*tlwdivtlzoom;
        if (tempx > tlw)
            break;

        if ((drawtime % modulus) == 0)
            {
            //draw timestamp
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
        
    draw_set_alpha(1);
    startframex = 0;
    endframex = tlw;
    for (u=0; u <= tlzoom; u++)
        {
        if (round(tlx)+u == startframe)
            {
            startframex = u*tlwdivtlzoom;
            draw_set_color(c_blue);
            draw_rectangle(startframex,0,startframex+1,tlh,0);
            draw_rectangle(startframex,tlh+16,startframex+1,tlh+16+lbh,0);
            draw_set_font(fnt_bold);
            draw_text(startframex+4,tlh+16+lbh-20,"Start");
            }
        if (round(tlx)+u == endframe)
            {
            endframex = u*tlwdivtlzoom;
            draw_set_color(c_red);
            draw_rectangle(endframex,0,endframex+1,tlh,0);
            draw_rectangle(endframex,tlh+16,endframex+1,tlh+16+lbh,0);
            draw_set_font(fnt_bold);
            draw_text(endframex-25,tlh+16+lbh-20,"End");
            }
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

    draw_set_alpha(0.3);
    draw_set_colour(c_black);
    draw_rectangle(0,0,startframex,tlh+16+lbh,0);
    draw_rectangle(endframex,0,tlw,tlh+16+lbh,0);
        
        
surface_reset_target();
draw_set_color(c_white);
draw_set_font(fnt_tooltip);
