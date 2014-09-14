checkpoints = ceil((point_distance(startpos[0],startpos[1],endx,endy)*128+abs(wave_amp_r*2*wave_period_r))/resolution);
if (checkpoints < 4) checkpoints = 4;
vector[0] = (endx-startpos[0])/checkpoints;
vector[1] = (endy-startpos[1])/checkpoints;
blanknew = 0;


if (blankmode = "dot") or (blankmode = "dotsolid")
    {
    dotlist = ds_list_create();
    if (blankmode2 == 0)
        dotfreq = round(checkpoints/(blank_freq_r-1));
    else
        dotfreq = round(blank_period_r/resolution);
    if (dotfreq == 0)
        dotfreq = 1;
    }

if !((startpos[0] == endx) && (startpos[1] == (endy)))
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
                c[0] = ( colour_get_blue(color1_r)*    (0.5+cos( (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2) + colour_get_blue(color2_r)*   (1-(0.5+cos( (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2)) );
                c[1] = ( colour_get_green(color1_r)*   (0.5+cos( (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2) + colour_get_green(color2_r)*  (1-(0.5+cos( (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2)) );
                c[2] = ( colour_get_red(color1_r)*     (0.5+cos( (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2) + colour_get_red(color2_r)*    (1-(0.5+cos( (checkpoints-n)*color_freq_r/checkpoints*2*pi +pi)/2)) );
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
            
        ratiox = sin(degtorad(point_direction(startpos[0],startpos[1],endx,endy)));
        ratioy = cos(degtorad(point_direction(startpos[0],startpos[1],endx,endy)));
        pointx = vector[0]*n+wave_amp_r*sin(pi*2/checkpoints*n*wave_period_r)*ratiox/128;
        pointy = vector[1]*n+wave_amp_r*sin(pi*2/checkpoints*n*wave_period_r)*ratioy/128;
        pointxprevious = vector[0]*(n-1)+wave_amp_r*sin(pi*2/checkpoints*(n-1)*wave_period_r)*ratiox/128;
        pointyprevious = vector[1]*(n-1)+wave_amp_r*sin(pi*2/checkpoints*(n-1)*wave_period_r)*ratioy/128;
            
        //BLANK
        if (blankmode = "solid")
            blank = 0;
        else if (blankmode == "dash")
            {
            if (blankmode2 = 0)
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
                else if ((n*(blank_freq_r-0.5)/checkpoints % 1) > blank_dc_r) or (blank_dc_r <= 0.02) or ((blank_freq_r % 1 != 0) and (n == checkpoints))
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
            else
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
                else if ((n*resolution/blank_period_r % 1) > blank_dc_r) or (blank_dc_r <= 0.02)
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
            }
        else if (blankmode == "dot")
            {
            if ((n-dotfreq+round(blank_offset_r/pi*dotfreq)) % dotfreq == 0)
                makedot = 1;
            if ((n == checkpoints) and ((blank_offset_r = 0) or (blank_offset_r = pi)) and (blankmode2 = 0))
                makedot = 1;
            blank = 1;
            }
        else if (blankmode == "dotsolid")
            {
            if ((n-dotfreq+round(blank_offset_r/pi*dotfreq)) % dotfreq == 0)
                makedot = 1;
            if ((n == checkpoints) and ((blank_offset_r = 0) or (blank_offset_r = pi)) and (blankmode2 = 0))
                makedot = 1;
            blank = 0;
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
