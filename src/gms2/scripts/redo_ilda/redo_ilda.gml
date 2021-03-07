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
		    if (string_digits(redo) == "rauto")
		        resolution = clamp(real(string_digits(redo)),4,$ffff);
		    else
		        resolution = "auto";
		}
		else if (string_char_at(redo,0) == "d")
		{
		    dotmultiply = real(string_digits(redo));
		}
		else if (string_char_at(redo,0) == "v")
		{
		    if (!ds_list_exists(real(string_digits(redo))))
		        exit;
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
		    tempredolist = real(string_digits(redo));
		    for (u = 0;u < ds_list_size(tempredolist);u++)
		    {
		        list = ds_list_find_value(tempredolist,u);
		        if (ds_list_exists(list))
		        {
		            tempid = ds_list_find_value(list,9);
		            frame = ds_list_find_value(list,ds_list_size(list)-1);
		            ds_list_delete(list,ds_list_size(list)-1);
		            el_list = ds_list_find_value(frame_list,round(frame));
		            if (ds_list_exists(el_list))
		            {
		                for (i = 0;i < ds_list_size(el_list);i++)
		                {
		                    if (ds_list_find_value(ds_list_find_value(el_list,i),9) == tempid)
		                    {
		                        oldlist = ds_list_find_value(el_list,i);
		                        ds_list_destroy(oldlist);
		                        ds_list_replace(el_list,i,list);
		                    }
		                }
		            }
		        }
		    }
		    ds_list_destroy(tempredolist);
		}
		else if (string_char_at(redo,0) == "l")
		{
		    if (!ds_list_exists(real(string_digits(redo))))
		        exit;
		    //redo delete
		    tempredolist = real(string_digits(redo));
		    for (u = 0;u < ds_list_size(tempredolist);u++)
		    {
		        list = ds_list_find_value(tempredolist,u);
		        if (ds_list_exists(list))
		        {
		            tempid = ds_list_find_value(list,9);
		            frame = ds_list_find_value(list,ds_list_size(list)-1);
		            ds_list_delete(list,ds_list_size(list)-1);
		            el_list = ds_list_find_value(frame_list,frame);
		            ds_list_add(el_list,list);
		        }
		    }
		    ds_list_destroy(tempredolist);
		}
		else if (string_char_at(redo,0) == "s")
		{
			if (!ds_list_exists(real(string_digits(redo))))
		        exit;
		    //redo stretch maxframes
		    tempredolist = real(string_digits(redo));	
	
			for (u = 0; u < ds_list_size(frame_list); u++)
			{
				ds_list_destroy(frame_list[| u]);
			}
			ds_list_destroy(frame_list);
	
			frame_list = tempredolist;
			el_list = ds_list_create();
			maxframes = ds_list_size(frame_list);
			dd_scope_reset();
			if (frame > maxframes-1)
			{
				frame = maxframes-1;
				framehr = maxframes-1;
			}
	
			refresh_minitimeline_flag = 1;
		}
    
    
		frame_surf_refresh = 1;
		update_semasterlist_flag = 1;
	}


}
