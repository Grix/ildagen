function projector_remove_dac() {
	var t_thisdaclist = ds_list_find_value(seqcontrol.layer_list[| settingscontrol.projectortoselect], 5);
	ds_list_delete(t_thisdaclist, settingscontrol.dactoselect);

	projectorlist_update();



}
