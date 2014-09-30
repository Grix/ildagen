//creates an element from whatever has been done on the screen

placing_status = 0;


if (maxframes == 1) and (anienable)
    {
    maxframes = 32;
    
    if (ds_list_size(controller.frame_list) < controller.maxframes)
        repeat (controller.maxframes - ds_list_size(controller.frame_list))
            {
            templist = ds_list_create();
            if (fillframes)
                ds_list_copy(templist,ds_list_find_value(controller.frame_list,ds_list_size(controller.frame_list)-1))
            ds_list_add(controller.frame_list,templist);
            }
    }


if (!keyboard_check(vk_shift))
    {
    endx = obj_cursor.x;
    endy = obj_cursor.y;
    }
else
    {
    if (point_direction(startpos[0],startpos[1],mouse_x,mouse_y) > 315) || (point_direction(startpos[0],startpos[1],mouse_x,mouse_y) < 45) || ( (point_direction(startpos[0],startpos[1],mouse_x,mouse_y) > 135) && (point_direction(startpos[0],startpos[1],mouse_x,mouse_y) < 225) )
        {
        endx = obj_cursor.x;
        endy = startpos[1];
        }
    else
        {
        endx = startpos[0];
        endy = obj_cursor.y;
        }
    }
    
if (!fillframes)
    {
    new_list = ds_list_create();
    
    if (placing != "curve")
        {
        ds_list_add(new_list,startpos[0]*128); //origo x
        ds_list_add(new_list,startpos[1]*128); //origo y
        ds_list_add(new_list,endx*128); //end x
        ds_list_add(new_list,endy*128); //end y
        }
    else
        {
        ds_list_add(new_list,ds_list_find_value(bez_list,0)*128); //origo x
        ds_list_add(new_list,ds_list_find_value(bez_list,1)*128); //origo y
        ds_list_add(new_list,ds_list_find_value(bez_list,6)*128); //end x
        ds_list_add(new_list,ds_list_find_value(bez_list,7)*128); //end y
        }
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
        t = frame/maxframes;
        if (anifunc = "tri")
            {
            t *= 2;
            if (t > 1)
                t = 1-(t%1);
            blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,t);
            blank_period_r = blank_period//lerp(blank_period,aniblank_period,t);
            blank_dc_r = lerp(blank_dc,aniblank_dc,t);
            blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,t));
            color_freq_r = color_freq//lerp(color_freq,anicolor_freq,t);
            color_period_r = color_period//lerp(color_period,anicolor_period,t);
            color_dc_r = lerp(color_dc,anicolor_dc,t);
            color_offset_r = degtorad(lerp(color_offset,anicolor_offset,t));
            wave_period_r = wave_period//lerp(color_period,anicolor_period,t);
            wave_amp_r = wave_amp//lerp(color_dc,anicolor_dc,t);
            wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
            color1_r = merge_color(color1,anicolor1,t);
            color2_r = merge_color(color2,anicolor2,t);
            enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
            }
        else if (anifunc = "sine")
            {
            blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,sin(t*pi/2));
            blank_period_r = blank_period//lerp(blank_period,aniblank_period,sin(t*pi/2));
            blank_dc_r = lerp(blank_dc,aniblank_dc,sin(t*pi/2));
            blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,sin(t*pi/2)));
            color_freq_r = color_freq//lerp(color_freq,anicolor_freq,sin(t*pi/2));
            color_period_r = color_period//lerp(color_period,anicolor_period,sin(t*pi/2));
            color_dc_r = lerp(color_dc,anicolor_dc,sin(t*pi/2));
            color_offset_r = degtorad(lerp(color_offset,anicolor_offset,sin(t*pi/2)));
            wave_period_r = wave_period//lerp(color_period,anicolor_period,sin(t*pi/2));
            wave_amp_r = wave_amp//lerp(color_dc,anicolor_dc,sin(t*pi/2));
            wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,sin(t*pi/2)));
            color1_r = merge_color(color1,anicolor1,sin(t*pi/2));
            color2_r = merge_color(color2,anicolor2,sin(t*pi/2));
            enddotscolor_r = merge_color(enddotscolor,anienddotscolor,sin(t*pi/2));
            }
        else if (anifunc = "hsine")
            {
            blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,sin(t*pi));
            blank_period_r = blank_period//lerp(blank_period,aniblank_period,sin(t*pi));
            blank_dc_r = lerp(blank_dc,aniblank_dc,sin(t*pi));
            blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,sin(t*pi)));
            color_freq_r = color_freq//lerp(color_freq,anicolor_freq,sin(t*pi));
            color_period_r = color_period//lerp(color_period,anicolor_period,sin(t*pi));
            color_dc_r = lerp(color_dc,anicolor_dc,sin(t*pi));
            color_offset_r = degtorad(lerp(color_offset,anicolor_offset,sin(t*pi)));
            wave_period_r = wave_period//lerp(color_period,anicolor_period,sin(t*pi));
            wave_amp_r = wave_amp//lerp(color_dc,anicolor_dc,sin(t*pi));
            wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,sin(t*pi)));
            color1_r = merge_color(color1,anicolor1,sin(t*pi));
            color2_r = merge_color(color2,anicolor2,sin(t*pi));
            enddotscolor_r = merge_color(enddotscolor,anienddotscolor,sin(t*pi));
            }
        else if (anifunc = "saw")
            {
            blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,t);
            blank_period_r = blank_period//lerp(blank_period,aniblank_period,t);
            blank_dc_r = lerp(blank_dc,aniblank_dc,t);
            blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,t));
            color_freq_r = color_freq//lerp(color_freq,anicolor_freq,t);
            color_period_r = color_period//lerp(color_period,anicolor_period,t);
            color_dc_r = lerp(color_dc,anicolor_dc,t);
            color_offset_r = degtorad(lerp(color_offset,anicolor_offset,t));
            wave_period_r = wave_period//lerp(color_period,anicolor_period,t);
            wave_amp_r = wave_amp//lerp(color_dc,anicolor_dc,t);
            wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
            color1_r = merge_color(color1,anicolor1,t);
            color2_r = merge_color(color2,anicolor2,t);
            enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
            }
        }
    
    if (placing == "line") //create a line
        create_line();
        
    else if (placing == "circle") //create a circle
        create_circle();
        
    else if (placing == "wave") //create a wave
        create_wave();
        
    else if (placing == "rect") //create a rectangle (not working)
        create_rect();

    else if (placing == "free") //create a free drawn shape
        create_free();
        
    else if (placing == "curve") //create a curve
        create_curve();
        
    
    ds_list_add(ds_list_find_value(frame_list,frame),new_list);
    
    }
