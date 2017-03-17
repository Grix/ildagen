//testing
//resolution = resolution/5;
//imp_point_list = ds_list_create();

checkpoints = ceil(point_distance(startposx_r,startposy_r,endx_r,endy_r)*128/resolution);
if (checkpoints < 2) checkpoints = 2;

vector[0] = (endx_r-startposx_r)/checkpoints;
vector[1] = (endy_r-startposy_r)/checkpoints;
blanknew = 1;

xmax = -$ffff;
xmin = $ffff;
ymax = -$ffff;
ymin = $ffff;

dotfreq = 1;

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
        dotfreq = checkpoints/(blank_freq_r+0.5);
    else
        dotfreq = blank_period_r/resolution;
    if (dotfreq < 1)
        dotfreq = 1;
}
if (colormode == "dash")
{
    if (colormode2 == 0)
        colorfreq = checkpoints/(color_freq_r+0.5);
    else
        colorfreq = color_period_r/resolution;
    if (colorfreq < 1)
        colorfreq = 1;
}

dotdivcurrent = blank_offset_r/pi/2-0.001;
    

for (n = 0; n <= checkpoints; n++)
{
    blanksig = 0;
    colorsig = 0;
    makedot = 0;
    
    //BLANK
    if (blankmode == "solid")
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
            if (blanknew != blank)
            {
                if (enddots)
                {
                    makedot = 2;
                }
                blanknew = blank;
                //blanksig = 1;
            }
        }
        else if (floor(n+blank_offset_r/pi/2*dotfreq) % round(dotfreq) > blank_dc_r*dotfreq) or (blank_dc_r < 0.02)
        {
            blank = 1;
            if (blanknew != blank)
            {
                if (enddots)
                {
                    makedot = 2;
                }
                blanknew = blank;
                //blanksig = 1;
            }
        }
        else 
        {
            blank = 0;
            if (blanknew != blank)
            {
                if (enddots)
                {
                    makedot = 2;
                }
                blanknew = blank;
                //blanksig = 1;
            }
        }
    }
    else if (blankmode == "dot")
    {
        if ( ((n+blank_offset_r/pi/2*dotfreq) div dotfreq) > dotdivcurrent )
        {
            makedot = 1;
            dotdivcurrent = ((n+blank_offset_r/pi/2*dotfreq) div dotfreq);
        }
        blank = 1;
    }
    else if (blankmode == "dotsolid")
    {
        if ( ((n+blank_offset_r/pi/2*dotfreq) div dotfreq) > dotdivcurrent )
        {
            makedot = 1;
            dotdivcurrent = ((n+blank_offset_r/pi/2*dotfreq) div dotfreq);
        }
        blank = 0;
    }
    else if (blankmode == "func")
    {
        if (!func_blank())
            return 0;
        if (blanknew != blank)
        {
            if (enddots)
            {
                makedot = 2;
            }
            blanknew = blank;
            blanksig = 1;
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
        
        
    if (makedot)
    {
        
        if (blankmode == "dot")
        {
            ds_list_add(new_list,n*vector[0]*128);
            ds_list_add(new_list,n*vector[1]*128);
            ds_list_add(new_list,1);
            ds_list_add(new_list,c);
            repeat (dotmultiply)
            {
                ds_list_add(new_list,n*vector[0]*128);
                ds_list_add(new_list,n*vector[1]*128);
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
                    ds_list_add(new_list,(n-1)*vector[0]*128);
                    ds_list_add(new_list,(n-1)*vector[1]*128);
                    ds_list_add(new_list,1);
                    ds_list_add(new_list,c);
                }
                else
                {
                    ds_list_add(new_list,(n-1)*vector[0]*128);
                    ds_list_add(new_list,(n-1)*vector[1]*128);
                    ds_list_add(new_list,0);
                    ds_list_add(new_list,controller.enddotscolor_r);
                }
                repeat (dotmultiply)
                {
                    ds_list_add(new_list,(n-1)*vector[0]*128);
                    ds_list_add(new_list,(n-1)*vector[1]*128);
                    ds_list_add(new_list,0);
                    ds_list_add(new_list,controller.enddotscolor_r);
                }
            }
            else
            {
                ds_list_add(new_list,n*vector[0]*128);
                ds_list_add(new_list,n*vector[1]*128);
                ds_list_add(new_list,0);
                ds_list_add(new_list,c);
                repeat (dotmultiply)
                {
                    ds_list_add(new_list,n*vector[0]*128);
                    ds_list_add(new_list,n*vector[1]*128);
                    ds_list_add(new_list,0);
                    ds_list_add(new_list,controller.enddotscolor_r);
                }
            }
        }

    }  
    else
    {    
        //if (blanksig) or (colorsig) or (n % 5 == 0)
         //   {
            ds_list_add(new_list,n*vector[0]*128);
            ds_list_add(new_list,n*vector[1]*128);
            ds_list_add(new_list,blank);
            ds_list_add(new_list,c);
          //  }
    }
    
        
    if (n*vector[0] > xmax)
       xmax = n*vector[0];
    if (n*vector[0] < xmin)
       xmin = n*vector[0];
    if (n*vector[1] > ymax)
       ymax = n*vector[1];
    if (n*vector[1] < ymin)
       ymin = n*vector[1];
}
    
 /* 
for (n = 50; n < ds_list_size(new_list)-3; n+=6)
{

}
  */
//resolution = resolution*5;
    
    
return 1;
