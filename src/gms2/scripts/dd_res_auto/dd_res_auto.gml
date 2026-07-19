function dd_res_auto() {
	ds_list_add(controller.undo_list,make_undo("r", string(controller.resolution)));

	controller.resolution = "auto";



}
