function live_delete_object_noundo() {
	with (livecontrol)
	{
		objectlist = filelist[| selectedfile];
	
		infolist = objectlist[| 2];
        
	    if (surface_exists(infolist[| 1]))
	        surface_free(infolist[| 1]);
            
	    if (buffer_exists(objectlist[| 1]))
	        buffer_delete(objectlist[| 1]);
                
		var t_dac_list = objectlist[| 9];
		num_objects = ds_list_size(t_dac_list);
		repeat (num_objects)  
			ds_list_destroy(ds_list_find_value(t_dac_list,0));
		ds_list_destroy(t_dac_list);
				
	    ds_list_find_value(objectlist,0);
	    ds_list_destroy(infolist); infolist = -1;
	    ds_list_destroy(objectlist); objectlist = -1;
	
		ds_list_delete(filelist, selectedfile);
	
		selectedfile = -1;
		if (surface_exists(browser_surf))
			surface_free(browser_surf);
		browser_surf = -1;
		playing = 0;
		frame_surf_refresh = 1;
	}


}
