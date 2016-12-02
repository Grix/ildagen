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
    var ypos = floor(tempstarty);
    ypos_perm = 0;
    var mouseoverlayerbutton_hor = (mouse_x == clamp(mouse_x,tlw-56,tlw-24));
    for (i = 0; i <= ds_list_size(layer_list);i++)
    {
        if (i == ds_list_size(layer_list))
        {
            if (ypos > tlh+16-48) and (ypos < lbsh)
                draw_sprite(spr_addlayer,
                            mouseoverlayerbutton_hor and (mouse_y == clamp(mouse_y,138+ypos+8,138+ypos+40)),
                            tlw-56,ypos+8);
            ypos_perm += 48;
            break;
        }
            
        layer = ds_list_find_value(layer_list, i);
        
        if (ypos > tlh+16-48) and (ypos < lbsh)
        {
            if (i == ds_list_size(layer_list))
            {
                draw_sprite(spr_addlayer,
                            mouseoverlayerbutton_hor and (mouse_y == clamp(mouse_y,138+ypos+8,138+ypos+40)),
                            tlw-56,ypos+8);
                ypos_perm += 48;
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
                    framestartx = floor((frametime-tlx)*tlwdivtlzoom);
                    frameendx = ceil((frametime-tlx+duration+1)*tlwdivtlzoom);
                    draw_set_colour(c_dkgray);
                        draw_rectangle(framestartx,ypos+1,frameendx,ypos+47,0);
                    draw_set_colour(c_green);
                        draw_rectangle(framestartx,ypos+1,frameendx,ypos+47,1);
                    draw_set_colour(c_white);
                    if (!surface_exists(infolist[| 1]))
                        infolist[| 1] = make_screenshot(objectlist[| 1]);
                    draw_surface_part(infolist[| 1],0,0,floor(clamp((duration+1)*tlwdivtlzoom,0,32))-1,32,framestartx+1,ypos+8);
                    maxframes = infolist[| 2];
                    draw_set_colour(c_black);
                    if (maxframes != 1)
                        for (k = 1; k <= duration/maxframes; k++)
                        {
                            linex = floor(framestartx+k*maxframes*tlwdivtlzoom);
                            draw_line(linex,ypos,linex,ypos+48);
                        }
                    if (ds_list_find_index(somaster_list,objectlist) != -1)
                    {
                        draw_set_colour(c_gold);
                        draw_enable_alphablend(1);
                        draw_set_alpha(0.3);
                            draw_rectangle(framestartx,ypos+1,frameendx,ypos+47,0);
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
        ypos_perm += 48;
        
        //envelopes
        envelope_list = ds_list_find_value(layer, 0);
        for (j = 0; j < ds_list_size(envelope_list); j++)
        {
            if (ypos > tlh+16-64) and (ypos < lbsh)
            {
                envelope = ds_list_find_value(envelope_list,j);
                type = ds_list_find_value(envelope,0);
                disabled = ds_list_find_value(envelope,3);
                hidden = ds_list_find_value(envelope,4);
                if (!disabled)
                    draw_set_colour(c_white);
                else
                    draw_set_colour(c_gray);
                if (!hidden)
                {
                    draw_rectangle(-1,ypos,tlw-16,ypos+64,0);
                    draw_set_colour(c_ltgray);
                    draw_line(-1,ypos+32,tlw-60,ypos+32);
                    draw_set_colour(c_black);
                    draw_rectangle(-1,ypos,tlw-16,ypos+64,1);
                }
                else
                {
                    draw_rectangle(-1,ypos,tlw-16,ypos+16,0);
                    draw_set_colour(c_black);
                    draw_rectangle(-1,ypos,tlw-16,ypos+16,1);
                    
                    var typedraw = ds_map_find_value(env_type_map,type);
                    var t_stringlength = string_width(typedraw)+5;
                    var t_stringx = tlw-25-t_stringlength-5;
                    draw_set_colour($eeeeee);
                    draw_rectangle(t_stringx,ypos+1,t_stringx+t_stringlength+5,ypos+15,0);
                    draw_set_colour($bbbbbb);
                    draw_rectangle(t_stringx,ypos+1,t_stringx+t_stringlength+5,ypos+15,1);
                            
                    draw_set_colour(c_black);
                    draw_enable_alphablend(1);
                    draw_text(t_stringx+5, ypos+2, typedraw);
                    draw_enable_alphablend(0);
                    
                    ypos += 16;
                    ypos_perm += 16;
                    continue;
                }
                
                //drawing envelope data
                time_list = ds_list_find_value(envelope,1);
                data_list = ds_list_find_value(envelope,2);
                var default_value = ypos+32;
                if (type != "x") and (type != "y") and (type != "hue")
                    default_value = ypos;
                draw_set_colour(c_green);
                if (ds_list_size(time_list))
                {
                    //binary search algo, set t_index to the list index just before visible area
                    var imin = 0;
                    var imax = ds_list_size(time_list)-1;
                    var imid;
                    while (imin <= imax)
                    {
                        imid = floor(mean(imin,imax));
                        if (ds_list_find_value(time_list,imid) <= tlx)
                        {
                            var valnext = ds_list_find_value(time_list,imid+1);
                            if (is_undefined(valnext)) or (valnext > tlx)
                                break;
                            else
                                imin = imid+1;
                        }
                        else
                            imax = imid-1;
                    }
                    var t_index = imid;
                    var t_env_y;
                    var t_env_x;
                    //draw envelope graph
                    while ( (ds_list_find_value(time_list,t_index)-tlx) < tlzoom)
                    {
                        t_env_y = ypos+ds_list_find_value(data_list,t_index);
                        t_env_x = (ds_list_find_value(time_list,t_index)-tlx)*tlwdivtlzoom;
                        if (t_index == ds_list_size(time_list)-1)
                        {
                            if (t_index == 0)
                            {
                                draw_line( -1, t_env_y, tlw-16, t_env_y);
                                draw_rectangle( t_env_x-1,t_env_y-1,t_env_x+1,t_env_y+1,0);
                                break;
                            }
                            draw_line(  t_env_x,t_env_y,tlw-16, t_env_y);
                            draw_rectangle( t_env_x-1,t_env_y-1,t_env_x+1,t_env_y+1,0);
                            break;
                        }
                        else if (t_index == 0)
                            draw_line(  -1, t_env_y, t_env_x, t_env_y);
                        draw_line(  t_env_x, t_env_y,
                                    (ds_list_find_value(time_list,t_index+1)-tlx)*tlwdivtlzoom,
                                    ypos+ds_list_find_value(data_list,t_index+1));
                        draw_rectangle( t_env_x-1,t_env_y-1,t_env_x+1,t_env_y+1,0);
                        t_index++;
                    }
                }
                else
                {
                    draw_line(-1,default_value,tlw-16,default_value);
                }
                if (moving_object == 6) and (envelopetoedit == envelope)
                    {
                        draw_set_colour(c_green);
                        draw_line(mousexprev,mouseyprev-138,mouse_x,mouse_y-138);
                    }
                    
                var typedraw = ds_map_find_value(env_type_map,type);
                var t_stringlength = string_width(typedraw)+5;
                var t_stringx = tlw-25-t_stringlength-5;
                draw_set_colour($eeeeee);
                draw_rectangle(t_stringx,ypos+42,t_stringx+t_stringlength+5,ypos+60,0);
                draw_set_colour($bbbbbb);
                draw_rectangle(t_stringx,ypos+42,t_stringx+t_stringlength+5,ypos+60,1);
                        
                draw_set_colour(c_black);
                draw_enable_alphablend(1);
                    draw_text(t_stringx+5, ypos+45, typedraw);
                    if (moving_object == 7) and (envelopetoedit == envelope)
                    {
                        draw_set_colour(c_red);
                        draw_set_alpha(0.3);
                        draw_rectangle(mousexprev,ypos,mouse_x,ypos+64,0);
                        draw_set_colour(c_black);
                        draw_set_alpha(1);
                    }
                draw_enable_alphablend(0);
                mouse_on_button_ver = (mouse_y == clamp(mouse_y,138+8+ypos,138+40+ypos));
                draw_sprite(spr_deletelayer,
                            mouse_on_button_ver and (mouse_x == clamp(mouse_x,tlw-56,tlw-24)),
                            tlw-56,ypos+8);
            }
            ypos += 64;
            ypos_perm += 64;
        }
}
    
    scrollbarw = clamp(((tlzoom+18)/length)*tlw-18,32,tlw-18);
    if (length != tlzoom)
        scrollbarx = (tlw-18-scrollbarw)*(tlx)/(length-tlzoom);
    layerbarw = clamp(lbh/(ypos_perm+lbh)*(lbh-1),32,lbh-1);
    
    draw_enable_alphablend(1);
    
    draw_set_colour(c_white);
    draw_set_blend_mode(bm_subtract);
    draw_rectangle(-1,-1,tlw,tlh+16,0);
    draw_rectangle(-1,lbh+tlh+16,tlw,lbh+tlh+33,0);
    draw_set_blend_mode(bm_normal);
       
    var drawtime = ceil(tlx/projectfps);
    if (tlwdivtlzoom > 0.3) modulus = 5;
    else if (tlwdivtlzoom > 0.05) modulus = 25;
    else modulus = 60;
    
    draw_set_colour(c_ltgray);
    draw_enable_alphablend(0);
    while (1)
    {
        var tempx = round((drawtime*projectfps-tlx)*tlwdivtlzoom);
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
    if (startframex == clamp(startframex,0,tlw-16))
    {
        draw_set_color(c_blue);
        draw_rectangle(startframex,0,startframex+1,tlh-1,0);
        draw_rectangle(startframex,tlh+17,startframex+1,lbsh,0);
        draw_set_font(fnt_bold);
        draw_text(startframex+4,lbsh-20,"Start");
    }

    endframex = (endframe-tlx)*tlwdivtlzoom;
    if (endframex == clamp(endframex,0,tlw-16))
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
    if (startframex > 0)
        draw_rectangle(0,0,clamp(startframex,0,tlw-16),lbsh,0);
    if (endframex < tlw)
    {
        draw_rectangle(clamp(endframex,tlw-16,tlw),0,tlw,tlh+16,0);
        if (endframex < tlw-16)
            draw_rectangle(clamp(endframex,0,tlw-16),0,tlw-16,lbsh,0);
    }
    draw_set_alpha(1);
    
    draw_enable_alphablend(0);
    //scroll
    var scrollx_x1 = scrollbarx;
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
