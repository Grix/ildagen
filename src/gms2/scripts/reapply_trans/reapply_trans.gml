function reapply_trans() {
	//reapplies the object properties

	if (anixtrans == 0) && (aniytrans == 0) && (anirot == 0) && (scalex == 1) && (scaley == 1)
		exit;

	//create more frames if only one and animation is on
	if (maxframes == 1) and (anienable)
	{
		if (controller.use_bpm)
			maxframes = round(controller.projectfps / (controller.bpm / 60 / controller.beats_per_bar)); // one bar
		else
			maxframes = controller.projectfps * 2; // two seconds
	    scope_end = maxframes-1;
	    refresh_minitimeline_flag = 1;
    
	    if (ds_list_size(frame_list) < maxframes)
		{
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
	}

	temp_undof_list = ds_list_create_pool();

	for (c = 0; c < ds_list_size(semaster_list); c++)
	{
	    selectedelement = ds_list_find_value(semaster_list,c);
    
	    //find elements
	    temp_frame_list = ds_list_create_pool();
	    if (fillframes)
	    {
	        for (i = scope_start; i <= scope_end; i++)
	        {
	            el_list_temp = ds_list_find_value(frame_list,i);
	            for (u = 0; u < ds_list_size(el_list_temp); u++)
	            {
					if (!ds_list_exists_pool( el_list_temp[| u]))
					{
						ds_list_delete(el_list_temp, u);
						u--;
						continue;
					}
					
	                if (ds_list_find_value( el_list_temp[| u],9) == selectedelement)
	                {
	                    if (ds_list_empty(temp_frame_list))
	                        startframe = i;
	                    ds_list_add(temp_frame_list, el_list_temp[| u])
	                    temp_undo_list = ds_list_create_pool();
	                    ds_list_copy(temp_undo_list, el_list_temp[| u]);
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
	            if (ds_list_find_value( el_list_temp[| u],9) == selectedelement)
	            {
	                if (ds_list_empty(temp_frame_list))
	                    startframe = frame;
	                ds_list_add(temp_frame_list, el_list_temp[| u])
	                temp_undo_list = ds_list_create_pool();
	                ds_list_copy(temp_undo_list, el_list_temp[| u]);
	                ds_list_add(temp_undo_list,frame);
	                ds_list_add(temp_undof_list,temp_undo_list);
	            }
	        }
	    }
    
    
	    //walk through frames
	    for (i = 0;i < ds_list_size(temp_frame_list);i++)
	    {
	        new_list = ds_list_find_value(temp_frame_list,i);
	        checkpoints = ((ds_list_size(new_list)-20)/4);
        
	        startpos[0] = ds_list_find_value(new_list,0);
	        startpos[1] = ds_list_find_value(new_list,1);
	        endx = ds_list_find_value(new_list,2);
	        endy = ds_list_find_value(new_list,3);
        
	        if (anienable == 0) or (ds_list_size(temp_frame_list) == 1)
	        {
	            endx_r = endx+anixtrans;
	            endy_r = endy+aniytrans;
	            startposx_r = startpos[0]+anixtrans;
	            startposy_r  = startpos[1]+aniytrans;
	            rot_r = degtorad(anirot);
	            scalex_r = scalex;
	            scaley_r = scaley;
	        }
	        else
	        {
	            t = i/(ds_list_size(temp_frame_list)-1);
				
					
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
					//return x < 0.5 ? 4 * x * x * x : 1 - pow(-2 * x + 2, 3) / 2;
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
				
				if (editing_type == 1 && ds_list_exists_pool(edit_recording_list) && !ds_list_empty(edit_recording_list))
				{
					if (editing_path_normalized)
						edit_recording_list = normalize_editing_path(edit_recording_list);
					
					if (t > 1)
						t = 1;
					if (t < 0)
						t = 0;
					index = floor(ds_list_size(edit_recording_list) * t / 5) * 5;
					if (index >= ds_list_size(edit_recording_list))
						index = ds_list_size(edit_recording_list)-5;
						
					if (index >= ds_list_size(edit_recording_list)-9/* || checkpoints > ds_list_size(edit_recording_list)/5*2*/)
					{
						anixtrans = edit_recording_list[| index+0];
						aniytrans = edit_recording_list[| index+1];
						scalex = edit_recording_list[| index+2];
						scaley = edit_recording_list[| index+3];
						anirot = edit_recording_list[| index+4];
					}
					else
					{
						var t_lerpfactor = ((ds_list_size(edit_recording_list) * t) % 5) / 5;
						anixtrans = lerp(edit_recording_list[| index+0], edit_recording_list[| index+5+0], t_lerpfactor);
						aniytrans = lerp(edit_recording_list[| index+1], edit_recording_list[| index+5+1], t_lerpfactor);
						scalex = lerp(edit_recording_list[| index+2], edit_recording_list[| index+5+2], t_lerpfactor);
						scaley = lerp(edit_recording_list[| index+3], edit_recording_list[| index+5+3], t_lerpfactor);
						anirot = lerp(edit_recording_list[| index+4], edit_recording_list[| index+5+4], t_lerpfactor);
					}
					
					t = 1;
				}
                
	            endx_r = lerp(endx,endx+anixtrans,t);
	            endy_r = lerp(endy,endy+aniytrans,t);
	            startposx_r = lerp(startpos[0],startpos[0]+anixtrans,t);
	            startposy_r  = lerp(startpos[1],startpos[1]+aniytrans,t);
	            rot_r = degtorad(lerp(0,anirot,t));
	            scalex_r = lerp(1,scalex,t);
	            scaley_r = lerp(1,scaley,t);
	        }
            
	        xmax = -$ffff;
	        xmin = $ffff;
	        ymax = -$ffff;
	        ymin = $ffff;
            
	        //walk through points
	        for (j = 0; j < checkpoints;j++)
	        {
	            listpos = 20+j*4;
            
	            xp = startpos[0]+ds_list_find_value(new_list,listpos);
	            yp = startpos[1]+ds_list_find_value(new_list,listpos+1);
            
	            angle = degtorad(point_direction(anchorx,anchory,xp,yp));
	            dist = point_distance(anchorx,anchory,xp,yp);
            
	            xpnew = anchorx+cos(rot_r-angle)*dist*scalex_r-startpos[0];
	            ypnew = anchory+sin(rot_r-angle)*dist*scaley_r-startpos[1];
            
	            ds_list_replace(new_list,listpos,xpnew);
	            ds_list_replace(new_list,listpos+1,ypnew);
            
	            if (xpnew > xmax)
	               xmax = xpnew;
	            if (xpnew < xmin)
	               xmin = xpnew;
	            if (ypnew > ymax)
	               ymax = ypnew;
	            if (ypnew < ymin)
	               ymin = ypnew;
	        }
            
	        /*angle = degtorad(point_direction(anchorx,anchory,startposx_r,startposy_r));
	        dist = point_distance(anchorx,anchory,startposx_r,startposy_r);
        
	        startposx_r_fix = anchorx+cos(rot_r-angle)*dist*scalex_r;
	        startposy_r_fix = anchory+sin(rot_r-angle)*dist*scaley_r;*/
        
	        //TODO fix snapping
            
	        ds_list_replace(new_list,0,startposx_r);
	        ds_list_replace(new_list,1,startposy_r);
        
	        angle = degtorad(point_direction(anchorx,anchory,endx_r,endy_r));
	        dist = point_distance(anchorx,anchory,endx_r,endy_r);
        
	        endx_r_fix = anchorx+cos(rot_r-angle)*dist*scalex_r;
	        endy_r_fix = anchory+sin(rot_r-angle)*dist*scaley_r;
        
	        ds_list_replace(new_list,2,endx_r_fix);
	        ds_list_replace(new_list,3,endy_r_fix);
        
	        ds_list_replace(new_list,4,xmin);
	        ds_list_replace(new_list,5,xmax);
	        ds_list_replace(new_list,6,ymin);
	        ds_list_replace(new_list,7,ymax);    
	    }
	}

	frame_surf_refresh = 1;
	update_semasterlist_flag = 1;
	clean_redo_list();
	
	add_action_history_ilda("ILDA_reapplytrans");
	
	ds_list_add(undo_list,"k"+string(temp_undof_list));


}
