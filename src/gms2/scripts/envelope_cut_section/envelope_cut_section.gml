// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function envelope_cut_section(){
	
	with (seqcontrol)
	{
		ds_list_clear(envelope_copy_list_data);
		ds_list_clear(envelope_copy_list_time);
		
		if (xposprev == envelopexpos || !ds_list_exists(envelopetoedit))
			return;
		
		time_list = ds_list_find_value(envelopetoedit,1);
		data_list = ds_list_find_value(envelopetoedit,2);
		
		var t_undolist = ds_list_create_pool();
		var t_list1 = ds_list_create_pool();
		var t_list2 = ds_list_create_pool();
		ds_list_copy(t_list1,time_list);
		ds_list_copy(t_list2,data_list);
		ds_list_add(t_undolist,t_list1);
		ds_list_add(t_undolist,t_list2);
		ds_list_add(t_undolist,envelopetoedit);
		
		if (xposprev > envelopexpos)
		{
			var t_temp = xposprev;
			xposprev = envelopexpos;
			envelopexpos = t_temp;
		}
			
		// find points in section, and delete it
		for (u = 0; u < ds_list_size(time_list); u++)
		{
			var t_xpos_loop = ds_list_find_value(time_list,u);
			if (t_xpos_loop == clamp(t_xpos_loop, xposprev+1, envelopexpos-1))
			{
				ds_list_add(envelope_copy_list_time, time_list[| u] - xposprev);
				ds_list_add(envelope_copy_list_data, data_list[| u]);
				ds_list_delete(time_list,u);
				ds_list_delete(data_list,u);
				u--;
			}
		}
		
		moving_object = 0;
		timeline_surf_length = 0;
		
		clean_redo_list_seq();
		ds_list_add(seqcontrol.undo_list,"e"+string(t_undolist));
	}
}