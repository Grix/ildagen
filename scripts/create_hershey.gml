letter_list = read_hershey_index_ini(hershey_selected);
    
checkpoints = (ds_list_size(letter_list)-20)/4;
blanknew = 1;

xmax = -$ffff;
xmin = $ffff;
ymax = -$ffff;
ymin = $ffff;

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
if (colormode == "dash")
    {
    if (colormode2 == 0)
        colorfreq = checkpoints/(color_freq_r+0.48);
    else
        colorfreq = color_period_r/resolution;
    if (colorfreq < 1)
        colorfreq = 1;
    }


for (n = 0;n < checkpoints; n++)
    {
    makedot = 0;
    
    //BLANK
    if (blankmode == "solid")
        {
        blank = 0;
        if ((n == 0) or (n == checkpoints-1)) and (enddots)
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
         else if (floor(n+blank_offset_r/pi/2*dotfreq) % round(dotfreq) > blank_dc_r*dotfreq) or (blank_dc_r < 0.02)
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
        if (floor(n-dotfreq+blank_offset_r/pi/2*dotfreq) % floor(dotfreq) == 0)
            makedot = 1;
        blank = 1;
        }
    else if (blankmode == "dotsolid")
        {
        if (floor(n-dotfreq+blank_offset_r/pi/2*dotfreq) % floor(dotfreq) == 0)
            makedot = 1;
        blank = 0;
        }
    else if (blankmode == "func")
        {
        if (!func_blank())
            return 0;
        if (blanknew != blank) and (enddots)
            {
            makedot = 2;
            blanknew = blank;
            }
        }
        
        
    //COLOR
    if (colormode == "solid")
        {
        c = color1_r;
        }
    else if (colormode == "rainbow")
        {
        if (colormode2 == 0)
            {
            colorrb = make_colour_hsv(((color_offset_r/(2*pi)+ (checkpoints-n)*color_freq_r/checkpoints)*255)%255,255,255); 
            }
        else
            {
            colorrb = make_colour_hsv(((color_offset_r/(2*pi)+ (checkpoints-n)*resolution/color_period_r)*255)%255,255,255); 
            }
        c = colorrb;
        }
    else if (colormode == "gradient")
        {
        if (colormode2 == 0)
            {
            var tt = color_offset_r/(2*pi)+ (checkpoints-n)*color_freq_r/checkpoints;
            tt = (tt*2) mod 2;
            if (tt > 1) tt = 2-tt;
            var colorresult = merge_colour(color1_r,color2_r,tt);
            }
        else
            {
            var tt = color_offset_r/(2*pi)+ (checkpoints-n)*resolution/color_period_r;
            tt = (tt*2) mod 2;
            if (tt > 1) tt = 2-tt;
            var colorresult = merge_colour(color1_r,color2_r,tt);
            }
        c = colorresult;
        }
    else if (colormode == "dash")
        {
        if (color_dc_r >= 0.98)
            {
            c = color1_r;
            }
        else if (floor(n+color_offset_r/pi/2*colorfreq) % floor(colorfreq) > color_dc_r*colorfreq) or (color_dc_r < 0.02)
            {
            c = color2_r;
            }
        else 
            {
            c = color1_r;
            }
        }
    else if (colormode == "func")
        if (!func_color())
            return 0;
        
    if (enddots)
        {
        if (!makedot) and (blankmode != "dot") and (n == checkpoints) and (blank == 0)
            makedot = 1;
        }
        
    currentpos = 20+4*n;
        
    if (ds_list_find_value(letter_list,currentpos+2))
        blank = 1;
        
    if (makedot)
        {
        
        if (blankmode == "dot")
            {
            ds_list_add(new_list,(ds_list_find_value(letter_list,currentpos)));
            ds_list_add(new_list,(ds_list_find_value(letter_list,currentpos+1)));
            ds_list_add(new_list,1);
            ds_list_add(new_list,c);
            repeat (dotmultiply)
                {
                ds_list_add(new_list,(ds_list_find_value(letter_list,currentpos)));
                ds_list_add(new_list,(ds_list_find_value(letter_list,currentpos+1)));
                ds_list_add(new_list,0);
                ds_list_add(new_list,c);
                }
            }
        else
            {
            if (makedot == 2)
                {
                if (blank)
                    {
                    if (n)
                        {
                        ds_list_add(new_list,(ds_list_find_value(letter_list,20+4*(n-1))));
                        ds_list_add(new_list,(ds_list_find_value(letter_list,20+4*(n-1)+1)));
                        }
                    else
                        {
                        ds_list_add(new_list,(ds_list_find_value(letter_list,currentpos)));
                        ds_list_add(new_list,(ds_list_find_value(letter_list,currentpos+1)));
                        }
                    ds_list_add(new_list,1);
                    ds_list_add(new_list,c);
                    }
                else
                    {
                    if (n)
                        {
                        ds_list_add(new_list,(ds_list_find_value(letter_list,20+4*(n-1))));
                        ds_list_add(new_list,(ds_list_find_value(letter_list,20+4*(n-1)+1)));
                        }
                    else
                        {
                        ds_list_add(new_list,(ds_list_find_value(letter_list,currentpos)));
                        ds_list_add(new_list,(ds_list_find_value(letter_list,currentpos+1)));
                        }
                    ds_list_add(new_list,0);
                    ds_list_add(new_list,controller.enddotscolor_r);
                    }
                repeat (dotmultiply)
                    {
                    if (n)
                        {
                        ds_list_add(new_list,(ds_list_find_value(letter_list,20+4*(n-1))));
                        ds_list_add(new_list,(ds_list_find_value(letter_list,20+4*(n-1)+1)));
                        }
                    else
                        {
                        ds_list_add(new_list,(ds_list_find_value(letter_list,currentpos)));
                        ds_list_add(new_list,(ds_list_find_value(letter_list,currentpos+1)));
                        }
                    ds_list_add(new_list,0);
                    ds_list_add(new_list,controller.enddotscolor_r);
                    }
                }
            else
                {
                ds_list_add(new_list,(ds_list_find_value(letter_list,currentpos)));
                ds_list_add(new_list,(ds_list_find_value(letter_list,currentpos+1)));
                ds_list_add(new_list,0);
                ds_list_add(new_list,c);
                repeat (dotmultiply)
                    {
                    ds_list_add(new_list,(ds_list_find_value(letter_list,currentpos)));
                    ds_list_add(new_list,(ds_list_find_value(letter_list,currentpos+1)));
                    ds_list_add(new_list,0);
                    ds_list_add(new_list,controller.enddotscolor_r);
                    }
                }
            }

        }  
    else
        {    
        ds_list_add(new_list,(ds_list_find_value(letter_list,currentpos)));
        ds_list_add(new_list,(ds_list_find_value(letter_list,currentpos+1)));
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c);
        }
    
    if (((ds_list_find_value(letter_list,currentpos)))/128 > xmax)
       xmax = ((ds_list_find_value(letter_list,currentpos)))/128;     
    if (((ds_list_find_value(letter_list,currentpos)))/128 < xmin)
       xmin = ((ds_list_find_value(letter_list,currentpos)))/128;
    if (((ds_list_find_value(letter_list,currentpos+1)))/128 > ymax)
       ymax = ((ds_list_find_value(letter_list,currentpos+1)))/128;     
    if (((ds_list_find_value(letter_list,currentpos+1)))/128 < ymin)
       ymin = ((ds_list_find_value(letter_list,currentpos+1)))/128;
    
    }
    
//ds_list_replace(new_list,0,(ds_list_find_value(new_list,0)-xmin*128));
//ds_list_replace(new_list,2,(ds_list_find_value(new_list,2)-xmin*128));

return 1;