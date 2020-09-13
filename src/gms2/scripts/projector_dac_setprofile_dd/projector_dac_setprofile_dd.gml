function projector_dac_setprofile_dd() {
	var t_thisdaclist = ds_list_find_value(ds_list_find_value(seqcontrol.layer_list[| settingscontrol.projectortoselect], 5), settingscontrol.dactoselect);
	var t_dacindex = t_thisdaclist[| 0];
	ds_list_replace(controller.dac_list[| t_dacindex], 2, argument[0]-1);
	t_thisdaclist[| 2] = ds_map_find_value(controller.profile_list[| (argument[0]-1)], "name");

	projectorlist_update();



}
