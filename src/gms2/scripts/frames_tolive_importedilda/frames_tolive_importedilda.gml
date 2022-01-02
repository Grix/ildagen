function frames_tolive_importedilda() {
	//converts newly imported ilda in ild_list to live grid object

	save_buffer = buffer_create(1,buffer_grow,1);
	buffer_seek(save_buffer,buffer_seek_start,0);

	buffer_write(save_buffer,buffer_u8,52);
	buffer_write(save_buffer,buffer_u32,ds_list_size(ild_list));

	var t_checkpointlist = ds_list_create();

	for (j = 0; j < ds_list_size(ild_list);j++)
	{
		if (j % 100 == 0 && j != 0)
			ds_list_add(t_checkpointlist, buffer_tell(save_buffer));
	
	    buffer_write(save_buffer,buffer_u32,1);

	    ind_list = ds_list_find_value(ild_list,j);
	    tempsize = ds_list_size(ind_list);
	    buffer_write(save_buffer,buffer_u32,tempsize);
    
	    for (u = 0; u < 10; u++)
	    {
	        buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u));
	    }
	    for (u = 10; u < 20; u++)
	    {
	        buffer_write(save_buffer,buffer_bool,ds_list_find_value(ind_list,u));
	    }
	    for (u = 20; u < tempsize; u += 4)
	    {
	        buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u));
	        buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u+1));
	        buffer_write(save_buffer,buffer_bool,ds_list_find_value(ind_list,u+2));
	        buffer_write(save_buffer,buffer_u32,ds_list_find_value(ind_list,u+3));
	    }
	    ds_list_destroy(ind_list); ild_list[| j] = -1;
	}
	//remove excess size
	buffer_resize(save_buffer,buffer_tell(save_buffer));

	//send to live
	with (livecontrol)
	{
		objectlist = ds_list_create();
	    ds_list_add(objectlist,false);
	    ds_list_add(objectlist,controller.save_buffer);
		info = ds_list_create();
	    ds_list_add(info,0);
	    ds_list_add(info,-1);
	    ds_list_add(info,ds_list_size(controller.ild_list));
		ds_list_add(info, t_checkpointlist);
	    ds_list_add(objectlist,info);
		ds_list_add(objectlist,find_next_available_shortcut());
		ds_list_add(objectlist,(ds_list_size(controller.ild_list) == 1));
		ds_list_add(objectlist,0);
		ds_list_add(objectlist,0);
		ds_list_add(objectlist,0);
	
	    ds_list_add(filelist,objectlist);
		selectedfile = ds_list_size(filelist)-1;
	
		ds_list_add(undo_list, "c"+string(selectedfile));
	
		frame_surf_refresh = 1;
		if (surface_exists(browser_surf))
			surface_free(browser_surf);
		browser_surf = -1;
		frame = 0;
	    playing = 0;
		clean_redo_live();
	}

	ds_list_destroy(ild_list); ild_list = -1;

}