else
    {
    framepre = frame;
    frame = 0;
    repeat (maxframes)
        {
        
        new_list = ds_list_create();
        
        if (placing != "curve")
            {
            ds_list_add(new_list,startpos[0]*128); //origo x
            ds_list_add(new_list,startpos[1]*128); //origo y
            ds_list_add(new_list,endx*128); //end x
            ds_list_add(new_list,endy*128); //end y
            }
        else
            {
            ds_list_add(new_list,ds_list_find_value(bez_list,0)*128); //origo x
            ds_list_add(new_list,ds_list_find_value(bez_list,1)*128); //origo y
            ds_list_add(new_list,ds_list_find_value(bez_list,6)*128); //end x
            ds_list_add(new_list,ds_list_find_value(bez_list,7)*128); //end y
            }
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
            t = frame/maxframes;
            if (anifunc = "tri")
                {
                t *= 2;
                if (t > 1)
                    t = 1-(t%1)
                blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,t);
                blank_period_r = blank_period//lerp(blank_period,aniblank_period,t);
                blank_dc_r = lerp(blank_dc,aniblank_dc,t);
                blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,t));
                color_freq_r = color_freq//lerp(color_freq,anicolor_freq,t);
                color_period_r = color_period//lerp(color_period,anicolor_period,t);
                color_dc_r = lerp(color_dc,anicolor_dc,t);
                color_offset_r = degtorad(lerp(color_offset,anicolor_offset,t));
                wave_period_r = wave_period//lerp(color_period,anicolor_period,t);
                wave_amp_r = wave_amp//lerp(color_dc,anicolor_dc,t);
                wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
                color1_r = merge_color(color1,anicolor1,t);
                color2_r = merge_color(color2,anicolor2,t);
                enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
                }
            else if (anifunc = "sine")
                {
                blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,sin(t*pi/2));
                blank_period_r = blank_period//lerp(blank_period,aniblank_period,sin(t*pi/2));
                blank_dc_r = lerp(blank_dc,aniblank_dc,sin(t*pi/2));
                blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,sin(t*pi/2)));
                color_freq_r = color_freq//lerp(color_freq,anicolor_freq,sin(t*pi/2));
                color_period_r = color_period//lerp(color_period,anicolor_period,sin(t*pi/2));
                color_dc_r = lerp(color_dc,anicolor_dc,sin(t*pi/2));
                color_offset_r = degtorad(lerp(color_offset,anicolor_offset,sin(t*pi/2)));
                wave_period_r = wave_period//lerp(color_period,anicolor_period,sin(t*pi/2));
                wave_amp_r = wave_amp//lerp(color_dc,anicolor_dc,sin(t*pi/2));
                wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,sin(t*pi/2)));
                color1_r = merge_color(color1,anicolor1,sin(t*pi/2));
                color2_r = merge_color(color2,anicolor2,sin(t*pi/2));
                enddotscolor_r = merge_color(enddotscolor,anienddotscolor,sin(t*pi/2));
                }
            else if (anifunc = "hsine")
                {
                blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,sin(t*pi));
                blank_period_r = blank_period//lerp(blank_period,aniblank_period,sin(t*pi));
                blank_dc_r = lerp(blank_dc,aniblank_dc,sin(t*pi));
                blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,sin(t*pi)));
                color_freq_r = color_freq//lerp(color_freq,anicolor_freq,sin(t*pi));
                color_period_r = color_period//lerp(color_period,anicolor_period,sin(t*pi));
                color_dc_r = lerp(color_dc,anicolor_dc,sin(t*pi));
                color_offset_r = degtorad(lerp(color_offset,anicolor_offset,sin(t*pi)));
                wave_period_r = wave_period//lerp(color_period,anicolor_period,sin(t*pi));
                wave_amp_r = wave_amp//lerp(color_dc,anicolor_dc,sin(t*pi));
                wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,sin(t*pi)));
                color1_r = merge_color(color1,anicolor1,sin(t*pi));
                color2_r = merge_color(color2,anicolor2,sin(t*pi));
                enddotscolor_r = merge_color(enddotscolor,anienddotscolor,sin(t*pi));
                }
            else if (anifunc = "saw")
                {
                blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,t);
                blank_period_r = blank_period//lerp(blank_period,aniblank_period,t);
                blank_dc_r = lerp(blank_dc,aniblank_dc,t);
                blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,t));
                color_freq_r = color_freq//lerp(color_freq,anicolor_freq,t);
                color_period_r = color_period//lerp(color_period,anicolor_period,t);
                color_dc_r = lerp(color_dc,anicolor_dc,t);
                color_offset_r = degtorad(lerp(color_offset,anicolor_offset,t));
                wave_period_r = wave_period//lerp(color_period,anicolor_period,t);
                wave_amp_r = wave_amp//lerp(color_dc,anicolor_dc,t);
                wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
                color1_r = merge_color(color1,anicolor1,t);
                color2_r = merge_color(color2,anicolor2,t);
                enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
                }
            }
        
        if (placing == "line") //create a line
            create_line();
            
        else if (placing == "circle") //create a circle
            create_circle();
            
        else if (placing == "wave") //create a wave
            create_wave();
            
        else if (placing == "rect") //create a rectangle (not working)
            create_rect();
    
        else if (placing == "free") //create a free drawn shape
            create_free();
            
        else if (placing == "curve") //create a bezier curve
            create_curve();
            
        
        ds_list_add(ds_list_find_value(frame_list,frame),new_list);
        
        frame++;
        }
        
    frame = framepre;
    }

refresh_surfaces();

ds_list_clear(bez_list);
ds_list_clear(free_list);
ds_stack_push(undo_list,el_id);
el_id++;
