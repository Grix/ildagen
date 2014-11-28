//reapplies the object properties

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


autoresflag = 0;
if (is_string(resolution))
    {
    autoresflag = 1;
    if ((placing == "line") && (blankmode == "solid") && (colormode == "solid"))
        resolution = 4096;
    else
        resolution = 1024;
        
    if (colormode != "solid") or (blankmode != "solid")
        resolution = 512;
    
    if (anienable) and (blankmode != "solid") and ((blank_offset != aniblank_offset) or (blank_dc != aniblank_dc))
        resolution = 256;
    else if (anienable) and (colormode != "solid") and ((color_offset != anicolor_offset) or (color_dc != anicolor_dc))
        resolution = 256;
    }

//find elements
temp_undof_list = ds_list_create();
temp_frame_list = ds_list_create();
for (i = scope_start;i <= scope_end;i++)
    {
    el_list_temp = ds_list_find_value(frame_list,i);
    for (u = 0;u < ds_list_size(el_list_temp);u++)
        {
        if (ds_list_find_value(ds_list_find_value(el_list_temp,u),9) == selectedelement)
            {
            if (ds_list_empty(temp_frame_list))
                startframe = i;
            ds_list_add(temp_frame_list,ds_list_find_value(el_list_temp,u))
            temp_undo_list = ds_list_create();
            ds_list_copy(temp_undo_list,ds_list_find_value(el_list_temp,u));
            ds_list_add(temp_undo_list,i);
            ds_list_add(temp_undof_list,temp_undo_list);
            }
        }
    }

