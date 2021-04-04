function dd_seq_env_deletesection() {
	
	with (seqcontrol)
	{
		time_list = ds_list_find_value(envelopetoedit,1);
		data_list = ds_list_find_value(envelopetoedit,2);
		
		var t_undolist = ds_list_create();
		var t_list1 = ds_list_create();
		var t_list2 = ds_list_create();
		ds_list_copy(t_list1,time_list);
		ds_list_copy(t_list2,data_list);
		ds_list_add(t_undolist,t_list1);
		ds_list_add(t_undolist,t_list2);
		ds_list_add(t_undolist,envelopetoedit);
		
		var t_xpos = envelopexpos;
		if (xposprev < t_xpos)
		    for (u = 0; u < ds_list_size(time_list); u++)
		    {
		        var t_xpos_loop = ds_list_find_value(time_list,u);
		        if (t_xpos_loop == clamp(t_xpos_loop, xposprev+1, t_xpos-1))
		        {
		            ds_list_delete(data_list,u);
		            ds_list_delete(time_list,u);
		            u--;
		        }
		    }
		else
		    for (u = 0; u < ds_list_size(time_list); u++)
		    {
		        var t_xpos_loop = ds_list_find_value(time_list,u);
		        if (t_xpos_loop == clamp(t_xpos_loop, t_xpos+1, xposprev-1))
		        {
		            ds_list_delete(data_list,u);
		            ds_list_delete(time_list,u);
		            u--;
		        }
		    }
		moving_object = 0;
		timeline_surf_length = 0;
		
		ds_list_add(seqcontrol.undo_list,"e"+string(t_undolist));
	}
}
