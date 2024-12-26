// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function envelope_paste_all(){

	with (seqcontrol)
	{
		if (!ds_list_exists(envelopetoedit) || envelope_copy_duration != infinity)
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
			
		// add data (first deleting existing data there)
		ds_list_clear(data_list);
		ds_list_clear(time_list);
		ds_list_copy(time_list, envelope_copy_list_time);
		ds_list_copy(data_list, envelope_copy_list_data);
		
		moving_object = 0;
		timeline_surf_length = 0;
		
		clean_redo_list_seq();
		ds_list_add(seqcontrol.undo_list,"e"+string(t_undolist));
	}

}