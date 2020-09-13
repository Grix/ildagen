function dd_seq_add_envelope() {
	_layer = selectedlayer_list;
	envelope = ds_list_create();
	ds_list_add(ds_list_find_value(_layer,0),envelope);
	ds_list_add(envelope,"x");
	ds_list_add(envelope,ds_list_create());
	ds_list_add(envelope,ds_list_create());



}
