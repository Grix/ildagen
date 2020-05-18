with (controller)
{
	if (ds_list_empty(undo_list))
	    exit;

	ilda_cancel();
	ds_list_clear(semaster_list);
    
	undo = ds_list_find_value(undo_list,ds_list_size(undo_list)-1);
	ds_list_delete(undo_list,ds_list_size(undo_list)-1);

	if (is_real(undo)) //undo create
	{
	    for (j = 0;j < ds_list_size(frame_list);j++)
	    {
	        el_list = ds_list_find_value(frame_list,j);
	        for (i = 0;i < ds_list_size(el_list);i++)
	        {
	            if (ds_list_find_value(ds_list_find_value(el_list,i),9) == undo)
	            {
	                list_id = ds_list_find_value(el_list,i);
	                ds_list_destroy(list_id);
	                ds_list_delete(el_list,i);
	            }
	        }
	    }
	}
	else if (string_char_at(undo,0) == "a")
	{
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
	    if (string_digits(undo) == "rauto")
	        resolution = clamp(real(string_digits(undo)),4,$ffff);
	    else
	        resolution = "auto";
	}
	else if (string_char_at(undo,0) == "d")
	{
	    dotmultiply = real(string_digits(undo));
	}
	else if (string_char_at(undo,0) == "v")
	{
	    if (!ds_exists(real(string_digits(undo)),ds_type_list))
	        exit;
	    tempundolist = real(string_digits(undo));
	    anicolor1 = ds_list_find_value(tempundolist,2);
	    anicolor2 = ds_list_find_value(tempundolist,1);
	    anienddotscolor = ds_list_find_value(tempundolist,0);
	    ds_list_destroy(tempundolist);
	    update_anicolors();
	}
	else if (string_char_at(undo,0) == "b")
	{
	    if (!ds_exists(real(string_digits(undo)),ds_type_list))
	        exit;
	    tempundolist = real(string_digits(undo));
	    color1 = ds_list_find_value(tempundolist,2);
	    color2 = ds_list_find_value(tempundolist,1);
	    enddotscolor = ds_list_find_value(tempundolist,0);
	    ds_list_destroy(tempundolist);
	    update_colors();
	}
	else if (string_char_at(undo,0) == "k")
	{
	    //undo reapply elements
	    if (!ds_exists(real(string_digits(undo)),ds_type_list))
	        exit;
	    tempundolist = real(string_digits(undo));
	    for (u = 0;u < ds_list_size(tempundolist);u++)
	    {
	        list = ds_list_find_value(tempundolist,u);
	        if (ds_exists(list,ds_type_list))
	        {
	            tempid = ds_list_find_value(list,9);
	            frame = ds_list_find_value(list,ds_list_size(list)-1);
	            ds_list_delete(list,ds_list_size(list)-1);
	            el_list = ds_list_find_value(frame_list,round(frame));
	            if (ds_exists(el_list,ds_type_list))
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
	    ds_list_destroy(tempundolist);
	}
	else if (string_char_at(undo,0) == "l")
	{
	    if (!ds_exists(real(string_digits(undo)),ds_type_list))
	        exit;
	    //undo delete
	    tempundolist = real(string_digits(undo));
	    for (u = 0;u < ds_list_size(tempundolist);u++)
	    {
	        list = ds_list_find_value(tempundolist,u);
	        if (ds_exists(list,ds_type_list))
	        {
	            tempid = ds_list_find_value(list,9);
	            frame = ds_list_find_value(list,ds_list_size(list)-1);
	            ds_list_delete(list,ds_list_size(list)-1);
	            el_list = ds_list_find_value(frame_list,frame);
	            ds_list_add(el_list,list);
	        }
	    }
	    ds_list_destroy(tempundolist);
	}
	else if (string_char_at(undo,0) == "s")
	{
		if (!ds_exists(real(string_digits(undo)),ds_type_list))
	        exit;
	    //undo stretch maxframes
	    tempundolist = real(string_digits(undo));	
	
		for (u = 0; u < ds_list_size(frame_list); u++)
		{
			ds_list_destroy(frame_list[| u]);
		}
		ds_list_destroy(frame_list);
	
		frame_list = tempundolist;
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