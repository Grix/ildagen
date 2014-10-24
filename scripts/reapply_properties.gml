//reapplies the object properties

//requires obj_message

//arg0: 0 = init, 1 = do

if (argument0 == 0)
    {
    if (selectedelement = -1)
        exit;
    obj_message.visible = 1;
    obj_message.type = 0;
    }
else if (argument0 == 1)
    {
    
    //find elements
    temp_frame_list = ds_list_create();
    for (i = 0;i < maxframes;i++)
        {
        el_list_temp = ds_list_find_value(frame_list,i);
        for (u = 0;u < ds_list_size(el_list_temp);u++)
            {
            if (ds_list_find_value(ds_list_find_value(el_list_temp,u),9) == selectedelement)
                {
                ds_list_add(temp_frame_list,ds_list_find_value(el_list_temp,u))
                }
            }
        }
            
    for (i = 0;i < ds_list_size(temp_frame_list);i++)
        {
        blanknew = 1;
        new_list = ds_list_find_value(temp_frame_list,i);
        checkpoints = ((ds_list_size(new_list)-10)/6);
        
        
        startpos[0] = ds_list_find_value(new_list,0);
        startpos[1] = ds_list_find_value(new_list,1);
        endx = ds_list_find_value(new_list,2);
        endy = ds_list_find_value(new_list,3);
        
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
                wave_period_r = wave_period//lerp(color_period,anicolor_period,t);
                wave_amp_r = wave_amp//lerp(color_dc,anicolor_dc,t);
                wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
                color1_r = merge_color(color1,anicolor1,t);
                color2_r = merge_color(color2,anicolor2,t);
                enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
                endx_r = lerp(endx,endx+anixtrans/$ffff*512,t);
                endy_r = lerp(endy,endy+aniytrans/$ffff*512,t);
                startposx_r = lerp(startpos[0],startpos[0]+anixtrans/$ffff*512,t);
                startposy_r  = lerp(startpos[1],startpos[1]+aniytrans/$ffff*512,t);
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
                wave_amp_r = wave_amp//lerp(color_dc,anicolor_dc,t);
                wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
                color1_r = merge_color(color1,anicolor1,t);
                color2_r = merge_color(color2,anicolor2,t);
                enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
                endx_r = lerp(endx,endx+anixtrans/$ffff*512,t);
                endy_r = lerp(endy,endy+aniytrans/$ffff*512,t);
                startposx_r = lerp(startpos[0],startpos[0]+anixtrans/$ffff*512,t);
                startposy_r  = lerp(startpos[1],startpos[1]+aniytrans/$ffff*512,t);
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
                wave_amp_r = wave_amp//lerp(color_dc,anicolor_dc,t);
                wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
                color1_r = merge_color(color1,anicolor1,t);
                color2_r = merge_color(color2,anicolor2,t);
                enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
                endx_r = lerp(endx,endx+anixtrans/$ffff*512,t);
                endy_r = lerp(endy,endy+aniytrans/$ffff*512,t);
                startposx_r = lerp(startpos[0],startpos[0]+anixtrans/$ffff*512,t);
                startposy_r  = lerp(startpos[1],startpos[1]+aniytrans/$ffff*512,t);
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
                wave_amp_r = wave_amp//lerp(color_dc,anicolor_dc,t);
                wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
                color1_r = merge_color(color1,anicolor1,t);
                color2_r = merge_color(color2,anicolor2,t);
                enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
                endx_r = lerp(endx,endx+anixtrans/$ffff*512,t);
                endy_r = lerp(endy,endy+aniytrans/$ffff*512,t);
                startposx_r = lerp(startpos[0],startpos[0]+anixtrans/$ffff*512,t);
                startposy_r  = lerp(startpos[1],startpos[1]+aniytrans/$ffff*512,t);
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
                endx_r = lerp(endx,endx+anixtrans/$ffff*512,t);
                endy_r = lerp(endy,endy+aniytrans/$ffff*512,t);
                startposx_r = lerp(startpos[0],startpos[0]+anixtrans/$ffff*512,t);
                startposy_r  = lerp(startpos[1],startpos[1]+aniytrans/$ffff*512,t);
                }
            }
            
        //TRANS
        if (obj_message.reap_trans)
            {
            ds_list_replace(new_list,0,startpos[0]+startposx_r*$ffff/512);
            ds_list_replace(new_list,1,startpos[1]+startposy_r*$ffff/512);
            ds_list_replace(new_list,2,endx+endx_r*$ffff/512);
            ds_list_replace(new_list,3,endy+endy_r*$ffff/512);
            }
            
        
        if (obj_message.reap_blank)
            {
            if (blankmode == "dot") or (blankmode == "dotsolid")
                {
                if (blankmode2 == 0)
                    dotfreq = checkpoints/(blank_freq_r);
                else
                    dotfreq = blank_period_r/resolution;
                if (dotfreq < 1)
                    dotfreq = 1;
                }
            else if (blankmode == "dash")
                {
                if (blankmode2 == 0)
                    dotfreq = checkpoints/(blank_freq_r+0.48);
                else
                    dotfreq = blank_period_r/resolution;
                if (dotfreq < 1)
                    dotfreq = 1;
                }
            }
            
        if (obj_message.reap_color)
            {
            if (colormode == "dash")
                {
                if (colormode2 == 0)
                    colorfreq = checkpoints/(color_freq_r+0.48);
                else
                    colorfreq = color_period_r/resolution;
                if (colorfreq < 1)
                    colorfreq = 1;
                }
            }
    
            
        for (j = 0; j < checkpoints;j++)
            {
            
            if ((j != 0) and (ds_list_find_value(new_list,10+j*6) == ds_list_find_value(new_list,10+(j-1)*6)) and (ds_list_find_value(new_list,10+j*6+1) == ds_list_find_value(new_list,10+(j-1)*6+1)) and (obj_message.reap_removeoverlap))
                {
                repeat(6) ds_list_delete(new_list,10+j*6);
                checkpoints--;
                j--;
                continue;
                }
                
            makedot = 0;
            
            
            if (obj_message.reap_color)
                {
                //COLOR
                if (colormode == "solid")
                    {
                    c[0] = colour_get_blue(color1_r);
                    c[1] = colour_get_green(color1_r);
                    c[2] = colour_get_red(color1_r);
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
                    
                
                ds_list_replace(new_list,10+j*6+3,c[0]);
                ds_list_replace(new_list,10+j*6+4,c[1]);
                ds_list_replace(new_list,10+j*6+5,c[2]);
                    
                }
            
            
            if (obj_message.reap_blank)
                {
                //BLANK
                if (blankmode == "solid")
                    blank = 0;
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
                    
                        
                if (enddots)
                    {
                    if (!makedot) and (blankmode != "dot") and (j == checkpoints) and (blank == 0)
                        makedot = 1;
                    }
                
                
                    
                if (makedot)
                    {
                    if (blankmode == "dot")
                        {
                        ds_list_replace(new_list,10+j*6+2,1);
                        repeat (dotmultiply)
                            {
                            ds_list_insert(new_list,10+j*6+6,ds_list_find_value(new_list,10+j*6));
                            ds_list_insert(new_list,10+(j)*6+7,ds_list_find_value(new_list,10+j*6+1));
                            ds_list_insert(new_list,10+(j)*6+8,0);
                            ds_list_insert(new_list,10+(j)*6+9,colour_get_blue(enddotscolor_r));
                            ds_list_insert(new_list,10+(j)*6+10,colour_get_green(enddotscolor_r));
                            ds_list_insert(new_list,10+(j)*6+11,colour_get_red(enddotscolor_r));
                            checkpoints++;
                            j++;
                            }
                        }
                    else
                        {
                        if (makedot == 2)
                            {
                            if (blank)
                                ds_list_replace(new_list,10+j*6+2,1);
                            else
                                ds_list_replace(new_list,10+j*6+2,0);
                            repeat (dotmultiply)
                                {
                                ds_list_insert(new_list,10+(j)*6+6,ds_list_find_value(new_list,10+j*6));
                                ds_list_insert(new_list,10+(j)*6+7,ds_list_find_value(new_list,10+j*6+1));
                                ds_list_insert(new_list,10+(j)*6+8,0);
                                ds_list_insert(new_list,10+(j)*6+9,colour_get_blue(enddotscolor_r));
                                ds_list_insert(new_list,10+(j)*6+10,colour_get_green(enddotscolor_r));
                                ds_list_insert(new_list,10+(j)*6+11,colour_get_red(enddotscolor_r));
                                checkpoints++;
                                j++;
                                }
                            }
                        else
                            {
                            ds_list_replace(new_list,10+j*6+2,0);
                            repeat (dotmultiply)
                                {
                                ds_list_insert(new_list,10+(j)*6+6,ds_list_find_value(new_list,10+j*6));
                                ds_list_insert(new_list,10+(j)*6+7,ds_list_find_value(new_list,10+j*6+1));
                                ds_list_insert(new_list,10+(j)*6+8,0);
                                ds_list_insert(new_list,10+(j)*6+9,colour_get_blue(enddotscolor_r));
                                ds_list_insert(new_list,10+(j)*6+10,colour_get_green(enddotscolor_r));
                                ds_list_insert(new_list,10+(j)*6+11,colour_get_red(enddotscolor_r));
                                checkpoints++;
                                j++;
                                }
                            }
                        }
                    }  
                else
                    { 
                    ds_list_replace(new_list,10+j*6+2,blank);
                    }
                } 
                
                
            }
            
        }
    
    refresh_surfaces();
    }
