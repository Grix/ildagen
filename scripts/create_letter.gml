letter_list = ds_list_find_value(font_list,ord(letter)-33);
checkpoints = (ds_list_size(letter_list)-10)/6;

blanknew = 1;

xmax = 20;
xmin = $ffff-20;
ymax = 20;
ymin = $ffff-20;

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
        c[0] = colour_get_blue(color1_r);
        c[1] = colour_get_green(color1_r);
        c[2] = colour_get_red(color1_r);
        }
    else if (colormode == "rainbow")
        {
        if (colormode2 == 0)
            {
            colorrb = make_colour_hsv(((color_offset_r/(2*pi)+ (checkpoints-n)*color_freq_r/checkpoints)*255)%255,255,255); 
            c[0] = colour_get_blue(colorrb );
            c[1] = colour_get_green(colorrb );
            c[2] = colour_get_red(colorrb );
            }
        else
            {
            colorrb = make_colour_hsv(((color_offset_r/(2*pi)+ (checkpoints-n)*resolution/color_period_r)*255)%255,255,255); 
            c[0] = colour_get_blue(colorrb );
            c[1] = colour_get_green(colorrb );
            c[2] = colour_get_red(colorrb );
            }
        }
    else if (colormode == "gradient")
        {
        if (colormode2 == 0)
            {
            c[0] = ( colour_get_blue(color1_r)*    (0.5+cos(color_offset_r+ (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2) + colour_get_blue(color2_r)*   (1-(0.5+cos(color_offset_r+ (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2)) );
            c[1] = ( colour_get_green(color1_r)*   (0.5+cos(color_offset_r+ (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2) + colour_get_green(color2_r)*  (1-(0.5+cos(color_offset_r+ (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2)) );
            c[2] = ( colour_get_red(color1_r)*     (0.5+cos(color_offset_r+ (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2) + colour_get_red(color2_r)*    (1-(0.5+cos(color_offset_r+ (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2)) );
            }
        else
            {
            c[0] = ( colour_get_blue(color1_r)*    (0.5+cos(color_offset_r+ (checkpoints-n)*resolution/color_period_r*2*pi +pi)/2) + colour_get_blue(color2_r)*   (1-(0.5+cos(color_offset_r+ (checkpoints-n)*resolution/color_period_r*2*pi +pi)/2)) );
            c[1] = ( colour_get_green(color1_r)*   (0.5+cos(color_offset_r+ (checkpoints-n)*resolution/color_period_r*2*pi +pi)/2) + colour_get_green(color2_r)*  (1-(0.5+cos(color_offset_r+ (checkpoints-n)*resolution/color_period_r*2*pi +pi)/2)) );
            c[2] = ( colour_get_red(color1_r)*     (0.5+cos(color_offset_r+ (checkpoints-n)*resolution/color_period_r*2*pi +pi)/2) + colour_get_red(color2_r)*    (1-(0.5+cos(color_offset_r+ (checkpoints-n)*resolution/color_period_r*2*pi +pi)/2)) );
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
        else if (floor(n+color_offset_r/pi/2*colorfreq) % floor(colorfreq) > color_dc_r*colorfreq) or (color_dc_r < 0.02)
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
    else if (colormode == "func")
        if (!func_color())
            return 0;
        
    if (enddots)
        {
        if (!makedot) and (blankmode != "dot") and (n == checkpoints) and (blank == 0)
            makedot = 1;
        }
        
    if (ds_list_find_value(letter_list,10+6*n+2))
        blank = 1;
        
    if (makedot)
        {
        
        if (blankmode == "dot")
            {
            ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*n)-$ffff/2)*font_size/64);
            ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*n+1)-$ffff/2)*font_size/64);
            ds_list_add(new_list,1);
            ds_list_add(new_list,c[0]);
            ds_list_add(new_list,c[1]);
            ds_list_add(new_list,c[2]);
            ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*n)-$ffff/2)*font_size/64);
            ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*n+1)-$ffff/2)*font_size/64);
            ds_list_add(new_list,0);
            ds_list_add(new_list,c[0]);
            ds_list_add(new_list,c[1]);
            ds_list_add(new_list,c[2])
            }
        else
            {
            if (makedot == 2)
                {
                if (blank)
                    {
                    if (n)
                        {
                        ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*(n-1))-$ffff/2)*font_size/64);
                        ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*(n-1)+1)-$ffff/2)*font_size/64);
                        }
                    else
                        {
                        ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*n)-$ffff/2)*font_size/64);
                        ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*n+1)-$ffff/2)*font_size/64);
                        }
                    ds_list_add(new_list,1);
                    ds_list_add(new_list,c[0]);
                    ds_list_add(new_list,c[1]);
                    ds_list_add(new_list,c[2]);
                    }
                else
                    {
                    if (n)
                        {
                        ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*(n-1))-$ffff/2)*font_size/64);
                        ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*(n-1)+1)-$ffff/2)*font_size/64);
                        }
                    else
                        {
                        ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*n)-$ffff/2)*font_size/64);
                        ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*n+1)-$ffff/2)*font_size/64);
                        }
                    ds_list_add(new_list,0);
                    ds_list_add(new_list,colour_get_blue(controller.enddotscolor_r));
                    ds_list_add(new_list,colour_get_green(controller.enddotscolor_r));
                    ds_list_add(new_list,colour_get_red(controller.enddotscolor_r));
                    }
                repeat (dotmultiply)
                    {
                    if (n)
                        {
                        ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*(n-1))-$ffff/2)*font_size/64);
                        ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*(n-1)+1)-$ffff/2)*font_size/64);
                        }
                    else
                        {
                        ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*n)-$ffff/2)*font_size/64);
                        ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*n+1)-$ffff/2)*font_size/64);
                        }
                    ds_list_add(new_list,0);
                    ds_list_add(new_list,colour_get_blue(controller.enddotscolor_r));
                    ds_list_add(new_list,colour_get_green(controller.enddotscolor_r));
                    ds_list_add(new_list,colour_get_red(controller.enddotscolor_r))
                    }
                }
            else
                {
                ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*n)-$ffff/2)*font_size/64);
                ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*n+1)-$ffff/2)*font_size/64);
                ds_list_add(new_list,0);
                ds_list_add(new_list,c[0]);
                ds_list_add(new_list,c[1]);
                ds_list_add(new_list,c[2])
                repeat (dotmultiply)
                    {
                    ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*n)-$ffff/2)*font_size/64);
                    ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*n+1)-$ffff/2)*font_size/64);
                    ds_list_add(new_list,0);
                    ds_list_add(new_list,colour_get_blue(controller.enddotscolor_r));
                    ds_list_add(new_list,colour_get_green(controller.enddotscolor_r));
                    ds_list_add(new_list,colour_get_red(controller.enddotscolor_r))
                    }
                }
            }

        }  
    else
        {    
        ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*n)-$ffff/2)*font_size/64);
        ds_list_add(new_list,(ds_list_find_value(letter_list,10+6*n+1)-$ffff/2)*font_size/64);
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        }
    
    if (((ds_list_find_value(letter_list,10+6*n)-$ffff/2)*font_size/64)/128 > xmax)
       xmax = ((ds_list_find_value(letter_list,10+6*n)-$ffff/2)*font_size/64)/128;     
    if (((ds_list_find_value(letter_list,10+6*n)-$ffff/2)*font_size/64)/128 < xmin)
       xmin = ((ds_list_find_value(letter_list,10+6*n)-$ffff/2)*font_size/64)/128;
    if (((ds_list_find_value(letter_list,10+6*n+1)-$ffff/2)*font_size/64)/128 > ymax)
       ymax = ((ds_list_find_value(letter_list,10+6*n+1)-$ffff/2)*font_size/64)/128;     
    if (((ds_list_find_value(letter_list,10+6*n+1)-$ffff/2)*font_size/64)/128 < ymin)
       ymin = ((ds_list_find_value(letter_list,10+6*n+1)-$ffff/2)*font_size/64)/128;
    
    
    }
    
ds_list_replace(new_list,0,(ds_list_find_value(new_list,0)-xmin*128));
ds_list_replace(new_list,2,(ds_list_find_value(new_list,2)-xmin*128));

xdelta[frame]+= xmax-xmin+font_size/2.6;


return 1;
