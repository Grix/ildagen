radius = point_distance(startpos[0],startpos[1],endx,endy)*128;
startrad = degtorad(-point_direction(startpos[0],startpos[1],endx,endy));

checkpoints = ceil(2*pi*radius/resolution);
if (checkpoints < 3) checkpoints = 3;



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
        dotfreq = checkpoints/(blank_freq_r+0.47);
    else
        dotfreq = blank_period_r/resolution;
    if (dotfreq < 1)
        dotfreq = 1;
    }
if (colormode == "dash")
    {
    if (colormode2 == 0)
        colorfreq = checkpoints/(color_freq_r+0.47);
    else
        colorfreq = color_period_r/resolution;
    if (colorfreq < 1)
        colorfreq = 1;
    }

if (blankmode != "solid")
    {
    if (floor(checkpoints+blank_offset_r/pi/2*dotfreq) % round(dotfreq) > blank_dc_r*dotfreq) or (blank_dc_r < 0.02)
        blanknew = 1;
    else
        blanknew = 0;
    }

if !((startpos[0] == endx) && (startpos[1] == endy))
    for (n = 0;n <= checkpoints; n++)
        {
        makedot = 0;
        
        //COLOR
        if (colormode = "solid")
            {
            c[0] = colour_get_blue(color1_r);
            c[1] = colour_get_green(color1_r);
            c[2] = colour_get_red(color1_r);
            }
        else if (colormode = "gradient")
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
         
        //BLANK   
        if (blankmode = "solid")
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
            if (round(n-dotfreq+blank_offset_r/pi/2*dotfreq) % round(dotfreq) == 0)
                makedot = 1;
            //if ((n == checkpoints) and ((blank_offset_r = 0) or (blank_offset_r = pi)) and (blankmode2 = 0))
             //   makedot = 1;
            blank = 1;
            }
        else if (blankmode == "dotsolid")
            {
            if (round(n-dotfreq+blank_offset_r/pi/2*dotfreq) % round(dotfreq) == 0)
                makedot = 1;
            //if ((n == checkpoints) and ((blank_offset_r = 0) or (blank_offset_r = pi)) and (blankmode2 = 0))
             //   makedot = 1;
            blank = 0;
            }
                
        
    if (makedot)
        {
        if (blankmode == "dot")
            {
            ds_list_add(new_list,cos(startrad+ 2*pi/checkpoints*n)*radius);
            ds_list_add(new_list,sin(startrad+ 2*pi/checkpoints*n)*radius);
            ds_list_add(new_list,1);
            ds_list_add(new_list,c[0]);
            ds_list_add(new_list,c[1]);
            ds_list_add(new_list,c[2]);
            ds_list_add(new_list,cos(startrad+ 2*pi/checkpoints*n)*radius);
            ds_list_add(new_list,sin(startrad+ 2*pi/checkpoints*n)*radius);
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
                    ds_list_add(new_list,cos(startrad+ 2*pi/checkpoints*(n-1))*radius);
                    ds_list_add(new_list,sin(startrad+ 2*pi/checkpoints*(n-1))*radius);
                    ds_list_add(new_list,1);
                    ds_list_add(new_list,c[0]);
                    ds_list_add(new_list,c[1]);
                    ds_list_add(new_list,c[2]);
                    }
                else
                    {
                    ds_list_add(new_list,cos(startrad+ 2*pi/checkpoints*(n-1))*radius);
                    ds_list_add(new_list,sin(startrad+ 2*pi/checkpoints*(n-1))*radius);
                    ds_list_add(new_list,0);
                    ds_list_add(new_list,colour_get_blue(controller.enddotscolor_r));
                    ds_list_add(new_list,colour_get_green(controller.enddotscolor_r));
                    ds_list_add(new_list,colour_get_red(controller.enddotscolor_r));
                    }
                ds_list_add(new_list,cos(startrad+ 2*pi/checkpoints*(n-1))*radius);
                ds_list_add(new_list,sin(startrad+ 2*pi/checkpoints*(n-1))*radius);
                ds_list_add(new_list,0);
                ds_list_add(new_list,colour_get_blue(controller.enddotscolor_r));
                ds_list_add(new_list,colour_get_green(controller.enddotscolor_r));
                ds_list_add(new_list,colour_get_red(controller.enddotscolor_r))
                }
            else
                {
                ds_list_add(new_list,cos(startrad+ 2*pi/checkpoints*n)*radius);
                ds_list_add(new_list,sin(startrad+ 2*pi/checkpoints*n)*radius);
                ds_list_add(new_list,0);
                ds_list_add(new_list,c[0]);
                ds_list_add(new_list,c[1]);
                ds_list_add(new_list,c[2])
                ds_list_add(new_list,cos(startrad+ 2*pi/checkpoints*n)*radius);
                ds_list_add(new_list,sin(startrad+ 2*pi/checkpoints*n)*radius);
                ds_list_add(new_list,0);
                ds_list_add(new_list,colour_get_blue(controller.enddotscolor_r));
                ds_list_add(new_list,colour_get_green(controller.enddotscolor_r));
                ds_list_add(new_list,colour_get_red(controller.enddotscolor_r))
                }
            }

        }  
    else
        {    
        ds_list_add(new_list,cos(startrad+ 2*pi/checkpoints*n)*radius);
        ds_list_add(new_list,sin(startrad+ 2*pi/checkpoints*n)*radius);
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        }
    }
else
    {
    ds_list_add(new_list,endx*128);
    ds_list_add(new_list,endy*128);
    ds_list_add(new_list,blank);
    ds_list_add(new_list,c[0]);
    ds_list_add(new_list,c[1]);
    ds_list_add(new_list,c[2]);
    ds_list_add(new_list,endx*128);
    ds_list_add(new_list,endy*128);
    ds_list_add(new_list,blank);
    ds_list_add(new_list,c[0]);
    ds_list_add(new_list,c[1]);
    ds_list_add(new_list,c[2]);
    }
