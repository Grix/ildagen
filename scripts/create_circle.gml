radius = point_distance(startpos[0],startpos[1],endx,endy)*128;
startrad = degtorad(-point_direction(startpos[0],startpos[1],endx,endy));

checkpoints = ceil(2*pi*radius/resolution);
if (checkpoints < 3) checkpoints = 3;
blanknew = 0;


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
         
        //BLANK   
        if (blankmode = "solid")
            blank = 0;
        else if (blankmode = "dash")
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
                else if (blank_dc_r <= 0.02)
                    {
                    blank = 1;
                    if (blanknew != blank) and (enddots)
                        {
                        makedot = 2;
                        blanknew = blank;
                        }
                    }
                else if ((n*blank_freq_r/checkpoints % 1) < blank_dc_r) and (n != 0)
                    {
                    blank = 0;
                    if (blanknew != blank) and (enddots)
                        {
                        makedot = 2;
                        blanknew = blank;
                        }
                    }
                else 
                    {
                    blank = 1;
                    if (blanknew != blank) and (enddots)
                        {
                        makedot = 2;
                        blanknew = blank;
                        }
                    }
                }
            else
                {
                if ((n*resolution/blank_period_r % 1) < blank_dc_r) or (blank_dc_r = 0)
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
            if (blankmode2 = 0)
                {
                if (blanknew = floor((n*(blank_freq_r)/checkpoints)))
                    {
                    makedot = 1;
                    blanknew = 1+floor((n*(blank_freq_r)/checkpoints));
                    }
                else 
                    {
                    blank = 1;
                    }
                }
            else
                {
                if (blanknew = floor(n*resolution/blank_period_r))
                    {
                    makedot = 1;
                    blanknew = 1+floor(n*resolution/blank_period_r);
                    }
                else 
                    {
                    blank = 1;
                    }
                }
            }
        else if (blankmode == "dotsolid")
            {
            if (blankmode2 = 0)
                {
                if (blanknew = floor((n*(blank_freq_r)/checkpoints)))
                    {
                    makedot = 1;
                    blanknew = 1+floor((n*(blank_freq_r)/checkpoints));
                    }
                }
            else
                {
                if (blanknew = floor(n*resolution/blank_period_r))
                    {
                    makedot = 1;
                    blanknew = 1+floor(n*resolution/blank_period_r);
                    }
                }
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
