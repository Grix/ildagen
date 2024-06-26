function import_font_end() {
	with(controller)
	{
		ds_map_clear(font_map);
		for (i = 0; i < ds_list_size(ild_list); i++)
	    {
			var t_unicodeId = ild_list[| i][| 8];
			if (t_unicodeId > 20)
			{
				ds_map_add(font_map, t_unicodeId, ild_list[| i]);
			}
		}
		
	    ds_list_copy(font_list,ild_list);
    
	    buffer_delete(ild_file);
	    ds_list_free_pool(ild_list); ild_list=-1;
        
	    //interpolate
	    for (i = 0; i < ds_list_size(font_list); i++)
	    {
	        new_list = ds_list_find_value(font_list,i);
	        checkpoints = ((ds_list_size(new_list)-20)/4);
        
	        for (j = 0; j < (checkpoints-1);j++)
	        {
	            temppos = 20+j*4;
            
	            //if  (ds_list_find_value(new_list,temppos+8) == 1)
	            //    continue;
                
	            if  (ds_list_find_value(new_list,temppos+7) == 0) &&
	                (ds_list_find_value(new_list,temppos+8) == 0) &&
	                (ds_list_find_value(new_list,temppos+9) == 0)
	            {
	                ds_list_replace(new_list,temppos+2,1);
	                continue;
	            }
                
	            length = point_distance( ds_list_find_value(new_list,temppos)
	                                    ,ds_list_find_value(new_list,temppos+1)
	                                    ,ds_list_find_value(new_list,temppos+4)
	                                    ,ds_list_find_value(new_list,temppos+5));
            
	            if (length < 800*phi) continue;
            
	            steps = length / 800;
	            stepscount = round(steps-1);
	            tempx0 = ds_list_find_value(new_list,temppos);
	            tempy0 = ds_list_find_value(new_list,temppos+1);
	            tempvectx = (ds_list_find_value(new_list,temppos+4)-tempx0)/steps;
	            tempvecty = (ds_list_find_value(new_list,temppos+5)-tempy0)/steps;
	            tempblank = ds_list_find_value(new_list,temppos+6);
	            tempc = ds_list_find_value(new_list,temppos+7);
                   
	            repeat(floor(stepscount))
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
        
	    el_id++;
	    font_type = 0;
	}
    
	add_action_history_ilda("ILDA_import_font");
	
	if (ds_list_size(font_list) < 65/* || ds_list_size(font_list) > 100*/)
		show_message_new("Warning: Unexpectedly few number of frames in the ILD file. Some symbols might not work. Is this a valid LaserBoy font file?");
	
	if (ttlpalette == 0)
		pal_list = pal_list_ilda;
	else
		pal_list = pal_list_ttl;
	
	global.loading_importfont = 0;
	room_goto(rm_ilda);

	return 1;



}
