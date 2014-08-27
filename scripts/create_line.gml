checkpoints = ceil(point_distance(startpos[0],startpos[1],endx,512-endy)*128/resolution);
if (checkpoints < 2) checkpoints = 2;

vector[0] = (endx-startpos[0])/checkpoints;
vector[1] = (512-endy-startpos[1])/checkpoints;
blanknew = 0;

for (n = 0;n <= checkpoints; n++)
    {
    if (blankmode == "solid")
        blank = 0;
    else if (blankmode == "dash")
        {
        if (blankmode2 = 0)
            {
            if ((n*(blank_freq-0.5)/checkpoints % 1) > blank_dc) or (blank_dc = 0)
                blank = 1;
            else blank = 0;
            }
        else
            {
            if ((n*resolution/blank_period % 1) > blank_dc) or (blank_dc = 0)
                blank = 1;
            else blank = 0;
            }
        }
    else if (blankmode == "dot")
        {
        if (blankmode2 = 0)
            {
            if (blanknew = floor((n*(blank_freq-1)/checkpoints)))
                {
                blank = 0;
                blanknew = 1+floor((n*(blank_freq-1)/checkpoints));
                }
            else 
                {
                blank = 1;
                }
            }
        else
            {
            if (blanknew = floor(n*resolution/blank_period))
                {
                blank = 0;
                blanknew = 1+floor(n*resolution/blank_period);
                }
            else 
                {
                blank = 1;
                }
            }
        }
    
    if (colormode == "solid")
        {
        c[0] = colour_get_blue(color1);
        c[1] = colour_get_green(color1);
        c[2] = colour_get_red(color1);
        }
    else if (colormode == "gradient")
        {
        if (colormode2 == 0)
            {
            c[0] = ( colour_get_blue(color1)*    (0.5+cos( (checkpoints-n)*color_freq/checkpoints*2*pi +pi)/2) + colour_get_blue(color2)*   (1-(0.5+cos( (checkpoints-n)*color_freq/checkpoints*2*pi +pi)/2)) );
            c[1] = ( colour_get_green(color1)*   (0.5+cos( (checkpoints-n)*color_freq/checkpoints*2*pi +pi)/2) + colour_get_green(color2)*  (1-(0.5+cos( (checkpoints-n)*color_freq/checkpoints*2*pi +pi)/2)) );
            c[2] = ( colour_get_red(color1)*     (0.5+cos( (checkpoints-n)*color_freq/checkpoints*2*pi +pi)/2) + colour_get_red(color2)*    (1-(0.5+cos( (checkpoints-n)*color_freq/checkpoints*2*pi +pi)/2)) );
            }
        else
            {
            c[0] = ( colour_get_blue(color1)*    (0.5+cos( (checkpoints-n)*resolution/color_period*2*pi +pi)/2) + colour_get_blue(color2)*   (1-(0.5+cos( (checkpoints-n)*resolution/color_period*2*pi +pi)/2)) );
            c[1] = ( colour_get_green(color1)*   (0.5+cos( (checkpoints-n)*resolution/color_period*2*pi +pi)/2) + colour_get_green(color2)*  (1-(0.5+cos( (checkpoints-n)*resolution/color_period*2*pi +pi)/2)) );
            c[2] = ( colour_get_red(color1)*     (0.5+cos( (checkpoints-n)*resolution/color_period*2*pi +pi)/2) + colour_get_red(color2)*    (1-(0.5+cos( (checkpoints-n)*resolution/color_period*2*pi +pi)/2)) );
            }
        }
    else if (colormode == "dash")
        {
        if (colormode2 = 0)
            {
            if (n = checkpoints)
                {
                if (color_freq % 1 == 0.5)
                    {
                    c[0] = colour_get_blue(color2);
                    c[1] = colour_get_green(color2);
                    c[2] = colour_get_red(color2);
                    }
                else 
                    {
                    c[0] = colour_get_blue(color1);
                    c[1] = colour_get_green(color1);
                    c[2] = colour_get_red(color1);
                    }
                }
            else if (((n*(color_freq+0.5)/checkpoints % 1) > color_dc) or (color_dc = 0))
                {
                c[0] = colour_get_blue(color2);
                c[1] = colour_get_green(color2);
                c[2] = colour_get_red(color2);
                }
            else 
                {
                c[0] = colour_get_blue(color1);
                c[1] = colour_get_green(color1);
                c[2] = colour_get_red(color1);
                }
            }
        else
            {
            if ((n*resolution/color_period % 1) > color_dc) or (color_dc = 0)
                {
                c[0] = colour_get_blue(color2);
                c[1] = colour_get_green(color2);
                c[2] = colour_get_red(color2);
                }
            else 
                {
                c[0] = colour_get_blue(color1);
                c[1] = colour_get_green(color1);
                c[2] = colour_get_red(color1);
                }
            }
        }
        
        
    if (!blank) && (blankmode == "dot")
        {
        ds_list_add(new_list,n*vector[0]*128);
        ds_list_add(new_list,n*vector[1]*128);
        ds_list_add(new_list,1);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        }      
    ds_list_add(new_list,n*vector[0]*128);
    ds_list_add(new_list,n*vector[1]*128);
    ds_list_add(new_list,blank);
    ds_list_add(new_list,c[0]);
    ds_list_add(new_list,c[1]);
    ds_list_add(new_list,c[2]);
    
    }
