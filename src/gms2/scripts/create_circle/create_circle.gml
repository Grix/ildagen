function create_circle() {
	radius = point_distance(startposx_r,startposy_r,endx_r,endy_r);
	startrad = degtorad(-point_direction(startposx_r,startposy_r,endx_r,endy_r));

	checkpoints = ceil(2*pi*radius/resolution);
	if (checkpoints < 3) checkpoints = 3;

	xmax = -$ffff;
	xmin = $ffff;
	ymax = -$ffff;
	ymin = $ffff;

	dotfreq = 1;

	if (blankmode == "dot") or (blankmode == "dotsolid")
	{
	    numdots = 0;
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

	dotdivcurrent = blank_offset_r/pi/2;

	if (blankmode != "solid")
	{
	    if (floor(checkpoints+blank_offset_r/pi/2*dotfreq) % round(dotfreq) > blank_dc_r*dotfreq) or (blank_dc_r < 0.02)
	        blanknew = 1;
	    else
	        blanknew = 0;
	}

	if !((startposx_r == endx_r) && (startposy_r == endy_r))
	    for (n = 0; n <= checkpoints; n++)
	    {
	        makedot = 0;
         
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
                
        
	    if (makedot)
	    {
	        if (blankmode == "dot")
	        {
	            ds_list_add(new_list,cos(startrad+ 2*pi/checkpoints*n)*radius);
	            ds_list_add(new_list,sin(startrad+ 2*pi/checkpoints*n)*radius);
	            ds_list_add(new_list,1);
	            ds_list_add(new_list,c);
	            repeat (dotmultiply)
	            {
	                ds_list_add(new_list,cos(startrad+ 2*pi/checkpoints*n)*radius);
	                ds_list_add(new_list,sin(startrad+ 2*pi/checkpoints*n)*radius);
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
	                    ds_list_add(new_list,cos(startrad+ 2*pi/checkpoints*(n-1))*radius);
	                    ds_list_add(new_list,sin(startrad+ 2*pi/checkpoints*(n-1))*radius);
	                    ds_list_add(new_list,1);
	                    ds_list_add(new_list,c);
	                }
	                else
	                {
	                    ds_list_add(new_list,cos(startrad+ 2*pi/checkpoints*(n-1))*radius);
	                    ds_list_add(new_list,sin(startrad+ 2*pi/checkpoints*(n-1))*radius);
	                    ds_list_add(new_list,0);
	                    ds_list_add(new_list,controller.enddotscolor_r);
	                }
	                repeat (dotmultiply)
	                {
	                    ds_list_add(new_list,cos(startrad+ 2*pi/checkpoints*(n-1))*radius);
	                    ds_list_add(new_list,sin(startrad+ 2*pi/checkpoints*(n-1))*radius);
	                    ds_list_add(new_list,0);
	                    ds_list_add(new_list,controller.enddotscolor_r);
	                }
	            }
	            else
	            {
	                ds_list_add(new_list,cos(startrad+ 2*pi/checkpoints*n)*radius);
	                ds_list_add(new_list,sin(startrad+ 2*pi/checkpoints*n)*radius);
	                ds_list_add(new_list,0);
	                ds_list_add(new_list,c);
	                repeat (dotmultiply)
	                {
	                    ds_list_add(new_list,cos(startrad+ 2*pi/checkpoints*n)*radius);
	                    ds_list_add(new_list,sin(startrad+ 2*pi/checkpoints*n)*radius);
	                    ds_list_add(new_list,0);
	                    ds_list_add(new_list,controller.enddotscolor_r);
	                }
	            }
	        }

	    }  
	    else
	    {    
	        ds_list_add(new_list,cos(startrad+ 2*pi/checkpoints*n)*radius);
	        ds_list_add(new_list,sin(startrad+ 2*pi/checkpoints*n)*radius);
	        ds_list_add(new_list,blank);
	        ds_list_add(new_list,c);
	    }
        
	    if ((cos(startrad+ 2*pi/checkpoints*n)*radius) > xmax)
	       xmax = cos(startrad+ 2*pi/checkpoints*n)*radius;
	    if ((cos(startrad+ 2*pi/checkpoints*n)*radius) < xmin)
	       xmin = cos(startrad+ 2*pi/checkpoints*n)*radius;
	    if ((sin(startrad+ 2*pi/checkpoints*n)*radius) > ymax)
	       ymax = sin(startrad+ 2*pi/checkpoints*n)*radius;
	    if ((sin(startrad+ 2*pi/checkpoints*n)*radius) < ymin)
	       ymin = sin(startrad+ 2*pi/checkpoints*n)*radius;
        
        
	}
	else
	{
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
			
		blank = 0;
	
	    ds_list_add(new_list,0);
	    ds_list_add(new_list,0);
	    ds_list_add(new_list,blank);
	    ds_list_add(new_list,c);
	    ds_list_add(new_list,0);
	    ds_list_add(new_list,0);
	    ds_list_add(new_list,blank);
	    ds_list_add(new_list,c);
    
	    xmax = 1;
	    xmin = 0;
	    ymax = 1;
	    ymin = 0;
	}
    
	return 1;



}
