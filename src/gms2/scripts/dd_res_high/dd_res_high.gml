function dd_res_high() {
	ds_list_add(controller.undo_list,make_undo("r", string(controller.resolution)));

	controller.resolution = 250;



}
