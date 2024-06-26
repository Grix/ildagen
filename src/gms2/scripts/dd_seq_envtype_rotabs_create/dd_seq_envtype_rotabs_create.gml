function dd_seq_envtype_rotabs_create() {
	envelope = ds_list_create_pool();
	ds_list_add(ds_list_find_value(layertoedit,0),envelope);
	ds_list_add(envelope,"rotabs");
	ds_list_add(envelope,ds_list_create_pool());
	ds_list_add(envelope,ds_list_create_pool());
	ds_list_add(envelope,0);
	ds_list_add(envelope,0);
	seqcontrol.timeline_surf_length = 0;
	clean_redo_list_seq();

	ds_list_add(seqcontrol.undo_list, "p"+string(envelope));
	add_action_history_ilda("SEQ_create_envelope");
}