ds_stack_push(undo_list,"k"+string(temp_undof_list));

        
//walk through frames
randomize();
for (i = 0;i < ds_list_size(temp_frame_list);i++)
    {
    blanknew = 1;
    new_list = ds_list_find_value(temp_frame_list,i);
    checkpoints = ((ds_list_size(new_list)-10)/6);
    
    startpos[0] = ds_list_find_value(new_list,0);
    startpos[1] = ds_list_find_value(new_list,1);
    endx = ds_list_find_value(new_list,2);
    endy = ds_list_find_value(new_list,3);
    
    //interpolate
    if (reap_interpolate)
        {
        lengthlist = ds_list_create();
        for (j = 0; j < (checkpoints-1);j++)
            {
            length = point_distance(ds_list_find_value(new_list,10+j*6)
                                    ,ds_list_find_value(new_list,10+j*6+1)
                                    ,ds_list_find_value(new_list,10+(j+1)*6)
                                    ,ds_list_find_value(new_list,10+(j+1)*6+1));
            ds_list_add(lengthlist,length);
            }
            
        jpp= 0;
        for (j = 0; j < (checkpoints-1);j++)
            {
            if (ds_list_find_value(lengthlist,j) <= resolution) continue;
            
            lerpi = 1;
            jpp_offset = 0;
            
            repeat(floor(ds_list_find_value(lengthlist,j) / resolution))
                {
                lerpi-= 1/floor(ds_list_find_value(lengthlist,j) / resolution);
                
                newx = lerp(ds_list_find_value(new_list,10+(j+1+jpp-jpp_offset)*6),ds_list_find_value(new_list,10+(j+jpp-jpp_offset)*6),lerpi);
                newy = lerp(ds_list_find_value(new_list,10+(j+1+jpp-jpp_offset)*6+1),ds_list_find_value(new_list,10+(j+jpp-jpp_offset)*6+1),lerpi);
                ds_list_insert(new_list,10+(j+1+jpp)*6+6,newx);
                ds_list_insert(new_list,10+(j+1+jpp)*6+7,newy);
                ds_list_insert(new_list,10+(j+1+jpp)*6+8,ds_list_find_value(new_list,10+(j+1+jpp)*6+2));
                ds_list_insert(new_list,10+(j+1+jpp)*6+9,ds_list_find_value(new_list,10+(j+1+jpp)*6+3));
                ds_list_insert(new_list,10+(j+1+jpp)*6+10,ds_list_find_value(new_list,10+(j+1+jpp)*6+4));
                ds_list_insert(new_list,10+(j+1+jpp)*6+11,ds_list_find_value(new_list,10+(j+1+jpp)*6+5));
                
                jpp++;
                jpp_offset++;
                }
            }
            ds_list_destroy(lengthlist);
        }
            
    
    gaussoffsetx = reap_trans*shaking*128*clamp(random_gaussian(0,shaking_sdev),-shaking_sdev*3,shaking_sdev*3);
    gaussoffsety = reap_trans*shaking*128*clamp(random_gaussian(0,shaking_sdev),-shaking_sdev*3,shaking_sdev*3);
    
    if (anienable == 0) or (ds_list_size(temp_frame_list) == 1)
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
        endx_r = endx;
        endy_r = endy;
        startposx_r = startpos[0];
        startposy_r  = startpos[1];
        }
    else
        {
        t = i/ds_list_size(temp_frame_list);    
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
            color1_r = merge_color(color1,anicolor1,t);
            color2_r = merge_color(color2,anicolor2,t);
            enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
            endx_r = lerp(endx,endx,t)+gaussoffsetx;
            endy_r = lerp(endy,endy,t)+gaussoffsety;
            startposx_r = lerp(startpos[0],startpos[0],t)+gaussoffsetx;
            startposy_r  = lerp(startpos[1],startpos[1],t)+gaussoffsety;
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
            color1_r = merge_color(color1,anicolor1,t);
            color2_r = merge_color(color2,anicolor2,t);
            enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
            endx_r = lerp(endx,endx,t)+gaussoffsetx;
            endy_r = lerp(endy,endy,t)+gaussoffsety;
            startposx_r = lerp(startpos[0],startpos[0],t)+gaussoffsetx;
            startposy_r  = lerp(startpos[1],startpos[1],t)+gaussoffsety;
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
            color1_r = merge_color(color1,anicolor1,t);
            color2_r = merge_color(color2,anicolor2,t);
            enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
            endx_r = lerp(endx,endx,t)+gaussoffsetx;
            endy_r = lerp(endy,endy,t)+gaussoffsety;
            startposx_r = lerp(startpos[0],startpos[0],t)+gaussoffsetx;
            startposy_r  = lerp(startpos[1],startpos[1],t)+gaussoffsety;
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
            color1_r = merge_color(color1,anicolor1,t);
            color2_r = merge_color(color2,anicolor2,t);
            enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
            endx_r = lerp(endx,endx,t)+gaussoffsetx;
            endy_r = lerp(endy,endy,t)+gaussoffsety;
            startposx_r = lerp(startpos[0],startpos[0],t)+gaussoffsetx;
            startposy_r  = lerp(startpos[1],startpos[1],t)+gaussoffsety;
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
            color1_r = merge_color(color1,anicolor1,t);
            color2_r = merge_color(color2,anicolor2,t);
            enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
            endx_r = lerp(endx,endx,t)+gaussoffsetx;
            endy_r = lerp(endy,endy,t)+gaussoffsety;
            startposx_r = lerp(startpos[0],startpos[0],t)+gaussoffsetx;
            startposy_r  = lerp(startpos[1],startpos[1],t)+gaussoffsety;
            }
        }
        
    
    if (controller.reap_blank)
        {
        if (blankmode == "dot") or (blankmode == "dotsolid")
            {
            if (blankmode2 == 0)
                dotfreq = checkpoints/(blank_freq_r);
            else
                dotfreq = blank_period_r/512;
            if (dotfreq < 1)
                dotfreq = 1;
            }
        else if (blankmode == "dash")
            {
            if (blankmode2 == 0)
                dotfreq = checkpoints/(blank_freq_r+0.48);
            else
                dotfreq = blank_period_r/512;
            if (dotfreq < 1)
                dotfreq = 1;
            }
        }
        
    if (controller.reap_color)
        {
        if (colormode == "dash")
            {
            if (colormode2 == 0)
                colorfreq = checkpoints/(color_freq_r+0.48);
            else
                colorfreq = color_period_r/512;
            if (colorfreq < 1)
                colorfreq = 1;
            }
        }

        
    //walk through points
    for (j = 0; j < checkpoints;j++)
        {
        listpos = 10+j*6;
        
        if ((j != 0) and (ds_list_find_value(new_list,listpos) == ds_list_find_value(new_list,10+(j-1)*6)) and (ds_list_find_value(new_list,listpos+1) == ds_list_find_value(new_list,10+(j-1)*6+1)) and (controller.reap_removeoverlap))
            {
            repeat(6) ds_list_delete(new_list,listpos);
            checkpoints--;
            j--;
            continue;
            }
            
        makedot = 0;
        
        
        if (controller.reap_color)
            {
            //COLOR
            if (colormode == "solid")
                {
                c[0] = colour_get_blue(color1_r);
                c[1] = colour_get_green(color1_r);
                c[2] = colour_get_red(color1_r);
                }
            else if (colormode == "rainbow")
                {
                if (colormode2 == 0)
                    {
                    colorrb = make_colour_hsv(((color_offset_r/(2*pi)+ (checkpoints-j)*color_freq_r/checkpoints)*255)%255,255,255); 
                    c[0] = colour_get_blue(colorrb );
                    c[1] = colour_get_green(colorrb );
                    c[2] = colour_get_red(colorrb );
                    }
                else
                    {
                    colorrb = make_colour_hsv(((color_offset_r/(2*pi)+ (checkpoints-j)*resolution/color_period_r)*255)%255,255,255); 
                    c[0] = colour_get_blue(colorrb );
                    c[1] = colour_get_green(colorrb );
                    c[2] = colour_get_red(colorrb );
                    }
                }
            else if (colormode == "gradient")
                {
                if (colormode2 == 0)
                    {
                    c[0] = ( colour_get_blue(color1_r)*    (0.5+cos(color_offset_r+ (checkpoints-j)*color_freq_r/checkpoints*2*pi +pi)/2) + colour_get_blue(color2_r)*   (1-(0.5+cos(color_offset_r+ (checkpoints-j)*color_freq_r/checkpoints*2*pi +pi)/2)) );
                    c[1] = ( colour_get_green(color1_r)*   (0.5+cos(color_offset_r+ (checkpoints-j)*color_freq_r/checkpoints*2*pi +pi)/2) + colour_get_green(color2_r)*  (1-(0.5+cos(color_offset_r+ (checkpoints-j)*color_freq_r/checkpoints*2*pi +pi)/2)) );
                    c[2] = ( colour_get_red(color1_r)*     (0.5+cos(color_offset_r+ (checkpoints-j)*color_freq_r/checkpoints*2*pi +pi)/2) + colour_get_red(color2_r)*    (1-(0.5+cos(color_offset_r+ (checkpoints-j)*color_freq_r/checkpoints*2*pi +pi)/2)) );
                    }
                else
                    {
                    c[0] = ( colour_get_blue(color1_r)*    (0.5+cos(color_offset_r+ (checkpoints-j)*resolution/color_period_r*2*pi +pi)/2) + colour_get_blue(color2_r)*   (1-(0.5+cos(color_offset_r+ (checkpoints-j)*resolution/color_period_r*2*pi +pi)/2)) );
                    c[1] = ( colour_get_green(color1_r)*   (0.5+cos(color_offset_r+ (checkpoints-j)*resolution/color_period_r*2*pi +pi)/2) + colour_get_green(color2_r)*  (1-(0.5+cos(color_offset_r+ (checkpoints-j)*resolution/color_period_r*2*pi +pi)/2)) );
                    c[2] = ( colour_get_red(color1_r)*     (0.5+cos(color_offset_r+ (checkpoints-j)*resolution/color_period_r*2*pi +pi)/2) + colour_get_red(color2_r)*    (1-(0.5+cos(color_offset_r+ (checkpoints-j)*resolution/color_period_r*2*pi +pi)/2)) );
                    }
                }
            else if (colormode == "dash")
                {
                if (color_dc_r >= 0.98)
                    {
                    c[0] = colour_get_blue(color1_r);
                    c[1] = colour_get_green(color1_r);
                    c[2] = colour_get_red(color1_r);
                    }
                else if (floor(j+color_offset_r/pi/2*colorfreq) % floor(colorfreq) > color_dc_r*colorfreq) or (color_dc_r < 0.02)
                    {
                    c[0] = colour_get_blue(color2_r);
                    c[1] = colour_get_green(color2_r);
                    c[2] = colour_get_red(color2_r);
                    }
                else 
                    {
                    c[0] = colour_get_blue(color1_r);
                    c[1] = colour_get_green(color1_r);
                    c[2] = colour_get_red(color1_r);
                    }
                }
                
            
            ds_list_replace(new_list,listpos+3,c[0]);
            ds_list_replace(new_list,listpos+4,c[1]);
            ds_list_replace(new_list,listpos+5,c[2]);
                
            }
        
        
        if (controller.reap_blank)
            {
            //BLANK
            if (blankmode == "solid")
                {
                blank = 0;
                if (j == 0) and (enddots)
                    makedot = 1;
                }
            else if (blankmode == "dash")
                {
                if (blank_dc_r >= 0.98)
                    {
                    blank = 0;
                    if (blanknew != blank) and (enddots)
                        {
                        makedot = 2;
                        blanknew = blank;
                        }
                    }
                 else if (floor(j+blank_offset_r/pi/2*dotfreq) % round(dotfreq) > blank_dc_r*dotfreq) or (blank_dc_r < 0.02)
                       {
                    blank = 1;
                    if (blanknew != blank) and (enddots)
                        {
                        makedot = 2;
                        blanknew = blank;
                        }
                    }
                else 
                    {
                    blank = 0;
                    if (blanknew != blank) and (enddots)
                        {
                        makedot = 2;
                        blanknew = blank;
                        }
                    }
                }
            else if (blankmode == "dot")
                {
                if (floor(j-dotfreq+blank_offset_r/pi/2*dotfreq) % floor(dotfreq) == 0)
                    makedot = 1;
                blank = 1;
                }
            else if (blankmode == "dotsolid")
                {
                if (floor(j-dotfreq+blank_offset_r/pi/2*dotfreq) % floor(dotfreq) == 0)
                    makedot = 1;
                blank = 0;
                }
                
            if (reap_preserveblank and ds_list_find_value(new_list,listpos+2))
                blank = 1;
                
                    
            if (enddots)
                {
                if (!makedot) and (blankmode != "dot") and (j == checkpoints) and (blank == 0)
                    makedot = 1;
                }
            
            
                
            if (makedot)
                {
                if (blankmode == "dot")
                    {
                    ds_list_replace(new_list,listpos+2,1);
                    repeat (dotmultiply)
                        {
                        ds_list_insert(new_list,listpos+6,ds_list_find_value(new_list,listpos));
                        ds_list_insert(new_list,listpos+7,ds_list_find_value(new_list,listpos+1));
                        ds_list_insert(new_list,listpos+8,0);
                        ds_list_insert(new_list,listpos+9,colour_get_blue(enddotscolor_r));
                        ds_list_insert(new_list,listpos+10,colour_get_green(enddotscolor_r));
                        ds_list_insert(new_list,listpos+11,colour_get_red(enddotscolor_r));
                        checkpoints++;
                        j++;
                        }
                    }
                else
                    {
                    if (makedot == 2)
                        {
                        if (blank)
                            ds_list_replace(new_list,10+(j-1)*6+2,1);
                        else
                            ds_list_replace(new_list,10+(j-1)*6+2,0);
                        icount = 0;
                        repeat (dotmultiply)
                            {
                            icount++;
                            ds_list_insert(new_list,10+(j-1)*6+6,ds_list_find_value(new_list,10+(j-1)*6));
                            ds_list_insert(new_list,10+(j-1)*6+7,ds_list_find_value(new_list,10+(j-1)*6+1));
                            ds_list_insert(new_list,10+(j-1)*6+8,0);
                            ds_list_insert(new_list,10+(j-1)*6+9,colour_get_blue(enddotscolor_r));
                            ds_list_insert(new_list,10+(j-1)*6+10,colour_get_green(enddotscolor_r));
                            ds_list_insert(new_list,10+(j-1)*6+11,colour_get_red(enddotscolor_r));
                            }
                        j+= icount;
                        checkpoints += icount;
                        }
                    else
                        {
                        ds_list_replace(new_list,listpos+2,0);
                        icount = 0;
                        repeat (dotmultiply)
                            {
                            icount++;
                            ds_list_insert(new_list,listpos+6,ds_list_find_value(new_list,listpos));
                            ds_list_insert(new_list,listpos+7,ds_list_find_value(new_list,listpos+1));
                            ds_list_insert(new_list,listpos+8,0);
                            ds_list_insert(new_list,listpos+9,colour_get_blue(enddotscolor_r));
                            ds_list_insert(new_list,listpos+10,colour_get_green(enddotscolor_r));
                            ds_list_insert(new_list,listpos+11,colour_get_red(enddotscolor_r));
                
                            }
                        j+= icount;
                        checkpoints += icount;
                        }
                    }
                }  
            else
                { 
                ds_list_replace(new_list,listpos+2,blank);
                }
            }     
        }       
    
    if (reap_trans)
        {
        ds_list_replace(new_list,0,startposx_r);
        ds_list_replace(new_list,1,startposy_r);
        ds_list_replace(new_list,2,endx_r);
        ds_list_replace(new_list,3,endy_r);
        }
     
    }
    
if (autoresflag)
resolution = "auto";

refresh_surfaces();
