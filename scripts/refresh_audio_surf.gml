//redraws the surface containing the layer list and audio visualization in the timeline mode

if (!surface_exists(audio_surf))
    audio_surf = surface_create(1024,1024);
    
surface_set_target(audio_surf);

    var tlwdivtlzoom = tlw/tlzoom;   

    draw_clear_alpha(c_white,0);
    draw_set_alpha(1);
    draw_set_font(fnt_small);
    draw_enable_alphablend(0);
    
    //layers
    //NB: layerbarx is an Y value
    
    draw_set_colour(c_black);
    var tempstarty = tlh+16-layerbarx;
    var ypos = tempstarty;
    var mouseoverlayerbutton_hor = (mouse_x == clamp(mouse_x,tlw-56,tlw-24));
    for (i = 0; i <= ds_list_size(layer_list);i++)
        {
        if (i == ds_list_size(layer_list))
            {
            if (ypos > tlh+16-48) and (ypos < lbsh)
                draw_sprite(spr_addlayer,
                            mouseoverlayerbutton_hor && (mouse_y == clamp(mouse_y,138+ypos+8,138+ypos+40)),
                            tlw-56,ypos+8);
            break;
            }
            
        layer = ds_list_find_value(layer_list, i);
        
        if (ypos > tlh+16-48) and (ypos < lbsh)
            {
            if (i == ds_list_size(layer_list))
                {
                draw_sprite(spr_addlayer,
                            mouseoverlayerbutton_hor && (mouse_y == clamp(mouse_y,138+ypos+8,138+ypos+40)),
                            tlw-56,ypos+8);
                break;
                }
                            
            draw_rectangle_colour(-1,ypos,tlw-16,ypos+48,c_white,c_white,c_silver,c_silver,0);
            draw_rectangle(-1,ypos,tlw-16,ypos+48,1);
            
            for (j = 1; j < ds_list_size(layer); j++)
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
                    if (ds_list_find_index(somaster_list,objectlist) != -1)
                        {
                        draw_set_colour(c_gold);
                        draw_enable_alphablend(1);
                        draw_set_alpha(0.3);
                            draw_rectangle(framestartx,ypos,frameendx,ypos+48,0);
                        draw_set_alpha(1);
                        draw_enable_alphablend(0);
                        draw_set_colour(c_black);
                        }
                    }
                }
                
            var mouse_on_button_ver = (mouse_y == clamp(mouse_y,138+ypos+8,138+ypos+40));
            draw_sprite(spr_deletelayer,
                            mouse_on_button_ver and (mouse_x == clamp(mouse_x,tlw-56,tlw-24)),
                            tlw-56,ypos+8);
            draw_sprite(spr_addenvelope,
                            mouse_on_button_ver and (mouse_x == clamp(mouse_x,tlw-96,tlw-64)),
                            tlw-96,ypos+8);
                            
            if (selectedlayer == i)
                {
                draw_set_colour(180);
                var drawcursorxcorrected = (selectedx-tlx)/tlzoom*tlw;
                if (drawcursorxcorrected == clamp(drawcursorxcorrected,0,tlw))
                    draw_line(drawcursorxcorrected,ypos,drawcursorxcorrected,ypos+48);
                draw_set_colour(c_black);
                }
            }
                        
        ypos += 48;
        
        //envelopes
        envelope_list = ds_list_find_value(layer, 0);
        for (j = 0; j < ds_list_size(envelope_list); j++)
            {
            if (ypos > tlh+16-64) and (ypos < lbsh)
                {
                envelope = ds_list_find_value(envelope_list,j);
                type = ds_list_find_value(envelope,0);
                draw_set_colour(c_white);
                draw_rectangle(-1,ypos,tlw-16,ypos+64,0);
                draw_set_colour(c_black);
                draw_rectangle(-1,ypos,tlw-16,ypos+64,1);
                mouse_on_button_ver = (mouse_y == clamp(mouse_y,138+8+ypos,138+40+ypos));
                draw_sprite(spr_deletelayer,
                            mouse_on_button_ver and (mouse_x == clamp(mouse_x,tlw-56,tlw-24)),
                            tlw-56,ypos+8);
                draw_sprite(spr_menu,
                            mouse_on_button_ver and (mouse_x == clamp(mouse_x,tlw-96,tlw-64)),
                            tlw-96,ypos+8);
                }
            ypos += 64;
            }
    }
    
    draw_enable_alphablend(1);
    
    draw_set_colour(c_white);
    draw_set_blend_mode(bm_subtract);
    draw_rectangle(-1,-1,tlw+16,tlh+16,0);
    draw_rectangle(-1,lbh+tlh+16,tlw+16,lbh+tlh+33,0);
    draw_set_blend_mode(bm_normal);
       
    var drawtime = ceil(tlx/projectfps);
    if (tlwdivtlzoom > 0.3) modulus = 5;
    else if (tlwdivtlzoom > 0.05) modulus = 25;
    else modulus = 60;
    
    draw_set_colour(c_ltgray);
    draw_enable_alphablend(0);
    while (1)
        {
        var tempx = (drawtime*projectfps-tlx)*tlwdivtlzoom;
        if (tempx > tlw)
            break;

        if ((drawtime mod modulus) == 0)
            {
            //draw timestamp
            draw_set_colour(c_gray);
                draw_line(tempx,0,tempx,tlh-1);
            draw_set_halign(fa_center);
            draw_set_valign(fa_center);
            draw_set_colour(c_dkgray);
            draw_text(tempx,tlh+9,string_replace(string_format(floor(drawtime/60),2,0)," ","0")+
                                ":"+string_replace(string_format(drawtime %60,2,0)," ","0"));
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_set_colour(c_ltgray);
            }
        else
            {
            if ((drawtime % (modulus/5)) == 0)
                draw_line(tempx,0,tempx,tlh-1);
            }
        drawtime++;
        }
    
    
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
    draw_enable_alphablend(1);   
    
    //audio   
    if (song)
        {
        draw_set_alpha(0.7);
        for (u=0; u <= tlw; u++)
            {
            var nearesti = round((tlx+u*tlzoom/tlw)/projectfps*60)*3;
            
            if (nearesti > ds_list_size(audio_list)-3)
                break;
                
            var v_tlhalf = tlhalf;
            var v_tlthird = tlthird;
                
            var v = ds_list_find_value(audio_list,nearesti);
            draw_set_color(c_green);
            draw_line(u,v_tlhalf+v*v_tlthird,u,v_tlhalf-v*v_tlthird);
            
            v = ds_list_find_value(audio_list,nearesti+1);
            draw_set_color(c_red);
            draw_line(u,v_tlhalf+v*v_tlthird,u,v_tlhalf-v*v_tlthird);
            
            v = ds_list_find_value(audio_list,nearesti+2);
            draw_set_color(c_blue);
            draw_line(u,v_tlhalf+v*tlthird,u,v_tlhalf-v*v_tlthird);    
            }
        }
        
    //markers
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
        
    //scope fog
    draw_set_alpha(0.6);
    draw_set_colour(c_black);
    draw_rectangle(0,0,clamp(startframex,0,tlw+1),lbsh,0);
    draw_rectangle(clamp(endframex,0,tlw+1),0,tlw+1,lbsh,0);
    draw_set_alpha(1);
    
    draw_enable_alphablend(0);
    //scroll
    var scrollx_x1 = scrollbarx+1;
    var scrollx_x2 = scrollx_x1+scrollbarw;
    var scrollx_y1 = lbsh+17;
    var scrolly_x1 = tlw-16;
    var scrolly_y1 = tls+(layerbarx*layerbarw/lbh)-138;
    var scrolly_y2 = scrolly_y1+layerbarw;
    draw_set_colour(c_gray);
    draw_rectangle(scrollx_x1,scrollx_y1,scrollx_x2,lbsh,0);
    draw_rectangle(scrolly_x1,scrolly_y1,tlw,scrolly_y2,0);
    draw_set_colour(c_black);
    draw_rectangle(scrollx_x1,scrollx_y1,scrollx_x2,lbsh,1);
    draw_rectangle(scrolly_x1,scrolly_y1,tlw,scrolly_y2,1);
    draw_enable_alphablend(1);
    
    //draw_set_alpha(1);
    //draw_set_colour(c_white);
        
surface_reset_target();
//draw_set_color(c_white);
draw_set_font(fnt_tooltip);
