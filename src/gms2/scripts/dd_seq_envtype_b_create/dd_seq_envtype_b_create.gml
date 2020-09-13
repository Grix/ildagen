function dd_seq_envtype_b_create() {
	envelope = ds_list_create();
	ds_list_add(ds_list_find_value(layertoedit,0),envelope);
	ds_list_add(envelope,"b");
	ds_list_add(envelope,ds_list_create());
	ds_list_add(envelope,ds_list_create());
	ds_list_add(envelope,0);
	ds_list_add(envelope,0);
	seqcontrol.timeline_surf_length = 0;


}
