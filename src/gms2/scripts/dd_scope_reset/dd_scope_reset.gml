function dd_scope_reset(shouldUndo) {
	
	if (argument_count == 0 || shouldUndo)
	{
		var t_undolist = ds_list_create_pool();
		ds_list_add(t_undolist, scope_start);
		ds_list_add(t_undolist, scope_end);
		ds_list_add(undo_list,"c"+string(t_undolist));
		add_action_history_ilda("ILDA_scopereset");
	}
			
	controller.scope_start = 0;
	controller.scope_end = controller.maxframes-1;
	controller.refresh_minitimeline_flag = 1;
}
