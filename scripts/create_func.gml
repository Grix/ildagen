checkpoints = ceil(shapefunc_cp);

blanknew = 1;

xmax = -$ffff;
xmin = $ffff;
ymax = -$ffff;
ymin = $ffff;

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
    
for (n = 0;n <= checkpoints; n++)
    {
    makedot = 0;
    
    //XY
    ML_VM_SetVarReal(parser_shape,"point",n/checkpoints);

    
    result_x = ML_Execute(parser_shape,compiled_x);
    if (!ML_ResObj_HasAnswer(result_x))
        {
        show_message_async("Unexpected value for X at point="+string(n/checkpoints)+" , frame="+string(t));  
        ML_ResObj_Cleanup(result_x);
        ML_CompileCleanup(compiled_x);
        ML_CompileCleanup(compiled_y);
        return 0;
        }    
    result_y = ML_Execute(parser_shape,compiled_y);
    if (!ML_ResObj_HasAnswer(result_y))
        {
        show_message_async("Unexpected value for Y at point="+string(n/checkpoints)+" , frame="+string(t));
        ML_ResObj_Cleanup(result_y);
        ML_ResObj_Cleanup(result_x);
        ML_CompileCleanup(compiled_x);
        ML_CompileCleanup(compiled_y);
        return 0;
        }
    
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
    
        
    if (n)
        {
        xpprev = xp;
        ypprev = yp;
        }
        
    xp = ML_ResObj_GetFinalAnswer(result_x);
    yp = ML_ResObj_GetFinalAnswer(result_y);
    ML_ResObj_Cleanup(result_y);
    ML_ResObj_Cleanup(result_x);
        
    if (makedot)
        {
        if (blankmode == "dot")
            {
            ds_list_add(new_list,xp);
            ds_list_add(new_list,yp);
            ds_list_add(new_list,1);
            ds_list_add(new_list,c[0]);
            ds_list_add(new_list,c[1]);
            ds_list_add(new_list,c[2]);
            repeat (dotmultiply)
                {
                ds_list_add(new_list,xp);
                ds_list_add(new_list,yp);
                ds_list_add(new_list,0);
                ds_list_add(new_list,c[0]);
                ds_list_add(new_list,c[1]);
                ds_list_add(new_list,c[2])
                }
            }
        else
            {
            if (makedot == 2)
                {
                if (blank)
                    {
                    ds_list_add(new_list,xpprev);
                    ds_list_add(new_list,ypprev);
                    ds_list_add(new_list,1);
                    ds_list_add(new_list,c[0]);
                    ds_list_add(new_list,c[1]);
                    ds_list_add(new_list,c[2]);
                    }
                else
                    {
                    ds_list_add(new_list,xpprev);
                    ds_list_add(new_list,ypprev);
                    ds_list_add(new_list,0);
                    ds_list_add(new_list,colour_get_blue(controller.enddotscolor_r));
                    ds_list_add(new_list,colour_get_green(controller.enddotscolor_r));
                    ds_list_add(new_list,colour_get_red(controller.enddotscolor_r));
                    }
                repeat (dotmultiply)
                    {
                    ds_list_add(new_list,xpprev);
                    ds_list_add(new_list,ypprev);
                    ds_list_add(new_list,0);
                    ds_list_add(new_list,colour_get_blue(controller.enddotscolor_r));
                    ds_list_add(new_list,colour_get_green(controller.enddotscolor_r));
                    ds_list_add(new_list,colour_get_red(controller.enddotscolor_r))
                    }
                }
            else
                {
                ds_list_add(new_list,xp);
                ds_list_add(new_list,yp);
                ds_list_add(new_list,0);
                ds_list_add(new_list,c[0]);
                ds_list_add(new_list,c[1]);
                ds_list_add(new_list,c[2])
                repeat (dotmultiply)
                    {
                    ds_list_add(new_list,xp);
                    ds_list_add(new_list,yp);
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
        ds_list_add(new_list,xp);
        ds_list_add(new_list,yp);
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        }
        
    if (xp/128 > xmax)
       xmax = xp/128;
    if (xp/128 < xmin)
       xmin = xp/128;
    if (yp/128 > ymax)
       ymax = yp/128;
    if (yp/128 < ymin)
       ymin = yp/128;
    
    }

return 1;
