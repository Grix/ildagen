function dd_seq_env_clear() {
	var t_undolist = ds_list_create_pool();
	var t_list1 = ds_list_create_pool();
	var t_list2 = ds_list_create_pool();
	ds_list_copy(t_list1,ds_list_find_value(seqcontrol.selectedenvelope,1));
	ds_list_copy(t_list2,ds_list_find_value(seqcontrol.selectedenvelope,2));
	ds_list_add(t_undolist,t_list1);
	ds_list_add(t_undolist,t_list2);
	ds_list_add(t_undolist,seqcontrol.selectedenvelope);
	ds_list_add(seqcontrol.undo_list,"e"+string(t_undolist));
	ds_list_clear(ds_list_find_value(seqcontrol.selectedenvelope,1));
	ds_list_clear(ds_list_find_value(seqcontrol.selectedenvelope,2));
	seqcontrol.timeline_surf_length = 0;
	clean_redo_list_seq();
	
	add_action_history_ilda("SEQ_clearenvelope");


}
