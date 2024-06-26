function import_ilda_end() {
	with(controller)
	{
	    log("Ilda import end");
	    buffer_delete(ild_file);
    
	    ildlistsize = ds_list_size(ild_list);
	    framelistsize = ds_list_size(frame_list);
    
	    if ( (ildlistsize) > maxframes)
	        repeat (ildlistsize - maxframes)
	        {
	            maxframes++;
	            templist = ds_list_create_pool();
	            if (fillframes)
	            {
	                tempelcount = ds_list_size(ds_list_find_value(frame_list,framelistsize-1));
	                for (u = 0;u < tempelcount;u++)
	                {
	                    tempellist = ds_list_create_pool();
	                    ds_list_copy(tempellist,ds_list_find_value(ds_list_find_value(frame_list,framelistsize-1),u));
	                    ds_list_add(templist,tempellist);
	                }
	            }
	            ds_list_add(frame_list,templist);
	        }
            
	    if (!fillframes) or (ildlistsize > framelistsize)
	    {
		    for (i = 0;i < ildlistsize;i++)
		    {
		        if (!ds_list_empty(ds_list_find_value(ild_list,i)))
		        {
		            templist = ds_list_create_pool();
		            ds_list_copy(templist,ds_list_find_value(ild_list,i));
		            ds_list_add(ds_list_find_value(frame_list,i),templist);
		        }
		        ds_list_free_pool(ds_list_find_value(ild_list,i)); ild_list[|i] = -1;
		    }
	    }
	    else
	    {
	        for (i = 0;i < ds_list_size(frame_list);i++)
	        {
	            if (!ds_list_empty(ds_list_find_value(ild_list,i%ildlistsize)))
	            {
	                templist = ds_list_create_pool();
	                ds_list_copy(templist,ds_list_find_value(ild_list,i%ildlistsize));
	                ds_list_add(ds_list_find_value(frame_list,i),templist);
	            }
	            /*if (ildlistsize > framelistsize)
	                {
	                ds_list_free_pool(ds_list_find_value(ild_list,i%ildlistsize));
	                }*/
	        }
	        for (i = 0;i < ds_list_size(ild_list);i++)
	        {
	            ds_list_free_pool(ds_list_find_value(ild_list,i)); ild_list[| i] = -1;
	        }
	    }
	    ds_list_add(undo_list,el_id);
	    el_id++;
	    frame_surf_refresh = 1;
	    refresh_minitimeline_flag = 1;
		
		add_action_history_ilda("ILDA_importilda");
    
	    ds_list_free_pool(ild_list); ild_list = -1;
    
	    scope_end = maxframes-1;
	    refresh_minitimeline_flag = 1;
    
	}
    
	global.loading_importilda = 0;
	if (filepath == "")
		filepath = filename + "*";
	room_goto(rm_ilda);

	return 1;



}
