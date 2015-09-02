//redraws the surface containing the layer list and audio visualization in the timeline mode

if (!surface_exists(audio_surf))
    audio_surf = surface_create(1024,1024);
    
surface_set_target(audio_surf);

    tlwdivtlzoom = tlw/tlzoom;   

    draw_clear_alpha(c_white,0);
    draw_set_font(fnt_small);
    
    //layers
    //NB: layerbarx is an Y value
    draw_set_alpha(1);
    draw_set_colour(c_black);
    tempstarty = tlh+16-layerbarx;
    ypos = tempstarty-48;
    for (i = 0; i <= ds_list_size(layer_list);i++)
        {
        ypos += 48;
        if (i < floor(layerbarx/48))
            continue;
        
        if (i == ds_list_size(layer_list))
            {
            draw_sprite(spr_addlayer,
                        (mouse_x == clamp(mouse_x,tlw-56,tlw-24)) && (mouse_y == clamp(mouse_y,138+ypos+8,138+ypos+40)),
                        tlw-56,ypos+8);
            break;
            }
                        
        draw_rectangle_colour(-1,ypos,tlw-16,ypos+48,c_white,c_white,c_silver,c_silver,0);
        
        layer = ds_list_find_value(layer_list, i);
        for (j = 0; j < ds_list_size(layer); j++)
            {
            objectlist = ds_list_find_value(layer,j);
            
            frametime = ds_list_find_value(objectlist,0);
            infolist = ds_list_find_value(objectlist,2);
            duration = ds_list_find_value(infolist,0);
            
            if (frametime < tlx+tlzoom) and (frametime+duration > tlx)
                {
                //draw object on timeline
                framestartx = (frametime-tlx)*tlwdivtlzoom;
                frameendx = (frametime-tlx+duration+1)*tlwdivtlzoom;
                draw_set_colour(c_dkgray);
                    draw_rectangle(framestartx,ypos,frameendx,ypos+48,0);
                draw_set_colour(c_green);
                    draw_rectangle(framestartx,ypos,frameendx,ypos+48,1);
                draw_set_colour(c_white);
                if (!surface_exists(ds_list_find_value(infolist,1)))
                    ds_list_replace(infolist,1,make_screenshot(ds_list_find_value(objectlist,1)));
                draw_surface_part(ds_list_find_value(infolist,1),0,0,clamp((duration+1)*tlwdivtlzoom,0,32)-1,32,framestartx+1,ypos+8);
                maxframes = ds_list_find_value(infolist,2);
                draw_set_colour(c_black);
                for (k = 1; k <= duration/maxframes; k++)
                    {
                    linex = framestartx+k*maxframes*tlwdivtlzoom;
                    draw_line(linex,ypos,linex,ypos+48);
                    }
                if (selectedlayer == i) and (selectedx == -objectlist)
                    {
                    draw_set_colour(c_gold);
                    draw_set_alpha(0.3);
                        draw_rectangle(framestartx,ypos,frameendx,ypos+48,0);
                    draw_set_alpha(1);
                    draw_set_colour(c_black);
                    }
                }
            }
        
        draw_rectangle(-1,ypos,tlw-16,ypos+48,1);
        draw_sprite(spr_deletelayer,
                        (mouse_x == clamp(mouse_x,tlw-56,tlw-24)) && (mouse_y == clamp(mouse_y,138+ypos+8,138+ypos+40)),
                        tlw-56,ypos+8);
        }
    
    //scroll
    draw_set_alpha(1);
    draw_set_colour(c_white);
        draw_rectangle(0,lbsh+17,tlw,lbsh,0);
        draw_rectangle(tlw-16,tls-138,tlw,lbsh+17,0);
    draw_rectangle_colour(scrollbarx+1,lbsh+17,scrollbarx+1+scrollbarw,lbsh,c_ltgray,c_ltgray,c_gray,c_gray,0);
    draw_rectangle_colour(tlw-16,tls+(layerbarx*layerbarw/lbh)-138,tlw,tls+(layerbarx*layerbarw/lbh)+layerbarw-138,c_ltgray,c_gray,c_gray,c_ltgray,0);
    draw_set_colour(c_black);
        draw_rectangle(0,lbsh+17,tlw,lbsh,1);
        draw_rectangle(tlw-16,tls-138,tlw,lbsh+17,1);
    
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

        if ((drawtime mod modulus) == 0)
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
    
    //start and end frame lines
    startframex = (startframe-tlx)*tlwdivtlzoom;
    if (startframex == clamp(startframex,0,tlw+1))
        {
        draw_set_color(c_blue);
        draw_rectangle(startframex,0,startframex+1,tlh-1,0);
        draw_rectangle(startframex,tlh+17,startframex+1,lbsh,0);
        draw_set_font(fnt_bold);
        draw_text(startframex+4,lbsh-20,"Start");
        }

    endframex = (endframe-tlx)*tlwdivtlzoom;
    if (endframex == clamp(endframex,0,tlw+1))
        {
        draw_set_color(c_red);
        draw_rectangle(endframex,0,endframex+1,tlh-1,0);
        draw_rectangle(endframex,tlh+17,endframex+1,lbsh,0);
        draw_set_font(fnt_bold);
        draw_text(endframex-25,lbsh-20,"End");
        }
        
    //audio   
    if (song)
        {
        draw_set_alpha(0.6);
        for (u=0; u <= tlw; u++)
            {
            nearesti = round((tlx+u*tlzoom/tlw)/projectfps*60)*3;
            
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
        }
        
    //markers
    draw_set_alpha(0.7);
    draw_set_colour(c_fuchsia);
    for (i = 0; i < ds_list_size(marker_list); i++)
        {
        if (ds_list_find_value(marker_list,i) == clamp(ds_list_find_value(marker_list,i),tlx,tlx+tlzoom))
            {
            var markerpostemp = (ds_list_find_value(marker_list,i)-tlx)*tlwdivtlzoom;
            draw_rectangle(markerpostemp,0,markerpostemp+1,tlh-1,0);
            draw_rectangle(markerpostemp,tlh+17,markerpostemp+1,lbsh,0);
            }
        }

    draw_set_alpha(0.3);
    draw_set_colour(c_black);
    draw_rectangle(0,0,clamp(startframex,0,tlw+1),lbsh,0);
    draw_rectangle(clamp(endframex,0,tlw+1),0,tlw+1,lbsh,0);
    
    draw_set_alpha(1);
    draw_set_colour(c_white);
        
surface_reset_target();
draw_set_color(c_white);
draw_set_font(fnt_tooltip);
