function refresh_surfaces() {
	//cycles through every element in frame on screen and draws them on the frame surfaces

	framepoints = 0;
	frame_complexity = 0;
	el_list = ds_list_find_value(frame_list,frame);

	if (!surface_exists(frame_surf))
	    frame_surf = surface_create(clamp(power(2, ceil(log2(view_wport[4]))), 1, 8192), clamp(power(2, ceil(log2(view_wport[4]))), 1, 8192));
	if (!surface_exists(frame3d_surf))
	    frame3d_surf = surface_create(clamp(power(2, ceil(log2(view_wport[4]))), 1, 8192), clamp(power(2, ceil(log2(view_wport[4]))), 1, 8192));

	var t_div = $ffff/max(1, view_wport[4]);

	if (viewmode == 0) or (viewmode == 2)
	{
	    surface_set_target(frame_surf);
	    draw_clear_alpha(c_white,0);
    
	    draw_set_alpha(1);
	    for (i = 0; i < ds_list_size(el_list); i++)
	    {
			if (!ds_list_exists_pool(el_list[| i]))
			{
				ds_list_delete(el_list, i);
				i--;
				continue;
			}
			
	        new_list = ds_list_find_value(el_list,i);
        
	        xo = ds_list_find_value(new_list,0)/t_div;
	        yo = ds_list_find_value(new_list,1)/t_div;
	        listsize = (((ds_list_size(new_list)-20)/4)-1);
        
	        for (u = 0; u < listsize; u++)
	        {
	            nextpos = 20+(u+1)*4;
	            nbl = (ds_list_find_value(new_list,nextpos+2));
            
	            if (nbl == 0)
	            {
	                xp = ds_list_find_value(new_list,nextpos-4);
	                yp = ds_list_find_value(new_list,nextpos-3);
                
	                nxp = ds_list_find_value(new_list,nextpos);
	                nyp = ds_list_find_value(new_list,nextpos+1);
                
					framepoints++;
                
	                if (!highlight)
					{
						if (is_undefined(ds_list_find_value(new_list,nextpos+3)))
							new_list[| nextpos+3] = c_white; //todo find bug?
	                    draw_set_color(ds_list_find_value(new_list,nextpos+3));
					}
	                else
	                    draw_set_color(c_white);
                    
	                if (abs(xp-nxp) < 8) && (abs(yp-nyp) < 8) && !(ds_list_find_value(new_list,nextpos-2)) // the last expression causes some dots to be invisible, but otherwise many ild files have ugly dots in them too. todo.
	                {
	                    draw_rectangle(xo+xp/t_div-2,yo+yp/t_div-2,xo+xp/t_div+2,yo+yp/t_div+2,0);
	                }
	                else
	                    draw_line_width(xo+ xp/t_div,yo+ yp/t_div,xo+ nxp/t_div,yo+ nyp/t_div, dpi_multiplier);
	            }
				else if (!controller.exp_optimize)
					framepoints++;
            
	        }
	    }
    
	    if (onion)
		    for (j = 1;j <= onion_number;j++)
		    {
		        if !(frame >= j) 
		            break;
        
		        el_list = ds_list_find_value(frame_list,frame-j);
    
		        draw_set_alpha(onion_alpha*power(onion_dropoff,j));
        
		        for (i = 0;i < ds_list_size(el_list);i++)
		        {
		            new_list = ds_list_find_value(el_list,i);
            
		            xo = ds_list_find_value(new_list,0)/t_div;
		            yo = ds_list_find_value(new_list,1)/t_div;
		            listsize = (((ds_list_size(new_list)-20)/4)-1);
            
		            for (u = 0; u < listsize; u++)
		            {
		                nextpos = 20+(u+1)*4;
		                nbl = ds_list_find_value(new_list,nextpos+2);
                
		                if (nbl == 0)
		                {
		                    xp = ds_list_find_value(new_list,nextpos-4);
		                    yp = ds_list_find_value(new_list,nextpos-3);
                    
		                    nxp = ds_list_find_value(new_list,nextpos);
		                    nyp = ds_list_find_value(new_list,nextpos+1);
                    
		                    draw_set_color(ds_list_find_value(new_list,nextpos+3));
		                    if (abs(xp-nxp) < 8) && (abs(yp-nyp) < 8) && !(ds_list_find_value(new_list,nextpos-2))
		                        draw_rectangle(xo+xp/t_div-2,yo+yp/t_div-2,xo+xp/t_div+2,yo+yp/t_div+2,0);
		                    else
		                        draw_line_width(xo+ xp/t_div,yo+ yp/t_div,xo+ nxp/t_div,yo+ nyp/t_div, dpi_multiplier);
		                }
                
		            }
		        }
			}
        
	    el_list = ds_list_find_value(frame_list,frame);
	    draw_set_alpha(1);
	    surface_reset_target();
	}

	if (viewmode != 0)
	{
	    surface_set_target(frame3d_surf);
	        refresh_3dsurfaces();
	    surface_reset_target();
	}

	//find point count
	if (controller.exp_optimize && (!controller.laseron || !controller.preview_while_laser_on))
	{
	    if (!controller.opt_onlyblanking)
	    {
	        if (prepare_output())
	        {
	            ds_list_free_pool(order_list); order_list = -1;
	            ds_list_free_pool(polarity_list); polarity_list = -1;
	            ds_list_free_pool(list_raw); list_raw = -1;
            
	            var t_totalpointswanted = floor(opt_scanspeed/projectfps);
	            var t_litpointswanted = t_totalpointswanted - maxpoints_static - maxpoints_dots - 3;
	            if (t_litpointswanted == 0) 
	                t_litpointswanted = 1;
	            if (lit_length != 0)
	            {
	                var t_lengthwanted = abs(lit_length/t_litpointswanted);
                
	                if (t_lengthwanted > controller.opt_maxdist/0.1)
	                    frame_complexity = 1;
	                else if (t_lengthwanted > controller.opt_maxdist/0.25)
	                    frame_complexity = 2;
	            }
	            else
	            {
	                if (t_litpointswanted < 0)
	                    frame_complexity = 2;
	            }
            
	            framepoints += maxpoints_static;
	        }
	    }
	    else
	        prepare_output_onlyblank();
	}
	else
	    prepare_output_unopt();

    



}
