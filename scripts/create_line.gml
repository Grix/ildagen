checkpoints = ceil(point_distance(startpos[0],startpos[1],endx,endy)*128/resolution);
if (checkpoints < 2) checkpoints = 2;

vector[0] = (endx-startpos[0])/checkpoints;
vector[1] = (endy-startpos[1])/checkpoints;
blanknew = 0;

if (blankmode == "dot") or (blankmode == "dotsolid")
    {
    if (blankmode2 == 0)
        dotfreq = checkpoints/(blank_freq_r-1);
    else
        dotfreq = blank_period_r/resolution;
    if (dotfreq < 1)
        dotfreq = 1;
    }
else if (blankmode == "dash")
    {
    if (blankmode2 == 0)
        dotfreq = checkpoints/(blank_freq_r-0.5);
    else
        dotfreq = blank_period_r/resolution;
    if (dotfreq < 1)
        dotfreq = 1;
    }

        

for (n = 0;n <= checkpoints; n++)
    {
    makedot = 0;
    
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
            c[0] = ( colour_get_blue(color1_r)*    (0.5+cos( (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2*color_dc_r*2) + colour_get_blue(color2_r)*   (1-(0.5+cos( (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2/color_dc_r/2)) );
            c[1] = ( colour_get_green(color1_r)*   (0.5+cos( (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2*color_dc_r*2) + colour_get_green(color2_r)*  (1-(0.5+cos( (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2/color_dc_r/2)) );
            c[2] = ( colour_get_red(color1_r)*     (0.5+cos( (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2*color_dc_r*2) + colour_get_red(color2_r)*    (1-(0.5+cos( (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2/color_dc_r/2)) );
            }
        else
            {
            c[0] = ( colour_get_blue(color1_r)*    (0.5+cos( (checkpoints-n)*resolution/color_period_r*2*pi +pi)/2) + colour_get_blue(color2_r)*   (1-(0.5+cos( (checkpoints-n)*resolution/color_period_r*2*pi +pi)/2)) );
            c[1] = ( colour_get_green(color1_r)*   (0.5+cos( (checkpoints-n)*resolution/color_period_r*2*pi +pi)/2) + colour_get_green(color2_r)*  (1-(0.5+cos( (checkpoints-n)*resolution/color_period_r*2*pi +pi)/2)) );
            c[2] = ( colour_get_red(color1_r)*     (0.5+cos( (checkpoints-n)*resolution/color_period_r*2*pi +pi)/2) + colour_get_red(color2_r)*    (1-(0.5+cos( (checkpoints-n)*resolution/color_period_r*2*pi +pi)/2)) );
            }
        }
    else if (colormode == "dash")
        {
        if (colormode2 = 0)
            {
            if (n = checkpoints) and !(color_dc_r >= 0.98)
                {
                //if (color_freq_r % 1 == 0.5)
                    {
                    c[0] = colour_get_blue(color2_r);
                    c[1] = colour_get_green(color2_r);
                    c[2] = colour_get_red(color2_r);
                    }
                /*else 
                    {
                    c[0] = colour_get_blue(color1_r);
                    c[1] = colour_get_green(color1_r);
                    c[2] = colour_get_red(color1_r);
                    }*/
                }
            else if (((n*(color_freq_r+0.5)/checkpoints % 1) > color_dc_r) or (color_dc_r <= 0.02)) and !(color_dc_r >= 0.98)
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
        else
            {
            if ((n*resolution/color_period_r % 1) > color_dc_r) or (color_dc_r <= 0.02)
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
        }
        
        if (enddots)
            {
            if (!makedot) and ((n == 0) or (n == checkpoints)) and (blankmode != "dot")
                makedot = 1;
            }
        
        
    if (makedot)
        {
        
        if (blankmode == "dot")
            {
            ds_list_add(new_list,n*vector[0]*128);
            ds_list_add(new_list,n*vector[1]*128);
            ds_list_add(new_list,1);
            ds_list_add(new_list,c[0]);
            ds_list_add(new_list,c[1]);
            ds_list_add(new_list,c[2]);
            ds_list_add(new_list,n*vector[0]*128);
            ds_list_add(new_list,n*vector[1]*128);
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
                    ds_list_add(new_list,(n-1)*vector[0]*128);
                    ds_list_add(new_list,(n-1)*vector[1]*128);
                    ds_list_add(new_list,1);
                    ds_list_add(new_list,c[0]);
                    ds_list_add(new_list,c[1]);
                    ds_list_add(new_list,c[2]);
                    }
                else
                    {
                    ds_list_add(new_list,(n-1)*vector[0]*128);
                    ds_list_add(new_list,(n-1)*vector[1]*128);
                    ds_list_add(new_list,0);
                    ds_list_add(new_list,colour_get_blue(controller.enddotscolor_r));
                    ds_list_add(new_list,colour_get_green(controller.enddotscolor_r));
                    ds_list_add(new_list,colour_get_red(controller.enddotscolor_r));
                    }
                ds_list_add(new_list,(n-1)*vector[0]*128);
                ds_list_add(new_list,(n-1)*vector[1]*128);
                ds_list_add(new_list,0);
                ds_list_add(new_list,colour_get_blue(controller.enddotscolor_r));
                ds_list_add(new_list,colour_get_green(controller.enddotscolor_r));
                ds_list_add(new_list,colour_get_red(controller.enddotscolor_r))
                }
            else
                {
                ds_list_add(new_list,n*vector[0]*128);
                ds_list_add(new_list,n*vector[1]*128);
                ds_list_add(new_list,0);
                ds_list_add(new_list,c[0]);
                ds_list_add(new_list,c[1]);
                ds_list_add(new_list,c[2])
                ds_list_add(new_list,n*vector[0]*128);
                ds_list_add(new_list,n*vector[1]*128);
                ds_list_add(new_list,0);
                ds_list_add(new_list,colour_get_blue(controller.enddotscolor_r));
                ds_list_add(new_list,colour_get_green(controller.enddotscolor_r));
                ds_list_add(new_list,colour_get_red(controller.enddotscolor_r))
                }
            }

        }  
    else
        {    
        ds_list_add(new_list,n*vector[0]*128);
        ds_list_add(new_list,n*vector[1]*128);
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        }
    
    }
