function paste_object() {
	if (copy_list == -1)
	    exit;
    
	ds_list_clear(semaster_list);

	var tempelid = -1;

	for (u = 0;u < ds_list_size(copy_list);u++)
	{
	    list = ds_list_create_pool();
	    ds_list_copy(list,ds_list_find_value(copy_list,u));
	    if (u == 0)
	        firstframe = ds_list_find_value(list,ds_list_size(list)-1);
	    framei = frame+ds_list_find_value(list,ds_list_size(list)-1)-firstframe;
	    if (framei > maxframes-1)
	    {
	        ds_list_free_pool(list); list = -1;
	        continue;
	    }
    
	    ds_list_replace(list,0,ds_list_find_value(list,0)+$FFFF/controller.sgridnum);
	    ds_list_replace(list,1,ds_list_find_value(list,1)+$FFFF/controller.sgridnum);
	    ds_list_replace(list,2,ds_list_find_value(list,2)+$FFFF/controller.sgridnum);
	    ds_list_replace(list,3,ds_list_find_value(list,3)+$FFFF/controller.sgridnum);
	    ds_list_delete(list,ds_list_size(list)-1);
    
	    if (tempelid != ds_list_find_value(list,9))
	    {
	        el_id++;
	        ds_list_add(semaster_list,el_id);
	        tempelid = ds_list_find_value(list,9);
	        ds_list_add(undo_list,el_id);
	    }
	    ds_list_replace(list,9,el_id);
	    el_list = ds_list_find_value(frame_list,framei);
	    ds_list_add(el_list,list);
	}

	el_id++;
	update_semasterlist_flag = 1;
	clean_redo_list();
	frame_surf_refresh = 1;



}
