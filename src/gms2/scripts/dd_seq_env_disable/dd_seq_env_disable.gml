function dd_seq_env_disable() {
	ds_list_replace(seqcontrol.selectedenvelope,3,!ds_list_find_value(seqcontrol.selectedenvelope,3));
	seqcontrol.timeline_surf_length = 0;


}
