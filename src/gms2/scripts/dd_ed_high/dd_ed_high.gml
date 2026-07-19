function dd_ed_high() {
	ds_list_add(controller.undo_list,make_undo("d", controller.dotmultiply));

	controller.dotmultiply = 30;



}
