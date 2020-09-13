function dd_res_low() {
	ds_list_add(controller.undo_list,"r"+string(controller.resolution));

	controller.resolution = controller.opt_maxdist;



}
