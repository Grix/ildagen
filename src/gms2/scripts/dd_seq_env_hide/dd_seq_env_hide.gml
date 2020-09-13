function dd_seq_env_hide() {
	ds_list_replace(seqcontrol.selectedenvelope,4,!ds_list_find_value(seqcontrol.selectedenvelope,4));
	seqcontrol.timeline_surf_length = 0;


}
