function undo_ilda() {
	with (controller)
	{
		if (ds_list_empty(undo_list))
		    exit;

		ilda_cancel();
		ds_list_clear(semaster_list);
    
		undo = ds_list_find_value(undo_list,ds_list_size(undo_list)-1);
		ds_list_delete(undo_list,ds_list_size(undo_list)-1);
		
		if (!is_struct(undo))
		{
			show_debug_message("UNDO BUG ILD, NOT A STRUCT: " + string(undo));
			return;
		}
		
		add_action_history_ilda("ILDA_undo_"+string(undo.undo_id));

		if (undo.undo_id == "" && is_real(undo.data)) //undo create
		{
			temp_redof_list = ds_list_create_pool();
			
		    for (j = 0;j < ds_list_size(frame_list);j++)
		    {
		        el_list = ds_list_find_value(frame_list,j);
		        for (i = 0;i < ds_list_size(el_list);i++)
		        {
		            if (ds_list_find_value(ds_list_find_value(el_list,i),9) == undo.data)
		            {
		                list_id = ds_list_find_value(el_list,i);
						temp_redo_list = ds_list_create_pool();
					    ds_list_copy(temp_redo_list,list_id);
					    ds_list_add(temp_redo_list,j);
					    ds_list_add(temp_redof_list,temp_redo_list);
		                ds_list_free_pool(list_id); list_id = -1;
		                ds_list_delete(el_list,i);
		            }
		        }
		    }
			
			ds_list_add(redo_list, make_undo("l", temp_redof_list));
		}
		else if (string_char_at(undo.undo_id,0) == "a")
		{
			ds_list_add(redo_list, make_undo("a", maxframes));
			
		    maxframes = undo.data;
		    if (frame >= maxframes) 
			{
				frame = maxframes-1;
				framehr = maxframes-1;
			}
			if (scope_end > maxframes)
				scope_end = maxframes-1;
		}
		else if (string_char_at(undo.undo_id,0) == "r")
		{
			ds_list_add(redo_list,make_undo("r", string(resolution)));
			
		    if (string_digits(undo.data) != "")
		        resolution = clamp(real(string_digits(undo.data)),4,$ffff);
		    else
		        resolution = "auto";
		}
		else if (string_char_at(undo.undo_id,0) == "d")
		{
			ds_list_add(redo_list,make_undo("d", dotmultiply));
			
		    dotmultiply = undo.data;
		}
		else if (string_char_at(undo.undo_id,0) == "v")
		{
		    if (!ds_list_exists_pool(undo.data))
		        exit;
				
			tempredolist = ds_list_create_pool();
		    ds_list_add(tempredolist, anienddotscolor);
		    ds_list_add(tempredolist, anicolor2);
		    ds_list_add(tempredolist, anicolor1);
		    ds_list_add(redo_list, make_undo("v", tempredolist));
			
		    tempundolist = undo.data;
		    anicolor1 = ds_list_find_value(tempundolist,2);
		    anicolor2 = ds_list_find_value(tempundolist,1);
		    anienddotscolor = ds_list_find_value(tempundolist,0);
		    ds_list_free_pool(tempundolist);  tempundolist = -1;
		    update_anicolors();
		}
		else if (string_char_at(undo.undo_id,0) == "b")
		{
		    if (!ds_list_exists_pool(undo.data))
		        exit;
				
			tempredolist = ds_list_create_pool();
			ds_list_add(tempredolist,enddotscolor);
			ds_list_add(tempredolist,color2);
			ds_list_add(tempredolist,color1);
			ds_list_add(redo_list, make_undo("b", tempredolist));
				
		    tempundolist = undo.data;
		    color1 = ds_list_find_value(tempundolist,2);
		    color2 = ds_list_find_value(tempundolist,1);
		    enddotscolor = ds_list_find_value(tempundolist,0);
		    ds_list_free_pool(tempundolist);
		    update_colors();
		}
		else if (string_char_at(undo.undo_id,0) == "k")
		{
		    //undo reapply elements
		    if (!ds_list_exists_pool(undo.data))
		        exit;
				
			temp_redof_list = ds_list_create_pool();
				
		    tempundolist = undo.data;
		    for (u = 0;u < ds_list_size(tempundolist);u++)
		    {
		        list = ds_list_find_value(tempundolist,u);
		        if (ds_list_exists_pool(list))
		        {
		            tempid = ds_list_find_value(list,9);
		            var t_frame = ds_list_find_value(list,ds_list_size(list)-1);
		            ds_list_delete(list,ds_list_size(list)-1);
		            var t_el_list = ds_list_find_value(frame_list,round(t_frame));
		            if (ds_list_exists_pool(t_el_list))
		            {
		                for (i = 0;i < ds_list_size(t_el_list);i++)
		                {
		                    if (ds_list_find_value(ds_list_find_value(t_el_list,i),9) == tempid)
		                    {
		                        oldlist = ds_list_find_value(t_el_list,i);
								
		                        ds_list_add(oldlist,t_frame);
		                        ds_list_add(temp_redof_list,oldlist);
								
		                        ds_list_replace(t_el_list,i,list);
		                    }
		                }
		            }
		        }
		    }
		    ds_list_free_pool(tempundolist); tempundolist = -1;
			
			ds_list_add(redo_list, make_undo("k", temp_redof_list));
		}
		else if (string_char_at(undo.undo_id,0) == "l")
		{
		    if (!ds_list_exists_pool(undo.data))
		        exit;
		    //undo delete
			var tempelid = -1;
		    tempundolist = undo.data;
		    for (u = 0;u < ds_list_size(tempundolist);u++)
		    {
		        list = ds_list_find_value(tempundolist,u);
		        if (ds_list_exists_pool(list))
		        {
		            tempid = ds_list_find_value(list,9);
		            var t_frame = ds_list_find_value(list,ds_list_size(list)-1);
		            ds_list_delete(list,ds_list_size(list)-1);
		            var t_el_list = ds_list_find_value(frame_list,t_frame);
					if (!ds_list_exists_pool(t_el_list))
						continue;
		            ds_list_add(t_el_list,list);
					
					if (list[| 9] != tempelid)
					{
						ds_list_add(redo_list, make_undo("", list[| 9]));
						tempelid = list[| 9];
					}
		        }
		    }
		    ds_list_free_pool(tempundolist); tempundolist = -1;
		}
		else if (string_char_at(undo.undo_id,0) == "s")
		{
		    //undo stretch maxframes
			exit; // TODO
			
		    /*var t_framelistbuffer = undo.data;	
			if (!buffer_exists(t_framelistbuffer))
				exit;
				
			var t_redo_buffer = buffer_create(2, buffer_grow, 1);
			buffer_write(t_redo_buffer, buffer_string, string(frame_list));
			var t_compressed_buffer = buffer_compress(t_redo_buffer, 0, buffer_tell(t_redo_buffer));
		    ds_list_add(redo_list, make_undo("s", t_compressed_buffer));
			buffer_delete(t_redo_buffer);
			
			for (j = 0;j < ds_list_size(frame_list);j++)
			{
			    el_list = ds_list_find_value(frame_list,j);
			    for (i = 0;i < ds_list_size(el_list);i++)
			    {
			        list_id = ds_list_find_value(el_list,i);
			        ds_list_free_pool(list_id);
			    }
			    ds_list_free_pool(el_list);
			}
			ds_list_free_pool(frame_list);
				
			var t_decompressed_buffer = buffer_decompress(t_compressed_buffer);
			frame_list = ds_list_
			*/
	
			refresh_minitimeline_flag = 1;
		}
		else if (string_char_at(undo.undo_id,0) == "e")
		{
		    //undo reverse
			ilda_reverse(true);
			ds_list_add(redo_list, make_undo("e", 0));
		}
		else if (string_char_at(undo.undo_id,0) == "c")
		{
		    //undo set scope
			if (!ds_list_exists_pool(undo.data))
		        exit;
		    tempundolist = undo.data;
			
			var t_redolist = ds_list_create_pool();
			ds_list_add(t_redolist, scope_start);
			ds_list_add(t_redolist, scope_end);
			ds_list_add(redo_list, make_undo("c", t_redolist));
			
			scope_start = clamp(tempundolist[| 0], 0, maxframes-1);
			scope_end = clamp(tempundolist[| 1], scope_start, maxframes-1);
			refresh_minitimeline_flag = 1;
		}
    
    
		frame_surf_refresh = 1;
		update_semasterlist_flag = 1;
	}


}
