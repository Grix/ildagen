//creates an element from whatever has been done on the screen

placing_status = 0;
        
if (maxframes == 1) and (anienable)
    {
    //ds_stack_push(controller.undo_list,"a"+string(controller.maxframes))
    maxframes = 32;
    scope_end = 31;
    
    if (ds_list_size(frame_list) < maxframes)
        repeat (maxframes - ds_list_size(frame_list))
            {
            templist = ds_list_create();
            if (fillframes)
                {
                tempelcount = ds_list_size(ds_list_find_value(frame_list,ds_list_size(frame_list)-1));
                for (u = 0;u < tempelcount;u++)
                    {
                    tempellist = ds_list_create();
                    ds_list_copy(tempellist,ds_list_find_value(ds_list_find_value(frame_list,ds_list_size(frame_list)-1),u));
                    ds_list_add(templist,tempellist);
                    }
                }
            ds_list_add(frame_list,templist);
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
    
autoresflag = 0;
if (is_string(resolution))
    {
    autoresflag = 1;
    if ((placing == "line") && (blankmode == "solid") && (colormode == "solid"))
        resolution = 3000;
    else
        resolution = 1024;
        
    if (colormode != "solid") or (blankmode != "solid")
        resolution = 512;
    
    if (anienable) and (blankmode != "solid") and ((blank_offset != aniblank_offset) or (blank_dc != aniblank_dc))
        resolution = 256;
    else if (anienable) and (colormode != "solid") and ((color_offset != anicolor_offset) or (color_dc != anicolor_dc))
        resolution = 256;
    }
    
randomize();

if (!fillframes)
    {
    new_list = ds_list_create();
    
    gaussoffsetx = shaking*clamp(random_gaussian(0,shaking_sdev),-shaking_sdev*3,shaking_sdev*3);
    gaussoffsety = shaking*clamp(random_gaussian(0,shaking_sdev),-shaking_sdev*3,shaking_sdev*3);
    
    if (anienable == 0) or (maxframes == 1)
        {
        t = 0;
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
        endx_r = endx;
        endy_r = endy;
        startposx_r = startpos[0];
        startposy_r  = startpos[1];
        }
    else
        {
        t = ((frame-scope_start)/(scope_end-scope_start))%1;
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
            wave_amp_r = lerp(wave_amp,aniwave_amp,t);
            wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
            color1_r = merge_color(color1,anicolor1,t);
            color2_r = merge_color(color2,anicolor2,t);
            enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
            endx_r = endx+gaussoffsetx;
            endy_r = endy+gaussoffsety;
            startposx_r = startpos[0]+gaussoffsetx;
            startposy_r = startpos[1]+gaussoffsety;
            }
        else if (anifunc = "sine")
            {
            t = cos(t*pi*2);
            t *= -1;
            t += 1;
            t /= 2;
            blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,t);
            blank_period_r = blank_period//lerp(blank_period,aniblank_period,t);
            blank_dc_r = lerp(blank_dc,aniblank_dc,t);
            blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,t));
            color_freq_r = color_freq//lerp(color_freq,anicolor_freq,t);
            color_period_r = color_period//lerp(color_period,anicolor_period,t);
            color_dc_r = lerp(color_dc,anicolor_dc,t);
            color_offset_r = degtorad(lerp(color_offset,anicolor_offset,t));
            wave_period_r = wave_period//lerp(color_period,anicolor_period,t);
            wave_amp_r = lerp(wave_amp,aniwave_amp,t);
            wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
            color1_r = merge_color(color1,anicolor1,t);
            color2_r = merge_color(color2,anicolor2,t);
            enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
            endx_r = endx+gaussoffsetx;
            endy_r = endy+gaussoffsety;
            startposx_r = startpos[0]+gaussoffsetx;
            startposy_r = startpos[1]+gaussoffsety;
            }
        else if (anifunc = "ssine")
            {
            t = sin(t*pi/2);
            blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,t);
            blank_period_r = blank_period//lerp(blank_period,aniblank_period,t);
            blank_dc_r = lerp(blank_dc,aniblank_dc,t);
            blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,t));
            color_freq_r = color_freq//lerp(color_freq,anicolor_freq,t);
            color_period_r = color_period//lerp(color_period,anicolor_period,t);
            color_dc_r = lerp(color_dc,anicolor_dc,t);
            color_offset_r = degtorad(lerp(color_offset,anicolor_offset,t));
            wave_period_r = wave_period//lerp(color_period,anicolor_period,t);
            wave_amp_r = lerp(wave_amp,aniwave_amp,t);
            wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
            color1_r = merge_color(color1,anicolor1,t);
            color2_r = merge_color(color2,anicolor2,t);
            enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
            endx_r = endx+gaussoffsetx;
            endy_r = endy+gaussoffsety;
            startposx_r = startpos[0]+gaussoffsetx;
            startposy_r = startpos[1]+gaussoffsety;
            }
        else if (anifunc = "hsine")
            {
            t = sin(t*pi);
            blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,t);
            blank_period_r = blank_period//lerp(blank_period,aniblank_period,t);
            blank_dc_r = lerp(blank_dc,aniblank_dc,t);
            blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,t));
            color_freq_r = color_freq//lerp(color_freq,anicolor_freq,t);
            color_period_r = color_period//lerp(color_period,anicolor_period,t);
            color_dc_r = lerp(color_dc,anicolor_dc,t);
            color_offset_r = degtorad(lerp(color_offset,anicolor_offset,t));
            wave_period_r = wave_period//lerp(color_period,anicolor_period,t);
            wave_amp_r = lerp(wave_amp,aniwave_amp,t);
            wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
            color1_r = merge_color(color1,anicolor1,t);
            color2_r = merge_color(color2,anicolor2,t);
            enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
            endx_r = endx+gaussoffsetx;
            endy_r = endy+gaussoffsety;
            startposx_r = startpos[0]+gaussoffsetx;
            startposy_r = startpos[1]+gaussoffsety;
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
            wave_amp_r = lerp(wave_amp,aniwave_amp,t);
            wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
            color1_r = merge_color(color1,anicolor1,t);
            color2_r = merge_color(color2,anicolor2,t);
            enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
            endx_r = endx+gaussoffsetx;
            endy_r = endy+gaussoffsety;
            startposx_r = startpos[0]+gaussoffsetx;
            startposy_r = startpos[1]+gaussoffsety;
            }
        }

    if (placing == "curve")
        {
        ds_list_add(new_list,ds_list_find_value(bez_list,0)*128); //origo x
        ds_list_add(new_list,ds_list_find_value(bez_list,1)*128); //origo y
        ds_list_add(new_list,ds_list_find_value(bez_list,6)*128); //end x
        ds_list_add(new_list,ds_list_find_value(bez_list,7)*128); //end y
        }
    else if (placing == "text")
        {
        ds_list_add(new_list,(startposx_r+xdelta[frame])*128); //origo x
        ds_list_add(new_list,startposy_r*128); //origo y
        ds_list_add(new_list,(endx_r+xdelta[frame])*128); //end x
        ds_list_add(new_list,endy_r*128); //end y
        }
    else if (placing == "func")
        {
        ds_list_add(new_list,0); //origo x
        ds_list_add(new_list,0); //origo y
        ds_list_add(new_list,0); //end x
        ds_list_add(new_list,0); //end y
        }
    else
        {
        ds_list_add(new_list,startposx_r*128); //origo x
        ds_list_add(new_list,startposy_r*128); //origo y
        ds_list_add(new_list,endx_r*128); //end x
        ds_list_add(new_list,endy_r*128); //end y
        }
    ds_list_add(new_list,0);
    ds_list_add(new_list,0);
    ds_list_add(new_list,0);
    ds_list_add(new_list,0);
    ds_list_add(new_list,0);
    ds_list_add(new_list,el_id);
    
    
    if (placing == "line") //create a line
        create_line();
        
    else if (placing == "circle") //create a circle
        create_circle();
        
    else if (placing == "wave") //create a wave
        create_wave();

    else if (placing == "free") //create a free drawn shape
        create_free();
        
    else if (placing == "curve") //create a curve
        create_curve();
        
    else if (placing == "text") //create a letter/text
        create_letter();
        
    else if (placing == "func") //create a function based shape
        {
        if (!create_func())
            {
            show_message("fail")
            ds_list_clear(bez_list);
            ds_list_clear(free_list);
            ds_stack_push(undo_list,el_id);
            ds_list_destroy(new_list);
            frame = framepre;
            return 0;
            }
        }
    
    ds_list_replace(new_list,4,xmin);
    ds_list_replace(new_list,5,xmax);
    ds_list_replace(new_list,6,ymin);
    ds_list_replace(new_list,7,ymax);
        
    ds_list_add(ds_list_find_value(frame_list,frame),new_list);
    
    }
