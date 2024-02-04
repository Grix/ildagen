function create_element() {
	//creates an element from whatever has been done on the screen

	lastpointadded = 0
	framepre = frame;
	placing_status = 0;
	clean_redo_list();
        
	if (maxframes == 1) and (anienable)
	{
	    //ds_list_add(controller.undo_list,"a"+string(controller.maxframes))
	    maxframes = 64;
	    scope_end = 63;
	    refresh_minitimeline_flag = 1;
    
	    if (ds_list_size(frame_list) < maxframes)
	        repeat (maxframes - ds_list_size(frame_list))
	        {
	            templist = ds_list_create_pool();
	            if (fillframes)
	            {
	                tempelcount = ds_list_size(ds_list_find_value(frame_list,ds_list_size(frame_list)-1));
	                for (u = 0;u < tempelcount;u++)
	                {
	                    tempellist = ds_list_create_pool();
	                    ds_list_copy(tempellist,ds_list_find_value(ds_list_find_value(frame_list,ds_list_size(frame_list)-1),u));
	                    ds_list_add(templist,tempellist);
	                }
	            }
	            ds_list_add(frame_list,templist);
	        }
	}


	if (!keyboard_check(vk_shift))
	{
	    endx = obj_cursor.x/view_wport[4]*$ffff;
	    endy = obj_cursor.y/view_wport[4]*$ffff;
	}
	else
	{
		var t_startx = startpos[0]/$ffff*view_wport[4];
		var t_starty = camera_get_view_y(view_camera[4])+startpos[1]/$ffff*view_wport[4];
		var t_theta = point_direction(t_startx,t_starty,mouse_x,mouse_y);
	    if (t_theta > 315 || t_theta < 45 || (t_theta > 135 && t_theta < 225))
	    {
	        endx = obj_cursor.x/view_wport[4]*$ffff;
	        endy = startpos[1];
	    }
	    else
	    {
	        endx = startpos[0];
	        endy = obj_cursor.y/view_wport[4]*$ffff;
	    }
	}
    
	autoresflag = 0;
	if (is_string(resolution))
	{
	    autoresflag = 1;
	    resolution = 300;
    
	    if (anienable) and (blankmode != "solid") and ((blank_offset != aniblank_offset) or (blank_dc != aniblank_dc))
	        resolution = 200;
	    else if (anienable) and (colormode != "solid") and ((color_offset != anicolor_offset) or (color_dc != anicolor_dc))
	        resolution = 200;
	}
    
	randomize();

	//PREPARING FUNCTIONS
	if (placing == "func")
	{
	    if (shapefunc_string_x == "") or is_undefined(shapefunc_string_x) 
	    {
	        show_message_new("Please write a function for X");
	        frame = framepre;
	        return 0;
	    }
	    if (shapefunc_string_y == "") or is_undefined(shapefunc_string_y) 
	    {
	        show_message_new("Please write a function for Y");
	        frame = framepre;
	        return 0;
	    }
    
	    compiled_x = ML_Compile(parser_shape,shapefunc_string_x); 
	    if (!ML_NoException(parser_shape))
	    {
	        show_message_new("Error in X: "+ML_LastExceptionString(parser_shape));
	        ML_CompileCleanup(compiled_x);
	        ML_ClearExceptions(parser_shape);
	        frame = framepre;
	        return 0;
	    }
	    compiled_y = ML_Compile(parser_shape,shapefunc_string_y);
	    if (!ML_NoException(parser_shape))
	    {
	        show_message_new("Error in Y: "+ML_LastExceptionString(parser_shape));
	        ML_CompileCleanup(compiled_x);
	        ML_CompileCleanup(compiled_y);
	        ML_ClearExceptions(parser_shape);
	        frame = framepre;
	        return 0;
	    }
	}
    
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
		if (placing == "func")
		{
			if (string_pos("audio_", shapefunc_string_x) != 0)
				func_doaudio = 1;
			else if (string_pos("audio_", shapefunc_string_y) != 0)
				func_doaudio = 1;
		}
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

    
	//ONLY ONE FRAME
	if (!fillframes)
	{
	    new_list = ds_list_create_pool();
    
	    if (anienable == 0) or (maxframes == 1)
	    {
	        t = 0;
	        shaking_sdev_r = shaking_sdev;
	        gaussoffsetx = shaking*clamp(random_gaussian(0,shaking_sdev_r),-shaking_sdev_r*3,shaking_sdev_r*3);
	        gaussoffsety = shaking*clamp(random_gaussian(0,shaking_sdev_r),-shaking_sdev_r*3,shaking_sdev_r*3);
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
	        wave_period_r = wave_period;
	        wave_offset_r = degtorad(wave_offset);
	        wave_amp_r = wave_amp;
	        endx_r = endx;
	        endy_r = endy;
	        startposx_r = startpos[0];
	        startposy_r  = startpos[1];
	    }
	    else
	    {
	        t = ((frame-scope_start)/(scope_end-scope_start+1))%1;
					
	        t = (t*anirep);
			if (t > 1 || t < 0)
			{
				if (t % 1 == 0)
					t = 1;
				else
					t = t % 1;
			}
			
	        if (anifunc == "tri")
	        {
	            t *= 2;
	            if (t == 2)
					t = 0;
	            else if (t > 1)
	                t = 1-(t%1);
	        }
	        else if (anifunc == "sine")
	        {
	            t = sin(t*pi*2);
	            t *= -1;
	            t += 1;
	            t /= 2;
	        }
			else if (anifunc == "cos")
	        {
	            t = cos(t*pi*2);
	            t *= -1;
	            t += 1;
	            t /= 2;
	        }
	        else if (anifunc == "easeout")
	        {
	            //t = sin(t*pi/2);
				t = 1 - power(1 - t, 2);
	        }
	        else if (anifunc == "easein")
	        {
	            //t = 1-cos(t*pi/2);
				t = t*t;
	        }
	        else if (anifunc == "bounce")
	        {
	            //t = sin(t*pi);
				t = 1 - ((t-0.5)*(t-0.5)*4);
	        }
	        else if (anifunc == "easeinout")
	        {
				t = ease_in_out(t);
	            /*t = sin(t*pi-pi/2);
	            t += 1;
	            t /= 2;*/
	        }
			if (anifunc == "step")
	        {
				if (t < 0.5)
					t = 0;
	            else 
	                t = 1;
	        }
			
			if (anireverse)
				t = 1-t;
            
	        shaking_sdev_r = lerp(shaking_sdev,anishaking_sdev,t);
	        gaussoffsetx = shaking*clamp(random_gaussian(0,shaking_sdev_r),-shaking_sdev_r*3,shaking_sdev_r*3);
	        gaussoffsety = shaking*clamp(random_gaussian(0,shaking_sdev_r),-shaking_sdev_r*3,shaking_sdev_r*3);
	        blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,t);
	        blank_period_r = blank_period//lerp(blank_period,aniblank_period,t);
	        blank_dc_r = lerp(blank_dc,aniblank_dc,t);
	        blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,t));
	        color_freq_r = color_freq//lerp(color_freq,anicolor_freq,t);
	        color_period_r = color_period//lerp(color_period,anicolor_period,t);
	        color_dc_r = lerp(color_dc,anicolor_dc,t);
	        color_offset_r = degtorad(lerp(color_offset,anicolor_offset,t));
	        wave_period_r = wave_period//lerp(color_period,anicolor_period,t);
	        wave_amp_r = lerp(wave_amp,aniwave_amp,t);
	        wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
	        color1_r = merge_color(color1,anicolor1,t);
	        color2_r = merge_color(color2,anicolor2,t);
	        enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
	        endx_r = endx+gaussoffsetx;
	        endy_r = endy+gaussoffsety;
	        startposx_r = startpos[0]+gaussoffsetx;
	        startposy_r = startpos[1]+gaussoffsety;
	    }

	    if (placing == "curve")
	    {
	        ds_list_add(new_list,ds_list_find_value(bez_list,0)); //origo x
	        ds_list_add(new_list,ds_list_find_value(bez_list,1)); //origo y
	        ds_list_add(new_list,ds_list_find_value(bez_list,6)); //end x
	        ds_list_add(new_list,ds_list_find_value(bez_list,7)); //end y
	    }
	    else if (placing == "text")
	    {
	        ds_list_add(new_list,(startposx_r+xdelta[frame])); //origo x
	        ds_list_add(new_list,startposy_r); //origo y
	        ds_list_add(new_list,(endx_r+xdelta[frame])); //end x
	        ds_list_add(new_list,endy_r); //end y
	    }
	    else if (placing == "func")
	    {
	        ds_list_add(new_list,0); //origo x
	        ds_list_add(new_list,0); //origo y
	        ds_list_add(new_list,0); //end x
	        ds_list_add(new_list,0); //end y
	    }
	    else
	    {
	        ds_list_add(new_list,startposx_r); //origo x
	        ds_list_add(new_list,startposy_r); //origo y
	        ds_list_add(new_list,endx_r); //end x
	        ds_list_add(new_list,endy_r); //end y
	    }
	    ds_list_add(new_list,0);
	    ds_list_add(new_list,0);
	    ds_list_add(new_list,0);
	    ds_list_add(new_list,0);
	    ds_list_add(new_list,0);
	    ds_list_add(new_list,el_id);
	    repeat (10) 
			ds_list_add(new_list,0);
    
    
	    func_startofframe();
    
	    if (placing == "line") //create a line
	    {
	        if (!create_line())
	        {
	            ilda_cancel();
	            ds_list_free_pool(new_list); new_list = -1;
	            if (autoresflag)
	                resolution = "auto";
	            frame = framepre;
	            return 0;
	        }
	    }
        
	    else if (placing == "circle") //create a circle
	    {
	        if (!create_circle())
	        {
	            ilda_cancel();
	            ds_list_free_pool(new_list); new_list = -1;
	            if (autoresflag)
	                resolution = "auto";
	            frame = framepre;
	            return 0;
	        }
	    }
        
	    else if (placing == "wave") //create a wave
	    {
	        if (!create_wave())
	        {
	            ilda_cancel();
	            ds_list_free_pool(new_list); new_list = -1;
	            if (autoresflag)
	                resolution = "auto";
	            frame = framepre;
	            return 0;
	        }
	    }

	    else if (placing == "free") //create a free drawn shape
	    {
	        if (!create_free())
	        {
	            ilda_cancel();
	            ds_list_free_pool(new_list); new_list = -1;
	            if (autoresflag)
	                resolution = "auto";
	            frame = framepre;
	            return 0;
	        }
	    }
        
	    else if (placing == "curve") //create a curve
	    {
	        if (!create_curve())
	        {
	            ilda_cancel();
	            ds_list_free_pool(new_list); new_list = -1;
	            if (autoresflag)
	                resolution = "auto";
	            frame = framepre;
	            return 0;
	        }
	    }
        
	    else if (placing == "text") //create a letter/text
	    {
	        if (!create_letter())
	        {
	            ilda_cancel();
	            ds_list_free_pool(new_list); new_list = -1;
	            if (autoresflag)
	                resolution = "auto";
	            frame = framepre;
	            return 0;
	        }
	    }
	    else if (placing == "hershey") //create a symbol
	    {
	        if (!create_hershey())
	        {
	            ilda_cancel();
	            ds_list_free_pool(new_list); new_list = -1;
	            if (autoresflag)
	                resolution = "auto";
	            frame = framepre;
	            return 0;
	        }
	    }
        
	    else if (placing == "func") //create a function based shape
	    {
	        if (!create_func())
	        {
	            ilda_cancel();
	            ds_list_free_pool(new_list); new_list = -1;
	            if (autoresflag)
	                resolution = "auto";
	            frame = framepre;
	            return 0;
	        }
	    }
    
	    ds_list_replace(new_list,4,xmin);
	    ds_list_replace(new_list,5,xmax);
	    ds_list_replace(new_list,6,ymin);
	    ds_list_replace(new_list,7,ymax);
        
	    ds_list_add(ds_list_find_value(frame_list,frame),new_list);
    
	}
	else
	{
	    frame = scope_start;
	    repeat (scope_end-scope_start+1)
	    {
			if (func_doaudio == 3)
				func_doaudio = 2;
			
	        new_list = ds_list_create_pool();

	        if (anienable == 0) or (maxframes == 1)
	        {
	            t = 0;
	            shaking_sdev_r = shaking_sdev;
	            gaussoffsetx = shaking*clamp(random_gaussian(0,shaking_sdev_r),-shaking_sdev_r*3,shaking_sdev_r*3);
	            gaussoffsety = shaking*clamp(random_gaussian(0,shaking_sdev_r),-shaking_sdev_r*3,shaking_sdev_r*3);
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
	            wave_period_r = wave_period;
	            wave_offset_r = degtorad(wave_offset);
	            wave_amp_r = wave_amp;
	            endx_r = endx;
	            endy_r = endy;
	            startposx_r = startpos[0];
	            startposy_r  = startpos[1];
	        }
	        else
	        {
	            t = ((frame-scope_start)/(scope_end-scope_start+1))%1;
				
					
		        t = (t*anirep);
				if (t > 1 || t < 0)
				{
					if (t % 1 == 0)
						t = 1;
					else
						t = t % 1;
				}
				
	            if (anifunc == "tri")
	            {
	                t *= 2;
	                if (t == 2)
						t = 0;
	                else if (t > 1)
	                    t = 1-(t%1);
	            }
	            else if (anifunc == "sine")
	            {
	                t = sin(t*pi*2);
	                t *= -1;
	                t += 1;
	                t /= 2;
	            }
				else if (anifunc == "cos")
	            {
	                t = cos(t*pi*2);
	                t *= -1;
	                t += 1;
	                t /= 2;
	            }
	            else if (anifunc == "easeout")
	            {
	                //t = sin(t*pi/2);
					t = 1 - power(1 - t, 2);
	            }
	            else if (anifunc == "easein")
	            {
	                //t = 1-cos(t*pi/2);
					t = t*t;
	            }
	            else if (anifunc == "bounce")
	            {
	                //t = sin(t*pi);
					t = 1 - ((t-0.5)*(t-0.5)*4);
	            }
	            else if (anifunc == "easeinout")
	            {
					t = ease_in_out(t);
	                /*t = sin(t*pi-pi/2);
	                t += 1;
	                t /= 2;*/
	            }
				if (anifunc == "step")
	            {
					if (t < 0.5)
						t = 0;
	                else 
	                    t = 1;
	            }
				
				if (anireverse)
					t = 1-t;
                
	            shaking_sdev_r = lerp(shaking_sdev,anishaking_sdev,t);
	            gaussoffsetx = shaking*clamp(random_gaussian(0,shaking_sdev_r),-shaking_sdev_r*3,shaking_sdev_r*3);
	            gaussoffsety = shaking*clamp(random_gaussian(0,shaking_sdev_r),-shaking_sdev_r*3,shaking_sdev_r*3);
	            blank_freq_r = blank_freq//lerp(blank_freq,aniblank_freq,t);
	            blank_period_r = blank_period//lerp(blank_period,aniblank_period,t);
	            blank_dc_r = lerp(blank_dc,aniblank_dc,t);
	            blank_offset_r = degtorad(lerp(blank_offset,aniblank_offset,t));
	            color_freq_r = color_freq//lerp(color_freq,anicolor_freq,t);
	            color_period_r = color_period//lerp(color_period,anicolor_period,t);
	            color_dc_r = lerp(color_dc,anicolor_dc,t);
	            color_offset_r = degtorad(lerp(color_offset,anicolor_offset,t));
	            wave_period_r = wave_period;//lerp(color_period,anicolor_period,t);
	            wave_amp_r = lerp(wave_amp,aniwave_amp,t);
	            wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,t));
	            color1_r = merge_color(color1,anicolor1,t);
	            color2_r = merge_color(color2,anicolor2,t);
	            enddotscolor_r = merge_color(enddotscolor,anienddotscolor,t);
	            endx_r = endx+gaussoffsetx;
	            endy_r = endy+gaussoffsety;
	            startposx_r = startpos[0]+gaussoffsetx;
	            startposy_r = startpos[1]+gaussoffsety;
	        }
            
	        if (placing == "curve")
	        {
	            ds_list_add(new_list,ds_list_find_value(bez_list,0)); //origo x
	            ds_list_add(new_list,ds_list_find_value(bez_list,1)); //origo y
	            ds_list_add(new_list,ds_list_find_value(bez_list,6)); //end x
	            ds_list_add(new_list,ds_list_find_value(bez_list,7)); //end y
	        }
	        else if (placing == "text")
	        {
	            ds_list_add(new_list,(startposx_r+xdelta[frame])); //origo x
	            ds_list_add(new_list,startposy_r); //origo y
	            ds_list_add(new_list,(endx_r+xdelta[frame])); //end x
	            ds_list_add(new_list,endy_r); //end y
            
	        }    
	        else if (placing == "func")
	        {
	            ds_list_add(new_list,0); //origo x
	            ds_list_add(new_list,0); //origo y
	            ds_list_add(new_list,0); //end x
	            ds_list_add(new_list,0); //end y
	        }
	        else
	        {
	            ds_list_add(new_list,startposx_r); //origo x
	            ds_list_add(new_list,startposy_r); //origo y
	            ds_list_add(new_list,endx_r); //end x
	            ds_list_add(new_list,endy_r); //end y
	        }
	        ds_list_add(new_list,0);
	        ds_list_add(new_list,0);
	        ds_list_add(new_list,0);
	        ds_list_add(new_list,0);
	        ds_list_add(new_list,0);
	        ds_list_add(new_list,el_id);
	        repeat (10) 
				ds_list_add(new_list,0);
        
        
	        func_startofframe();
        
	        if (placing == "line") //create a line
	        {
	            if (!create_line())
	            {
	                ilda_cancel();
	                ds_list_free_pool(new_list); new_list = -1;
	                if (autoresflag)
	                    resolution = "auto";
	                frame = framepre;
	                return 0;
	            }
	        }
            
	        else if (placing == "circle") //create a circle
	        {
	            if (!create_circle())
	            {
	                ilda_cancel();
	                ds_list_free_pool(new_list); new_list = -1;
	                frame = framepre;                
	                if (autoresflag)
	                    resolution = "auto";
	                return 0;
	            }
	        }
            
	        else if (placing == "wave") //create a wave
	        {
	            if (!create_wave())
	            {
	                ilda_cancel();
	                ds_list_free_pool(new_list);  new_list = -1;             
	                if (autoresflag)
	                    resolution = "auto";
	                frame = framepre;
	                return 0;
	            }
	        }
    
	        else if (placing == "free") //create a free drawn shape
	        {
	            if (!create_free())
	            {
	                ilda_cancel();
	                ds_list_free_pool(new_list);  new_list = -1;           
	                if (autoresflag)
	                    resolution = "auto";
	                frame = framepre;
	                return 0;
	            }
	        }
            
	        else if (placing == "curve") //create a curve
	        {
	            if (!create_curve())
	            {
	                ilda_cancel();
	                ds_list_free_pool(new_list);   new_list = -1;              
	                if (autoresflag)
	                    resolution = "auto";
	                frame = framepre;
	                return 0;
	            }
	        }
            
	        else if (placing == "text") //create a letter/text
	        {
	            if (!create_letter())
	            {
	                ilda_cancel();
	                ds_list_free_pool(new_list);   new_list = -1;              
	                if (autoresflag)
	                    resolution = "auto";
	                frame = framepre;
	                return 0;
	            }
	        }
	        else if (placing == "hershey") //create a symbol
	        {
	            if (!create_hershey())
	            {
	                ilda_cancel();
	                ds_list_free_pool(new_list); new_list = -1;
	                if (autoresflag)
	                    resolution = "auto";
	                frame = framepre;
	                return 0;
	            }
	        }
            
	        else if (placing == "func") //create a function based shape
	        {
	            if (!create_func())
	            {
	                ilda_cancel();
	                ds_list_free_pool(new_list);    new_list = -1;             
	                if (autoresflag)
	                    resolution = "auto";
	                frame = framepre;
	                return 0;
	            }
	        }
            
	        ds_list_replace(new_list,4,xmin);
	        ds_list_replace(new_list,5,xmax);
	        ds_list_replace(new_list,6,ymin);
	        ds_list_replace(new_list,7,ymax);
            
            
	        ds_list_add(ds_list_find_value(frame_list,frame),new_list);
        
	        frame++;
	    }
        
	    frame = framepre;
	}
    

	if (placing != "text") 
	    frame_surf_refresh = 1;

	if (autoresflag)
	    resolution = "auto";

	ilda_cancel();
	ds_list_add(undo_list,el_id);

	if (func_doaudio)
	{
		if (song_parse >= 0)
			FMODGMS_Snd_Unload(song_parse);
		song_parse = -1;
		buffer_delete(parsebuffer);
		buffer_delete(bufferIn);
		buffer_delete(bufferOut);
		parsebuffer = -1;
		bufferIn = -1;
		bufferOut = -1;
	}

	el_id++;


}
