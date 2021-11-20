function clear_all() {
	ilda_cancel();
	clean_redo_list();
	clean_ilda_undo();
	ds_list_clear(semaster_list);

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

	frame_list = ds_list_create();
	el_list = ds_list_create();
	ds_list_add(frame_list,el_list);


	framepoints = 0;
	frame = 0;
	framehr = 0;
	maxframes = 1;
	scope_start = 0;
	scope_end = maxframes-1;
	refresh_minitimeline_flag = 1;
	if (laseron)
	{
	    laseron = false;
	    dac_blank_and_center(dac);
	}


	frame_surf_refresh = 1;



}