else
    {
    framepre = frame;
    frame = scope_start;
    repeat (scope_end-scope_start+1)
        {
        
        new_list = ds_list_create();
        
        gaussoffsetx = shaking*clamp(random_gaussian(0,shaking_sdev),-shaking_sdev*3,shaking_sdev*3);
        gaussoffsety = shaking*clamp(random_gaussian(0,shaking_sdev),-shaking_sdev*3,shaking_sdev*3);

        if (anienable == 0) or (maxframes == 1)
            {
            t = 0;
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
            endx_r = endx;
            endy_r = endy;
            startposx_r = startpos[0];
            startposy_r  = startpos[1];
            }
        else
            {
            t = ((frame-scope_start)/(scope_end-scope_start+1))%1;
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
                wave_amp_r = lerp(wave_amp,aniwave_amp,t);
                wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
                color1_r = merge_color(color1,anicolor1,t);
                color2_r = merge_color(color2,anicolor2,t);
                enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
                endx_r = endx+gaussoffsetx;
                endy_r = endy+gaussoffsety;
                startposx_r = startpos[0]+gaussoffsetx;
                startposy_r = startpos[1]+gaussoffsety;
                }
            else if (anifunc = "sine")
                {
                t = cos(t*pi*2);
                t *= -1;
                t += 1;
                t /= 2;
                blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,t);
                blank_period_r = blank_period//lerp(blank_period,aniblank_period,t);
                blank_dc_r = lerp(blank_dc,aniblank_dc,t);
                blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,t));
                color_freq_r = color_freq//lerp(color_freq,anicolor_freq,t);
                color_period_r = color_period//lerp(color_period,anicolor_period,t);
                color_dc_r = lerp(color_dc,anicolor_dc,t);
                color_offset_r = degtorad(lerp(color_offset,anicolor_offset,t));
                wave_period_r = wave_period//lerp(color_period,anicolor_period,t);
                wave_amp_r = lerp(wave_amp,aniwave_amp,t);
                wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
                color1_r = merge_color(color1,anicolor1,t);
                color2_r = merge_color(color2,anicolor2,t);
                enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
                endx_r = endx+gaussoffsetx;
                endy_r = endy+gaussoffsety;
                startposx_r = startpos[0]+gaussoffsetx;
                startposy_r = startpos[1]+gaussoffsety;
                }
            else if (anifunc = "ssine")
                {
                t = sin(t*pi/2);
                blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,t);
                blank_period_r = blank_period//lerp(blank_period,aniblank_period,t);
                blank_dc_r = lerp(blank_dc,aniblank_dc,t);
                blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,t));
                color_freq_r = color_freq//lerp(color_freq,anicolor_freq,t);
                color_period_r = color_period//lerp(color_period,anicolor_period,t);
                color_dc_r = lerp(color_dc,anicolor_dc,t);
                color_offset_r = degtorad(lerp(color_offset,anicolor_offset,t));
                wave_period_r = wave_period//lerp(color_period,anicolor_period,t);
                wave_amp_r = lerp(wave_amp,aniwave_amp,t);
                wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
                color1_r = merge_color(color1,anicolor1,t);
                color2_r = merge_color(color2,anicolor2,t);
                enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
                endx_r = endx+gaussoffsetx;
                endy_r = endy+gaussoffsety;
                startposx_r = startpos[0]+gaussoffsetx;
                startposy_r = startpos[1]+gaussoffsety;
                }
            else if (anifunc = "hsine")
                {
                t = sin(t*pi);
                blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,t);
                blank_period_r = blank_period//lerp(blank_period,aniblank_period,t);
                blank_dc_r = lerp(blank_dc,aniblank_dc,t);
                blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,t));
                color_freq_r = color_freq//lerp(color_freq,anicolor_freq,t);
                color_period_r = color_period//lerp(color_period,anicolor_period,t);
                color_dc_r = lerp(color_dc,anicolor_dc,t);
                color_offset_r = degtorad(lerp(color_offset,anicolor_offset,t));
                wave_period_r = wave_period//lerp(color_period,anicolor_period,t);
                wave_amp_r = lerp(wave_amp,aniwave_amp,t);
                wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
                color1_r = merge_color(color1,anicolor1,t);
                color2_r = merge_color(color2,anicolor2,t);
                enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
                endx_r = endx+gaussoffsetx;
                endy_r = endy+gaussoffsety;
                startposx_r = startpos[0]+gaussoffsetx;
                startposy_r = startpos[1]+gaussoffsety;
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
                wave_amp_r = lerp(wave_amp,aniwave_amp,t);
                wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
                color1_r = merge_color(color1,anicolor1,t);
                color2_r = merge_color(color2,anicolor2,t);
                enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
                endx_r = endx+gaussoffsetx;
                endy_r = endy+gaussoffsety;
                startposx_r = startpos[0]+gaussoffsetx;
                startposy_r = startpos[1]+gaussoffsety;
                }
            }
            
        if (placing == "curve")
            {
            ds_list_add(new_list,ds_list_find_value(bez_list,0)*128); //origo x
            ds_list_add(new_list,ds_list_find_value(bez_list,1)*128); //origo y
            ds_list_add(new_list,ds_list_find_value(bez_list,6)*128); //end x
            ds_list_add(new_list,ds_list_find_value(bez_list,7)*128); //end y
            }
        else if (placing == "text")
            {
            ds_list_add(new_list,(startposx_r+xdelta[frame])*128); //origo x
            ds_list_add(new_list,startposy_r*128); //origo y
            ds_list_add(new_list,(endx_r+xdelta[frame])*128); //end x
            ds_list_add(new_list,endy_r*128); //end y
            }
        else if (placing == "func")
            {
            ds_list_add(new_list,0); //origo x
            ds_list_add(new_list,0); //origo y
            ds_list_add(new_list,0); //end x
            ds_list_add(new_list,0); //end y
            }
        else
            {
            ds_list_add(new_list,startposx_r*128); //origo x
            ds_list_add(new_list,startposy_r*128); //origo y
            ds_list_add(new_list,endx_r*128); //end x
            ds_list_add(new_list,endy_r*128); //end y
            }
        ds_list_add(new_list,0);
        ds_list_add(new_list,0);
        ds_list_add(new_list,0);
        ds_list_add(new_list,0);
        ds_list_add(new_list,0);
        ds_list_add(new_list,el_id);
        
        
        if (placing == "line") //create a line
            create_line();
            
        else if (placing == "circle") //create a circle
            create_circle();
            
        else if (placing == "wave") //create a wave
            create_wave();
    
        else if (placing == "free") //create a free drawn shape
            create_free();
            
        else if (placing == "curve") //create a bezier curve
            create_curve();
            
        else if (placing == "text") //create a letter/text
            create_letter();
            
        else if (placing == "func") //create a function based shape
            {
            if (!create_func())
                {
                ds_list_clear(bez_list);
                ds_list_clear(free_list);
                ds_stack_push(undo_list,el_id);
                ds_list_destroy(new_list);
                frame = framepre;
                return 0;
                }
            }
            
        ds_list_replace(new_list,4,xmin);
        ds_list_replace(new_list,5,xmax);
        ds_list_replace(new_list,6,ymin);
        ds_list_replace(new_list,7,ymax);
            
            
        ds_list_add(ds_list_find_value(frame_list,frame),new_list);
        
        frame++;
        }
        
    frame = framepre;
    }

if (placing != "text") refresh_surfaces();

if (autoresflag)
    resolution = "auto";

ds_list_clear(bez_list);
ds_list_clear(free_list);
ds_stack_push(undo_list,el_id);
el_id++;
