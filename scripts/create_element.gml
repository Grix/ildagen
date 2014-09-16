//creates an element from whatever has been done on the screen

placing_status = 0;

if (maxframes == 1) and (anienable)
    {
    maxframes = 64;
    
    if (ds_list_size(controller.frame_list) < controller.maxframes)
        repeat (controller.maxframes - ds_list_size(controller.frame_list))
            {
            templist = ds_list_create();
            ds_list_copy(templist,ds_list_find_value(controller.frame_list,ds_list_size(controller.frame_list)-1))
            tempsurflist = ds_list_create();
            ds_list_copy(tempsurflist,ds_list_find_value(controller.surf_frame_list,ds_list_size(controller.surf_frame_list)-1))
            ds_list_add(controller.frame_list,templist);
            ds_list_add(controller.surf_frame_list,tempsurflist);
            }
    }


if (!keyboard_check(vk_shift))
    {
    endx = mouse_x;
    endy = mouse_y;
    }
else
    {
    if (point_direction(startpos[0],startpos[1],mouse_x,mouse_y) > 315) || (point_direction(startpos[0],startpos[1],mouse_x,mouse_y) < 45) || ( (point_direction(startpos[0],startpos[1],mouse_x,mouse_y) > 135) && (point_direction(startpos[0],startpos[1],mouse_x,mouse_y) < 225) )
        {
        endx = mouse_x;
        endy = startpos[1];
        }
    else
        {
        endx = startpos[0];
        endy = mouse_y;
        }
    if (placing == "rect")
        {
        //if ( (startpos[0]-mouse_x) > (startpos[1]-(512-mouse_y)) )
            {
            endx = mouse_x;
            endy = startpos[1]-(mouse_x-startpos[0]);
            }
        /*else
            {
            endy = -mouse_y-startpos[1]+512;
            endy = 512-mouse_y;
            }*/
        }
    }
    
framepre = frame;
frame = 0;
repeat (maxframes)
    {
    
    new_list = ds_list_create();
    
    ds_list_add(new_list,startpos[0]*128); //origo x
    ds_list_add(new_list,startpos[1]*128); //origo y
    ds_list_add(new_list,endx*128); //end x
    ds_list_add(new_list,endy*128); //end y
    ds_list_add(new_list,0);
    ds_list_add(new_list,0);
    ds_list_add(new_list,0);
    ds_list_add(new_list,0);
    ds_list_add(new_list,0);
    ds_list_add(new_list,el_id);
    
    if (anienable == 0) or (maxframes == 1)
        {
        blank_freq_r = blank_freq;
        blank_period_r = blank_period;
        blank_dc_r = blank_dc;
        blank_offset_r = degtorad(blank_offset);
        color_freq_r = color_freq;
        color_period_r = color_period;
        color_dc_r = color_dc;
        color_offset_r = degtorad(color_offset);
        color1_r = color1;
        color2_r = color2;
        enddotscolor_r = enddotscolor;
        wave_period_r = wave_period;
        wave_offset_r = degtorad(wave_offset);
        wave_amp_r = wave_amp;
        }
    else
        {
        blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,frame/maxframes);
        blank_period_r = blank_period//lerp(blank_period,aniblank_period,frame/maxframes);
        blank_dc_r = lerp(blank_dc,aniblank_dc,frame/(maxframes));
        blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,frame/(maxframes)));
        color_freq_r = color_freq//lerp(color_freq,anicolor_freq,frame/maxframes);
        color_period_r = color_period//lerp(color_period,anicolor_period,frame/maxframes);
        color_dc_r = lerp(color_dc,anicolor_dc,frame/maxframes);
        color_offset_r = degtorad(lerp(color_offset,anicolor_offset,frame/(maxframes)));
        wave_period_r = wave_period//lerp(color_period,anicolor_period,frame/maxframes);
        wave_amp_r = wave_amp//lerp(color_dc,anicolor_dc,frame/maxframes);
        wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,frame/(maxframes)));
        color1_r = merge_color(color1,anicolor1,frame/(maxframes));
        color2_r = merge_color(color2,anicolor2,frame/(maxframes));
        enddotscolor_r = merge_color(enddotscolor,anienddotscolor,frame/maxframes);
        }
    
    if (placing == "line") //create a line
        create_line();
        
    else if (placing == "circle") //create a circle
        create_circle();
        
    if (placing == "wave") //create a wave
        create_wave();
        
    else if (placing == "rect") //create a rectangle (not working)
        create_rect();
        
    
    ds_list_add(ds_list_find_value(frame_list,frame),new_list);
    
    
    surf = surface_create(512,512);
    surface_set_target(surf);
        draw_clear_alpha(c_white,0);
        xo = ds_list_find_value(new_list,0)/128;
        yo = ds_list_find_value(new_list,1)/128;
        
        //TODO if just one
        
        for (u = 0; u < (((ds_list_size(new_list)-10)/6)-1); u++)
            {
            xp = ds_list_find_value(new_list,10+u*6+0);
            yp = ds_list_find_value(new_list,10+u*6+1);
            bl = ds_list_find_value(new_list,10+u*6+2);
            b = ds_list_find_value(new_list,10+u*6+3);
            g = ds_list_find_value(new_list,10+u*6+4);
            r = ds_list_find_value(new_list,10+u*6+5);
            
            nxp = ds_list_find_value(new_list,10+(u+1)*6+0);
            nyp = ds_list_find_value(new_list,10+(u+1)*6+1);
            nbl = ds_list_find_value(new_list,10+(u+1)*6+2);
            nb = ds_list_find_value(new_list,10+(u+1)*6+3);
            ng = ds_list_find_value(new_list,10+(u+1)*6+4);
            nr = ds_list_find_value(new_list,10+(u+1)*6+5);
            
            if (nbl == 0)
                {
                draw_set_color(make_colour_rgb(nr,ng,nb));
                if (xp == nxp) && (yp == nyp)
                    {
                    draw_rectangle(xo+xp/128-1,yo+yp/128-1,xo+xp/128+1,yo+yp/128+1,0);
                    }
                else
                    draw_line(xo+ xp/128,yo+ yp/128,xo+ nxp/128,yo+ nyp/128);
                }
            
            }
    surface_reset_target();
    
    ds_list_empty(new_list);
    ds_list_add(ds_list_find_value(surf_frame_list,frame),surf);
    
    frame++;
    }
frame = framepre;

ds_stack_push(undo_list,el_id);
el_id++;
