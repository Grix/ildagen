// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function clean_element_references(t_elementid){
	
	// Go through undo, redo lists and remove dangling references to element (used f.ex if that element is permanently removed)
	
	for (var t_i = 0; t_i < ds_list_size(undo_list); t_i++)
	{
		undo = ds_list_find_value(undo_list,t_i);
		
		if (is_real(undo)) //undo create
		{
			temp_redof_list = ds_list_create_pool();
			
		    for (j = 0;j < ds_list_size(frame_list);j++)
		    {
		        el_list = ds_list_find_value(frame_list,j);
		        for (i = 0;i < ds_list_size(el_list);i++)
		        {
		            if (ds_list_find_value(ds_list_find_value(el_list,i),9) == undo)
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
			
			ds_list_add(redo_list,"l"+string(temp_redof_list));
		}
		else if (string_char_at(undo,0) == "a")
		{
			ds_list_add(redo_list,"a"+string(maxframes))
			
		    maxframes = real(string_digits(undo));
		    if (frame >= maxframes) 
			{
				frame = maxframes-1;
				framehr = maxframes-1;
			}
			if (scope_end > maxframes)
				scope_end = maxframes-1;
		}
		else if (string_char_at(undo,0) == "r")
		{
			ds_list_add(redo_list,"r"+string(resolution))
			
		    if (string_digits(undo) == "rauto")
		        resolution = clamp(real(string_digits(undo)),4,$ffff);
		    else
		        resolution = "auto";
		}
		else if (string_char_at(undo,0) == "d")
		{
			ds_list_add(redo_list,"d"+string(dotmultiply))
			
		    dotmultiply = real(string_digits(undo));
		}
		else if (string_char_at(undo,0) == "v")
		{
		    if (!ds_list_exists_pool(real(string_digits(undo))))
		        exit;
				
			tempredolist = ds_list_create_pool();
		    ds_list_add(tempredolist, anienddotscolor);
		    ds_list_add(tempredolist, anicolor2);
		    ds_list_add(tempredolist, anicolor1);
		    ds_list_add(redo_list, "v"+string(tempredolist));
			
		    tempundolist = real(string_digits(undo));
		    anicolor1 = ds_list_find_value(tempundolist,2);
		    anicolor2 = ds_list_find_value(tempundolist,1);
		    anienddotscolor = ds_list_find_value(tempundolist,0);
		    ds_list_free_pool(tempundolist);  tempundolist = -1;
		    update_anicolors();
		}
		else if (string_char_at(undo,0) == "b")
		{
		    if (!ds_list_exists_pool(real(string_digits(undo))))
		        exit;
				
			tempredolist = ds_list_create_pool();
			ds_list_add(tempredolist,enddotscolor);
			ds_list_add(tempredolist,color2);
			ds_list_add(tempredolist,color1);
			ds_list_add(redo_list,"b"+string(tempredolist));
				
		    tempundolist = real(string_digits(undo));
		    color1 = ds_list_find_value(tempundolist,2);
		    color2 = ds_list_find_value(tempundolist,1);
		    enddotscolor = ds_list_find_value(tempundolist,0);
		    ds_list_free_pool(tempundolist);
		    update_colors();
		}
		else if (string_char_at(undo,0) == "k")
		{
		    //undo reapply elements
		    if (!ds_list_exists_pool(real(string_digits(undo))))
		        exit;
				
			temp_redof_list = ds_list_create_pool();
				
		    tempundolist = real(string_digits(undo));
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
			
			ds_list_add(redo_list,"k"+string(temp_redof_list));
		}
		else if (string_char_at(undo,0) == "l")
		{
		    if (!ds_list_exists_pool(real(string_digits(undo))))
		        exit;
		    //undo delete
			var tempelid = -1;
		    tempundolist = real(string_digits(undo));
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
						ds_list_add(redo_list, list[| 9]);
						tempelid = list[| 9];
					}
		        }
		    }
		    ds_list_free_pool(tempundolist); tempundolist = -1;
		}
		else if (string_char_at(undo,0) == "s")
		{
		    //undo stretch maxframes
			exit; // TODO
			
		    /*var t_framelistbuffer = real(string_digits(undo));	
			if (!buffer_exists(t_framelistbuffer))
				exit;
				
			var t_redo_buffer = buffer_create(2, buffer_grow, 1);
			buffer_write(t_redo_buffer, buffer_string, string(frame_list));
			var t_compressed_buffer = buffer_compress(t_redo_buffer, 0, buffer_tell(t_redo_buffer));
		    ds_list_add(redo_list,"s"+string(t_compressed_buffer));
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
		else if (string_char_at(undo,0) == "e")
		{
		    //undo reverse
			ilda_reverse(true);
			ds_list_add(redo_list,"e");
		}
		else if (string_char_at(undo,0) == "c")
		{
		    //undo set scope
			if (!ds_list_exists_pool(real(string_digits(undo))))
		        exit;
		    tempundolist = real(string_digits(undo));
			
			var t_redolist = ds_list_create_pool();
			ds_list_add(t_redolist, scope_start);
			ds_list_add(t_redolist, scope_end);
			ds_list_add(redo_list,"c"+string(t_redolist));
			
			scope_start = clamp(tempundolist[| 0], 0, maxframes-1);
			scope_end = clamp(tempundolist[| 1], scope_start, maxframes-1);
			refresh_minitimeline_flag = 1;
		}
	}

}