checkpoints = ( 2*ceil(abs(endx-startpos[0]))+2*ceil(abs(512-endy-startpos[1])) )*128/resolution;
lengtha = abs(endx-startpos[0]);
lengthb = abs(512-endy-startpos[1]);
if (checkpoints < 4) checkpoints = 4;
while (checkpoints % 4) checkpoints++;
cpratio = lengtha/lengthb;
blanknew = 0;

u = 0;
reached = 0;
for (n = 0;n <= checkpoints; n++)
    {
    if (blankmode = "solid")
        blank = 0;
    else if (blankmode = "dash")
        {
        if (blankmode2 = 0)
            {
            if ((n*blank_freq/checkpoints % 1) > blank_dc) or (blank_dc = 0)
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
    
    if (colormode = "solid")
        {
        c[0] = colour_get_blue(color1);
        c[1] = colour_get_green(color1);
        c[2] = colour_get_red(color1);
        }
    else if (colormode = "gradient")
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
        
    if (n > checkpoints/4*3*cpratio)
        {
        if (reached == 0)
            {
            u = 0;
            reached = 1;
            }
        ds_list_add(new_list,u*1*128);
        ds_list_add(new_list,u*0*128);
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        u++;
        }
    else if (n > checkpoints/4*2/cpratio)
        {
        if (reached == 1)
            {
            u = 0;
            reached = 2;
            }
        ds_list_add(new_list,u*0*128);
        ds_list_add(new_list,u*-1*128);
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        u++;
        }
    else if (n > checkpoints/4*1*cpratio)
        {
        if (reached == 2)
            {
            u = 0;
            reached = 3;
            }
        ds_list_add(new_list,u*-1*128);
        ds_list_add(new_list,u*0*128);
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        u++;
        }
    else
        {
        if (reached == 3)
            {
            u = 0;
            reached = 4;
            }
        ds_list_add(new_list,u*0*128);
        ds_list_add(new_list,u*-1*128);
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        u++;
        }
    
    }