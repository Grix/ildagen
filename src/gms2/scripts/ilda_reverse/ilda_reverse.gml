function ilda_reverse() {
	//reverse animation of scope
	with (controller)
	{
		var t_tempframelist = ds_list_create();
		for (j = scope_start; j <= scope_end; j++)
	    {
	        ds_list_add(t_tempframelist, frame_list[| j]);
		}
		var t_i = 0;
		for (j = scope_end; j >= scope_start; j--)
	    {
			frame_list[| j] = t_tempframelist[| t_i];
			t_i++;
		}
		ds_list_destroy(t_tempframelist); //todo undo
		frame_surf_refresh = 1;
		update_semasterlist_flag = 1;
		clean_redo_list();
	}



}
