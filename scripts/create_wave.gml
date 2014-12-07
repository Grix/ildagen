checkpoints = ceil((point_distance(startposx_r,startposy_r,endx_r,endy_r)*128+abs(wave_amp_r*2*wave_period_r))/resolution);
if (checkpoints < 4) checkpoints = 4;
vector[0] = (endx_r-startposx_r)/checkpoints;
vector[1] = (endy_r-startposy_r)/checkpoints;
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
    


if !((startposx_r == endx_r) && (startposy_r == (endy_r)))
    for (n = 0;n <= checkpoints; n++)
        {
        makedot = 0;
        
        //XY
        ratiox = sin(degtorad(point_direction(startposx_r,startposy_r,endx_r,endy_r)));
        ratioy = cos(degtorad(point_direction(startposx_r,startposy_r,endx_r,endy_r)));
        pointx = vector[0]*n+wave_amp_r*sin(wave_offset_r+ pi*2/checkpoints*n*wave_period_r)*ratiox/128;
        pointy = vector[1]*n+wave_amp_r*sin(wave_offset_r+ pi*2/checkpoints*n*wave_period_r)*ratioy/128;
        pointxprevious = vector[0]*(n-1)+wave_amp_r*sin(wave_offset_r+ pi*2/checkpoints*(n-1)*wave_period_r)*ratiox/128;
        pointyprevious = vector[1]*(n-1)+wave_amp_r*sin(wave_offset_r+ pi*2/checkpoints*(n-1)*wave_period_r)*ratioy/128;
        
        
        //COLOR
        if (colormode = "solid")
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
        else if (colormode = "gradient")
            {        
            if (colormode2 == 0)
                {
                c[0] = ( colour_get_blue(color1_r)*    (0.5+cos(color_offset_r+ (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2*color_dc_r*2) + colour_get_blue(color2_r)*   (1-(0.5+cos(color_offset_r+ (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2/color_dc_r/2)) );
                c[1] = ( colour_get_green(color1_r)*   (0.5+cos(color_offset_r+ (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2*color_dc_r*2) + colour_get_green(color2_r)*  (1-(0.5+cos(color_offset_r+ (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2/color_dc_r/2)) );
                c[2] = ( colour_get_red(color1_r)*     (0.5+cos(color_offset_r+ (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2*color_dc_r*2) + colour_get_red(color2_r)*    (1-(0.5+cos(color_offset_r+ (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2/color_dc_r/2)) );
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
        
            
        //BLANK
        if (blankmode = "solid")
            {
            blank = 0;
            if (n == 0) and (enddots)
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
            
    if (enddots)
        {
        if (!makedot) and (blankmode != "dot") and (n == checkpoints) and (blank == 0)
            makedot = 1;
        }
        
        
    if (makedot)
        {
        
        if (blankmode == "dot")
            {
            ds_list_add(new_list,pointx*128);
            ds_list_add(new_list,pointy*128);
            ds_list_add(new_list,1);
            ds_list_add(new_list,c[0]);
            ds_list_add(new_list,c[1]);
            ds_list_add(new_list,c[2]);
            ds_list_add(new_list,pointx*128);
            ds_list_add(new_list,pointy*128);
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
                    ds_list_add(new_list,pointxprevious*128);
                    ds_list_add(new_list,pointyprevious*128);
                    ds_list_add(new_list,1);
                    ds_list_add(new_list,c[0]);
                    ds_list_add(new_list,c[1]);
                    ds_list_add(new_list,c[2]);
                    }
                else
                    {
                    ds_list_add(new_list,pointxprevious*128);
                    ds_list_add(new_list,pointyprevious*128);
                    ds_list_add(new_list,0);
                    ds_list_add(new_list,colour_get_blue(controller.enddotscolor_r));
                    ds_list_add(new_list,colour_get_green(controller.enddotscolor_r));
                    ds_list_add(new_list,colour_get_red(controller.enddotscolor_r));
                    }
                ds_list_add(new_list,pointxprevious*128);
                ds_list_add(new_list,pointyprevious*128);
                ds_list_add(new_list,0);
                ds_list_add(new_list,colour_get_blue(controller.enddotscolor_r));
                ds_list_add(new_list,colour_get_green(controller.enddotscolor_r));
                ds_list_add(new_list,colour_get_red(controller.enddotscolor_r))
                }
            else
                {
                ds_list_add(new_list,pointx*128);
                ds_list_add(new_list,pointy*128);
                ds_list_add(new_list,0);
                ds_list_add(new_list,c[0]);
                ds_list_add(new_list,c[1]);
                ds_list_add(new_list,c[2])
                ds_list_add(new_list,pointx*128);
                ds_list_add(new_list,pointy*128);
                ds_list_add(new_list,0);
                ds_list_add(new_list,colour_get_blue(controller.enddotscolor_r));
                ds_list_add(new_list,colour_get_green(controller.enddotscolor_r));
                ds_list_add(new_list,colour_get_red(controller.enddotscolor_r))
                }
            }

        }  
    else
        {    
        ds_list_add(new_list,pointx*128);
        ds_list_add(new_list,pointy*128);
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        }
    
    if (pointx > xmax)
       xmax = pointx;
    if (pointx < xmin)
       xmin = pointx;
    if (pointy > ymax)
       ymax = pointy;
    if (pointy < ymin)
       ymin = pointy;
    }
else
    {
    ds_list_add(new_list,endx_r*128);
    ds_list_add(new_list,endy_r*128);
    ds_list_add(new_list,blank);
    ds_list_add(new_list,c[0]);
    ds_list_add(new_list,c[1]);
    ds_list_add(new_list,c[2]);
    ds_list_add(new_list,endx_r*128);
    ds_list_add(new_list,endy_r*128);
    ds_list_add(new_list,blank);
    ds_list_add(new_list,c[0]);
    ds_list_add(new_list,c[1]);
    ds_list_add(new_list,c[2]);
    
    
    xmax = endx_r+1;
    xmin = endx_r;
    ymax = endy_r+1;
    ymin = endy_r;
    }

return 1;