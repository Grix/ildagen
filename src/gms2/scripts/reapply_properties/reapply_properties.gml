function reapply_properties() {
	//reapplies the object properties
	ilda_cancel();
	var t_loop;

	//PREPARING FUNCTIONS
	if (colormode == "func")
	{
	    if (colorfunc_string_1 == "") or is_undefined(colorfunc_string_1) 
	    {
	        if (colormode2)
	            show_message_new("Please write a function for HUE");
	        else
	            show_message_new("Please write a function for RED");
	        frame = framepre;
	        return 0;
	    }
	    if (colorfunc_string_2 == "") or is_undefined(colorfunc_string_2) 
	    {
	        if (colormode2)
	            show_message_new("Please write a function for SATURATION");
	        else
	            show_message_new("Please write a function for GREEN");
	        frame = framepre;
	        return 0;
	    }
	    if (colorfunc_string_3 == "") or is_undefined(colorfunc_string_3) 
	    {
	        if (colormode2)
	            show_message_new("Please write a function for VALUE");
	        else
	            show_message_new("Please write a function for BLUE");
	        frame = framepre;
	        return 0;
	    }
    
		compiled_1 = ML_Compile(parser_cb,colorfunc_string_1); 
		if (!ML_NoException(parser_cb))
		{
		    if (colormode2)
		        show_message_new("Error in function for HUE: "+ML_LastExceptionString(parser_cb));
		    else
		        show_message_new("Error in function for RED: "+ML_LastExceptionString(parser_cb));
		    ML_CompileCleanup(compiled_1);
		    ML_ClearExceptions(parser_cb);
		    if (placing == "func")
		    {
		        ML_CompileCleanup(compiled_x);
		        ML_CompileCleanup(compiled_y);
		    }
		    frame = framepre;
		    return 0;
		}
		compiled_2 = ML_Compile(parser_cb,colorfunc_string_2); 
		if (!ML_NoException(parser_cb))
		{
		    if (colormode2)
		        show_message_new("Error in function for SATURATION: "+ML_LastExceptionString(parser_cb));
		    else
		        show_message_new("Error in function for GREEN: "+ML_LastExceptionString(parser_cb));
		    ML_CompileCleanup(compiled_2);
		    ML_CompileCleanup(compiled_1);
		    ML_ClearExceptions(parser_cb);
		    if (placing == "func")
		    {
		        ML_CompileCleanup(compiled_x);
		        ML_CompileCleanup(compiled_y);
		    }
		    frame = framepre;
		    return 0;
		}
		compiled_3 = ML_Compile(parser_cb,colorfunc_string_3); 
		if (!ML_NoException(parser_cb))
		{
		    if (colormode2)
		        show_message_new("Error in function for VALUE: "+ML_LastExceptionString(parser_cb));
		    else
		        show_message_new("Error in function for BLUE: "+ML_LastExceptionString(parser_cb));
		    ML_CompileCleanup(compiled_3);
		    ML_CompileCleanup(compiled_2);
		    ML_CompileCleanup(compiled_1);
		    ML_ClearExceptions(parser_cb);
		    if (placing == "func")
		    {
		        ML_CompileCleanup(compiled_x);
		        ML_CompileCleanup(compiled_y);
		    }
		    frame = framepre;
		    return 0;
		}
	}
    
	if (blankmode == "func")
	{
	    if (blankfunc_string == "") or is_undefined(blankfunc_string) 
	    {
	        show_message_new("Please write a function for BLANKING");
	        frame = framepre;
	        return 0;
	    }
        
	    compiled_en = ML_Compile(parser_cb,blankfunc_string);
	    if (!ML_NoException(parser_cb))
	    {
	        show_message_new("Error in function for BLANKING: "+ML_LastExceptionString(parser_cb));
	        ML_CompileCleanup(compiled_en);
	        ML_ClearExceptions(parser_cb);
	        if (colormode == "func")
	        {
	            ML_CompileCleanup(compiled_3);
	            ML_CompileCleanup(compiled_2);
	            ML_CompileCleanup(compiled_1);
	        }
	        if (placing == "func")
	        {
	            ML_CompileCleanup(compiled_x);
	            ML_CompileCleanup(compiled_y);
	        }
	        frame = framepre;
	        return 0;
	    }
	}
	
	song_parse = -1;
	parsebuffer = -1;
	bufferIn = -1;
	bufferOut = -1;
	func_doaudio = 0;
	if (func_doaudio == 0)
	{
		if (colormode == "func")
		{
			if (string_pos("audio_", colorfunc_string_1) != 0)
				func_doaudio = 1;
			else if (string_pos("audio_", colorfunc_string_2) != 0)
				func_doaudio = 1;
			else if (string_pos("audio_", colorfunc_string_3) != 0)
				func_doaudio = 1;
		}
		if (blankmode == "func")
		{
			if (string_pos("audio_", blankfunc_string) != 0)
				func_doaudio = 1;
		}
	}
	func_audioloudness = 0;

    
	if (maxframes == 1) and (anienable)
	{
	    maxframes = 64;
	    scope_end = 63;
	    refresh_minitimeline_flag = 1;
    
	    if (ds_list_size(frame_list) < maxframes)
	        repeat (maxframes - ds_list_size(frame_list))
	        {
	            templist = ds_list_create();
	            if (fillframes)
	            {
	                tempelcount = ds_list_size(ds_list_find_value(frame_list,ds_list_size(frame_list)-1));
	                for (u = 0;u < tempelcount;u++)
	                {
	                    tempellist = ds_list_create();
	                    ds_list_copy(tempellist,ds_list_find_value(ds_list_find_value(frame_list,ds_list_size(frame_list)-1),u));
	                    ds_list_add(templist,tempellist);
	                }
	            }
	            ds_list_add(frame_list,templist);
	        }
	}


	autoresflag = 0;
	if (is_string(resolution))
	{
	    autoresflag = 1;
	    if ((placing == "line") && (blankmode == "solid") && (colormode == "solid"))
	        resolution = opt_maxdist;
	    else
	        resolution = 1300;
        
	    if (colormode != "solid") or (blankmode != "solid")
	        resolution = 500;
    
	    if (anienable) and (blankmode != "solid") and ((blank_offset != aniblank_offset) or (blank_dc != aniblank_dc))
	        resolution = 250;
	    else if (anienable) and (colormode != "solid") and ((color_offset != anicolor_offset) or (color_dc != anicolor_dc))
	        resolution = 250;
	}

	temp_undof_list = ds_list_create();
    
	for (l = 0; l < ds_list_size(semaster_list); l++)
	{
	    selectedelement = ds_list_find_value(semaster_list,l);

	    //find elements
	    temp_frame_list = ds_list_create();
	    if (fillframes)
	    {
	        for (i = scope_start;i <= scope_end;i++)
	        {
	            el_list_temp = ds_list_find_value(frame_list,i);
	            for (u = 0;u < ds_list_size(el_list_temp);u++)
	            {
	                if (ds_list_find_value(ds_list_find_value(el_list_temp,u),9) == selectedelement)
	                {
	                    if (ds_list_empty(temp_frame_list))
	                        startframe = i;
	                    ds_list_add(temp_frame_list,ds_list_find_value(el_list_temp,u))
	                    temp_undo_list = ds_list_create();
	                    ds_list_copy(temp_undo_list,ds_list_find_value(el_list_temp,u));
	                    ds_list_add(temp_undo_list,i);
	                    ds_list_add(temp_undof_list,temp_undo_list);
	                }
	            }
	        }
	    }
	    else
	    {
	        el_list_temp = ds_list_find_value(frame_list,frame);
	        for (u = 0; u < ds_list_size(el_list_temp); u++)
	        {
	            if (ds_list_find_value(ds_list_find_value(el_list_temp,u),9) == selectedelement)
	            {
	                if (ds_list_empty(temp_frame_list))
	                    startframe = frame;
	                ds_list_add(temp_frame_list,ds_list_find_value(el_list_temp,u))
	                temp_undo_list = ds_list_create();
	                ds_list_copy(temp_undo_list,ds_list_find_value(el_list_temp,u));
	                ds_list_add(temp_undo_list,frame);
	                ds_list_add(temp_undof_list,temp_undo_list);
	            }
	        }
	    }
    
	    randomize();
            
	    //walk through frames
    
    
	    for (i = 0;i < ds_list_size(temp_frame_list);i++)
	    {
		
	        blanknew = 1;
	        new_list = ds_list_find_value(temp_frame_list,i);
	        checkpoints = ((ds_list_size(new_list)-20)/4);
        
	        startpos[0] = ds_list_find_value(new_list,0);
	        startpos[1] = ds_list_find_value(new_list,1);
	        endx = ds_list_find_value(new_list,2);
	        endy = ds_list_find_value(new_list,3);
        
	        //interpolate
	        if (reap_interpolate)
	        {
	            for (j = 0; j < (checkpoints-1);j++)
	            {
	                temppos = 20+j*4;
	                length = point_distance( ds_list_find_value(new_list,temppos)
	                                        ,ds_list_find_value(new_list,temppos+1)
	                                        ,ds_list_find_value(new_list,temppos+4)
	                                        ,ds_list_find_value(new_list,temppos+5));
                
	                if  (length < resolution*phi)
	                    continue;
                
	                steps = length / resolution;
	                stepscount = round(steps-1);
	                tempx0 = ds_list_find_value(new_list,temppos);
	                tempy0 = ds_list_find_value(new_list,temppos+1);
	                tempvectx = (ds_list_find_value(new_list,temppos+4)-tempx0)/steps;
	                tempvecty = (ds_list_find_value(new_list,temppos+5)-tempy0)/steps;
	                tempblank = ds_list_find_value(new_list,temppos+6);
	                tempc = ds_list_find_value(new_list,temppos+7);
                
	                repeat(stepscount)
	                {
	                    newx = tempx0+tempvectx*(stepscount);
	                    newy = tempy0+tempvecty*(stepscount);
	                    ds_list_insert(new_list,temppos+4,tempc);
	                    ds_list_insert(new_list,temppos+4,tempblank);
	                    ds_list_insert(new_list,temppos+4,newy);
	                    ds_list_insert(new_list,temppos+4,newx);
	                    j++;
	                    checkpoints++;
	                    stepscount--;
	                }
                
	            }
	        }
            
        
	        if (anienable == 0) or (ds_list_size(temp_frame_list) == 1)
	        {
	            t = 0;
	            shaking_sdev_r = shaking_sdev;
	            gaussoffsetx = reap_trans*shaking*clamp(random_gaussian(0,shaking_sdev_r),-shaking_sdev_r*3,shaking_sdev_r*3);
	            gaussoffsety = reap_trans*shaking*clamp(random_gaussian(0,shaking_sdev_r),-shaking_sdev_r*3,shaking_sdev_r*3);
	            blank_freq_r = blank_freq;
	            blank_period_r = blank_period;
	            blank_dc_r = blank_dc;
	            blank_offset_r = degtorad(blank_offset);
	            color_freq_r = color_freq;
	            color_period_r = color_period;
	            color_dc_r = color_dc;
	            color_offset_r = degtorad(color_offset);
	            color1_r = color1;
	            color2_r = color2;
	            enddotscolor_r = enddotscolor;
	            endx_r = endx;
	            endy_r = endy;
	            startposx_r = startpos[0];
	            startposy_r  = startpos[1];
	        }
	        else
	        {
	            t = i/(ds_list_size(temp_frame_list)-0.99);    
	            t = (t*anirep)%1;
	            if (anifunc = "tri")
	            {
	                t *= 2;
	                if (t > 1)
	                    t = 1-(t%1);
	            }
	            else if (anifunc = "sine")
	            {
	                t = sin(t*pi*2);
	                t *= -1;
	                t += 1;
	                t /= 2;
	            }
				else if (anifunc = "cos")
	            {
	                t = cos(t*pi*2);
	                t *= -1;
	                t += 1;
	                t /= 2;
	            }
	            else if (anifunc = "easeout")
	            {
	                //t = sin(t*pi/2);
					t = 1 - power(1 - t, 2);
	            }
	            else if (anifunc = "easein")
	            {
	                //t = 1-cos(t*pi/2);
					t = t*t;
	            }
	            else if (anifunc = "bounce")
	            {
	                //t = sin(t*pi);
					t = 1 - ((t-0.5)*(t-0.5)*4);
	            }
	            else if (anifunc = "easeinout")
	            {
					t = t < 0.5 ? 2 * t*t  : 1 - power(-2 * t+2, 2) / 2;
	                /*t = sin(t*pi-pi/2);
	                t += 1;
	                t /= 2;*/
	            }
			
	            shaking_sdev_r = lerp(shaking_sdev,anishaking_sdev,t);
	            gaussoffsetx = reap_trans*shaking*clamp(random_gaussian(0,shaking_sdev_r),-shaking_sdev_r*3,shaking_sdev_r*3);
	            gaussoffsety = reap_trans*shaking*clamp(random_gaussian(0,shaking_sdev_r),-shaking_sdev_r*3,shaking_sdev_r*3);
	            blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,t);
	            blank_period_r = blank_period//lerp(blank_period,aniblank_period,t);
	            blank_dc_r = lerp(blank_dc,aniblank_dc,t);
	            blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,t));
	            color_freq_r = color_freq//lerp(color_freq,anicolor_freq,t);
	            color_period_r = color_period//lerp(color_period,anicolor_period,t);
	            color_dc_r = lerp(color_dc,anicolor_dc,t);
	            color_offset_r = degtorad(lerp(color_offset,anicolor_offset,t));
	            color1_r = merge_color(color1,anicolor1,t);
	            color2_r = merge_color(color2,anicolor2,t);
	            enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
	            endx_r = lerp(endx,endx,t)+gaussoffsetx;
	            endy_r = lerp(endy,endy,t)+gaussoffsety;
	            startposx_r = lerp(startpos[0],startpos[0],t)+gaussoffsetx;
	            startposy_r  = lerp(startpos[1],startpos[1],t)+gaussoffsety;
	        }
            
            
	        func_startofframe_blank();
            
        
	        if (controller.reap_blank)
	        {
	            if (blankmode == "dot") or (blankmode == "dotsolid")
	            {
	                if (blankmode2 == 0)
	                    dotfreq = checkpoints/(blank_freq_r);
	                else
	                    dotfreq = blank_period_r/512;
	                if (dotfreq < 1)
	                    dotfreq = 1;
	            }
	            else if (blankmode == "dash")
	            {
	                if (blankmode2 == 0)
	                    dotfreq = checkpoints/(blank_freq_r+0.48);
	                else
	                    dotfreq = blank_period_r/512;
	                if (dotfreq < 1)
	                    dotfreq = 1;
	            }
	            var t_loop = (ds_list_find_value(new_list,20+checkpoints*4) == ds_list_find_value(new_list,20)) and 
							(ds_list_find_value(new_list,21+checkpoints*4) == ds_list_find_value(new_list,21));
	        }
            
	        if (controller.reap_color)
	        {
	            if (colormode == "dash")
	            {
	                if (colormode2 == 0)
	                    colorfreq = checkpoints/(color_freq_r+0.48);
	                else
	                    colorfreq = color_period_r/512;
	                if (colorfreq < 1)
	                    colorfreq = 1;
	            }
	        }
            
    
	        //walk through points
	        for (j = 0; j < checkpoints;j++)
	        {
	            listpos = 20+j*4;
	            xp = ds_list_find_value(new_list,listpos);
	            yp = ds_list_find_value(new_list,listpos+1);
            
            
	            if ((j != 0) and (ds_list_find_value(new_list,listpos) == ds_list_find_value(new_list,20+(j-1)*4)) and 
	            (ds_list_find_value(new_list,listpos+1) == ds_list_find_value(new_list,21+(j-1)*4)) and (controller.reap_removeoverlap))
	            {
	                repeat(4) ds_list_delete(new_list,listpos);
	                checkpoints--;
	                j--;
	                continue;
	            }
                
	            makedot = 0;
            
            
	            if (controller.reap_color)
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
	                        c = make_colour_hsv(((color_offset_r/(2*pi)+ (checkpoints-j)*color_freq_r/checkpoints)*255)%255,255,255); 
	                    }
	                    else
	                    {
	                        c = make_colour_hsv(((color_offset_r/(2*pi)+ (checkpoints-j)*resolution/color_period_r)*255)%255,255,255);
	                    }
	                }
	                else if (colormode == "gradient")
	                {
	                    if (colormode2 == 0)
	                    {
	                        tt = color_offset_r/(2*pi)+ (checkpoints-j)*color_freq_r/checkpoints;
	                        tt = (tt*2) mod 2;
	                        if (tt > 1) tt = 2-tt;
	                        c = merge_colour(color1_r,color2_r,tt);
	                    }
	                    else
	                    {
	                        tt = color_offset_r/(2*pi)+ (checkpoints-j)*resolution/color_period_r;
	                        tt = (tt*2) mod 2;
	                        if (tt > 1) tt = 2-tt;
	                        c = merge_colour(color1_r,color2_r,tt);
	                    }
	                }
	                else if (colormode == "dash")
	                {
	                    if (color_dc_r >= 0.98)
	                    {
	                        c = color1_r;
	                    }
	                    else if (floor(j+color_offset_r/pi/2*colorfreq) % floor(colorfreq) > color_dc_r*colorfreq) or (color_dc_r < 0.02)
	                    {
	                        c = color2_r;
	                    }
	                    else 
	                    {
	                        c = color1_r;
	                    }
	                }
	                else if (colormode == "func")
	                {
	                    if (!func_color_reapply())
	                    {
	                        frame = framepre;
	                        if (autoresflag)
	                            resolution = "auto";
	                        return 0;
	                    }
	                }
                    
	                //blending
	                if (color_blendmode == 1)
	                {
	                    cr = clamp(colour_get_red(ds_list_find_value(new_list,listpos+3))   +colour_get_red(c),0,255);
	                    cg = clamp(colour_get_green(ds_list_find_value(new_list,listpos+3)) +colour_get_green(c),0,255);
	                    cb = clamp(colour_get_blue(ds_list_find_value(new_list,listpos+3))  +colour_get_blue(c),0,255);
	                    c = make_colour_rgb(cr,cg,cb);
	                }
	                else if (color_blendmode == 2)
	                {
	                    cr = clamp(colour_get_red(ds_list_find_value(new_list,listpos+3))   -colour_get_red(c),0,255);
	                    cg = clamp(colour_get_green(ds_list_find_value(new_list,listpos+3)) -colour_get_green(c),0,255);
	                    cb = clamp(colour_get_blue(ds_list_find_value(new_list,listpos+3))  -colour_get_blue(c),0,255);
	                    c = make_colour_rgb(cr,cg,cb);
	                }
                
	                ds_list_replace(new_list,listpos+3,c);
                    
	            }
            
            
	            if (controller.reap_blank)
	            {
	                //BLANK
	                if (blankmode == "solid")
	                {
	                    blank = 0;
	                    if ((j == 0) or (j == checkpoints-1)) and (enddots) and (t_loop)
	                        makedot = 1;
	                }
	                else if (blankmode == "dash")
	                {
	                    if (blank_dc_r >= 0.98)
	                    {
	                        blank = 0;
	                        blanknew = 0;
	                        /*
	                        if (blanknew != blank) and (enddots) and !(((j == 1) or (j == checkpoints-1)) and (!t_loop))
	                        {
	                            makedot = 2;
	                            blanknew = blank;
	                        }*/
	                        if ((j == 0) or (j == checkpoints-1)) and (enddots) and (t_loop)
	                            makedot = 1;
	                    }
	                     else if (floor(j+blank_offset_r/pi/2*dotfreq) % round(dotfreq) > blank_dc_r*dotfreq) or (blank_dc_r < 0.02)
	                    {
	                        blank = 1;
	                        if (blanknew != blank) and (enddots) and !(((j == 0) or (j == checkpoints-1)) and (!t_loop))
	                        {
	                            makedot = 2;
	                            blanknew = blank;
	                        }
	                    }
	                    else 
	                    {
	                        blank = 0;
	                        if (blanknew != blank) and (enddots) and !(((j == 0) or (j == checkpoints-1)) and (!t_loop))
	                        {
	                            makedot = 2;
	                            blanknew = blank;
	                        }
	                    }
	                }
	                else if (blankmode == "dot")
	                {
	                    if (floor(j-dotfreq+blank_offset_r/pi/2*dotfreq) % floor(dotfreq) == 0)
	                        makedot = 1;
	                    blank = 1;
	                }
	                else if (blankmode == "dotsolid")
	                {
	                    if (floor(j-dotfreq+blank_offset_r/pi/2*dotfreq) % floor(dotfreq) == 0)
	                        makedot = 1;
	                    blank = 0;
	                }
	                else if (blankmode == "func")
	                {
	                    if (!func_blank_reapply())
	                    {
	                        frame = framepre;
	                        if (autoresflag)
	                            resolution = "auto";
	                        return 0;
	                    }
                        
	                    if (blanknew != blank) and (enddots)
	                    {
	                        makedot = 2;
	                        blanknew = blank;
	                    }
	                }
                    
	                //blending
	                if (blank_blendmode == 1)
	                {
	                    blank = !(!ds_list_find_value(new_list,listpos+2) and !blank);
	                }
	                else if (blank_blendmode == 2)
	                {
	                    blank = !(!ds_list_find_value(new_list,listpos+2) or !blank);
	                }
	                else if (blank_blendmode == 3)
	                {
	                    blank = !(!ds_list_find_value(new_list,listpos+2) xor !blank);
	                }
                    
                        
	                if (enddots)
	                {
	                    if (!makedot) and (blankmode != "dot") and (j == checkpoints) and (blank == 0)
	                        makedot = 1;
	                }
                
                
                    
	                if (makedot)
	                {
	                    if (blankmode == "dot")
	                    {
	                        ds_list_replace(new_list,listpos+2,1);
	                        repeat (dotmultiply)
	                        {
	                            ds_list_insert(new_list,listpos+4,ds_list_find_value(new_list,listpos));
	                            ds_list_insert(new_list,listpos+5,ds_list_find_value(new_list,listpos+1));
	                            ds_list_insert(new_list,listpos+6,0);
	                            ds_list_insert(new_list,listpos+7,enddotscolor_r);
	                            checkpoints++;
	                            j++;
	                        }
	                    }
	                    else
	                    {
	                        if (makedot == 2)
	                        {
	                            /*if (blank)
	                                ds_list_replace(new_list,20+(j-1)*6+2,1);
	                            else
	                                ds_list_replace(new_list,20+(j-1)*6+2,0);*/
	                            icount = 0;
	                            repeat (dotmultiply)
	                            {
	                                icount++;
	                                ds_list_insert(new_list,listpos+4,enddotscolor_r);
	                                ds_list_insert(new_list,listpos+4,0);
	                                ds_list_insert(new_list,listpos+4,ds_list_find_value(new_list,listpos+1));
	                                ds_list_insert(new_list,listpos+4,ds_list_find_value(new_list,listpos));
	                            }
	                            j+= icount;
	                            checkpoints += icount;
	                        }
	                        else
	                        {
	                            ds_list_replace(new_list,listpos+2,0);
	                            icount = 0;
	                            repeat (dotmultiply)
	                            {
	                                icount++;
	                                ds_list_insert(new_list,listpos+4,ds_list_find_value(new_list,listpos));
	                                ds_list_insert(new_list,listpos+5,ds_list_find_value(new_list,listpos+1));
	                                ds_list_insert(new_list,listpos+6,0);
	                                ds_list_insert(new_list,listpos+7,enddotscolor_r);
	                            }
	                            j+= icount;
	                            checkpoints += icount;
	                        }
	                    }
	                }  
	                else
	                { 
	                    ds_list_replace(new_list,listpos+2,blank);
	                }
	            }     
	        }       
        
	        if (reap_trans)
	        {
	            ds_list_replace(new_list,0,startposx_r);
	            ds_list_replace(new_list,1,startposy_r);
	            ds_list_replace(new_list,2,endx_r);
	            ds_list_replace(new_list,3,endy_r);
	        }
         
	    }
	}
    
	if (autoresflag)
		resolution = "auto";

	frame_surf_refresh = 1;
	ds_list_add(undo_list,"k"+string(temp_undof_list));




}
