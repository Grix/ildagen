function redo_ilda() {
	with (controller)
	{
		if (ds_list_empty(redo_list))
		    exit;

		ilda_cancel();
		ds_list_clear(semaster_list);
    
		redo = ds_list_find_value(redo_list,ds_list_size(redo_list)-1);
		ds_list_delete(redo_list,ds_list_size(redo_list)-1);

		if (is_real(redo)) //redo create
		{
			temp_undof_list = ds_list_create();
			
		    for (j = 0;j < ds_list_size(frame_list);j++)
		    {
		        el_list = ds_list_find_value(frame_list,j);
		        for (i = 0;i < ds_list_size(el_list);i++)
		        {
		            if (ds_list_find_value(ds_list_find_value(el_list,i),9) == redo)
		            {
		                list_id = ds_list_find_value(el_list,i);
						temp_undo_list = ds_list_create();
					    ds_list_copy(temp_undo_list,list_id);
					    ds_list_add(temp_undo_list,j);
					    ds_list_add(temp_undof_list,temp_undo_list);
		                ds_list_destroy(list_id);
		                ds_list_delete(el_list,i);
		            }
		        }
		    }
			
			ds_list_add(undo_list,"l"+string(temp_undof_list));
		}
		else if (string_char_at(redo,0) == "a")
		{
			ds_list_add(undo_list,"a"+string(maxframes))
			
		    maxframes = real(string_digits(redo));
		    if (frame >= maxframes) 
			{
				frame = maxframes-1;
				framehr = maxframes-1;
			}
			if (scope_end > maxframes)
				scope_end = maxframes-1;
		}
		else if (string_char_at(redo,0) == "r")
		{
			ds_list_add(undo_list,"r"+string(resolution))
			
		    if (string_digits(redo) == "rauto")
		        resolution = clamp(real(string_digits(redo)),4,$ffff);
		    else
		        resolution = "auto";
		}
		else if (string_char_at(redo,0) == "d")
		{
			ds_list_add(undo_list,"d"+string(dotmultiply))
			
		    dotmultiply = real(string_digits(redo));
		}
		else if (string_char_at(redo,0) == "v")
		{
		    if (!ds_list_exists(real(string_digits(redo))))
		        exit;
				
			tempundolist = ds_list_create();
		    ds_list_add(tempundolist, anienddotscolor);
		    ds_list_add(tempundolist, anicolor2);
		    ds_list_add(tempundolist, anicolor1);
		    ds_list_add(undo_list, "v"+string(tempundolist));
			
		    tempredolist = real(string_digits(redo));
		    anicolor1 = ds_list_find_value(tempredolist,2);
		    anicolor2 = ds_list_find_value(tempredolist,1);
		    anienddotscolor = ds_list_find_value(tempredolist,0);
		    ds_list_destroy(tempredolist);
		    update_anicolors();
		}
		else if (string_char_at(redo,0) == "b")
		{
		    if (!ds_list_exists(real(string_digits(redo))))
		        exit;
				
			tempundolist = ds_list_create();
			ds_list_add(tempundolist,enddotscolor);
			ds_list_add(tempundolist,color2);
			ds_list_add(tempundolist,color1);
			ds_list_add(undo_list,"b"+string(tempundolist));
				
		    tempredolist = real(string_digits(redo));
		    color1 = ds_list_find_value(tempredolist,2);
		    color2 = ds_list_find_value(tempredolist,1);
		    enddotscolor = ds_list_find_value(tempredolist,0);
		    ds_list_destroy(tempredolist);
		    update_colors();
		}
		else if (string_char_at(redo,0) == "k")
		{
		    //redo reapply elements
		    if (!ds_list_exists(real(string_digits(redo))))
		        exit;
				
			temp_undof_list = ds_list_create();
				
		    tempredolist = real(string_digits(redo));
		    for (u = 0;u < ds_list_size(tempredolist);u++)
		    {
		        list = ds_list_find_value(tempredolist,u);
		        if (ds_list_exists(list))
		        {
		            tempid = ds_list_find_value(list,9);
		            var t_frame = ds_list_find_value(list,ds_list_size(list)-1);
		            ds_list_delete(list,ds_list_size(list)-1);
		            var t_el_list = ds_list_find_value(frame_list,round(t_frame));
		            if (ds_list_exists(t_el_list))
		            {
		                for (i = 0;i < ds_list_size(t_el_list);i++)
		                {
		                    if (ds_list_find_value(ds_list_find_value(t_el_list,i),9) == tempid)
		                    {
		                        oldlist = ds_list_find_value(t_el_list,i);
								
		                        ds_list_add(oldlist,t_frame);
		                        ds_list_add(temp_undof_list,oldlist);
								
		                        ds_list_replace(t_el_list,i,list);
		                    }
		                }
		            }
		        }
		    }
		    ds_list_destroy(tempredolist);
			
			ds_list_add(undo_list,"k"+string(temp_undof_list));
		}
		else if (string_char_at(redo,0) == "l")
		{
		    if (!ds_list_exists(real(string_digits(redo))))
		        exit;
		    //redo delete
			var tempelid = -1;
		    tempredolist = real(string_digits(redo));
		    for (u = 0;u < ds_list_size(tempredolist);u++)
		    {
		        list = ds_list_find_value(tempredolist,u);
		        if (ds_list_exists(list))
		        {
		            tempid = ds_list_find_value(list,9);
		            var t_frame = ds_list_find_value(list,ds_list_size(list)-1);
		            ds_list_delete(list,ds_list_size(list)-1);
		            var t_el_list = ds_list_find_value(frame_list,t_frame);
		            ds_list_add(t_el_list,list);
					
					if (list[| 9] != tempelid)
					{
						ds_list_add(undo_list, list[| 9]);
						tempelid = list[| 9];
					}
		        }
		    }
		    ds_list_destroy(tempredolist);
		}
		else if (string_char_at(redo,0) == "s")
		{
		    //redo stretch maxframes
			exit; // TODO
			
		    /*var t_framelistbuffer = real(string_digits(redo));	
			if (!buffer_exists(t_framelistbuffer))
				exit;
				
			var t_undo_buffer = buffer_create(2, buffer_grow, 1);
			buffer_write(t_undo_buffer, buffer_string, string(frame_list));
			var t_compressed_buffer = buffer_compress(t_undo_buffer, 0, buffer_tell(t_undo_buffer));
		    ds_list_add(undo_list,"s"+string(t_compressed_buffer));
			buffer_delete(t_undo_buffer);
			
			for (j = 0;j < ds_list_size(frame_list);j++)
			{
			    el_list = ds_list_find_value(frame_list,j);
			    for (i = 0;i < ds_list_size(el_list);i++)
			    {
			        list_id = ds_list_find_value(el_list,i);
			        ds_list_destroy(list_id);
			    }
			    ds_list_destroy(el_list);
			}
			ds_list_destroy(frame_list);
				
			var t_decompressed_buffer = buffer_decompress(t_compressed_buffer);
			frame_list = ds_list_*/
	
			refresh_minitimeline_flag = 1;
		}
    
    
		frame_surf_refresh = 1;
		update_semasterlist_flag = 1;
	}


}
