function dd_ilda_resetwindow() {
	window_set_fullscreen(0);
	window_set_size(controller.default_window_w,controller.default_window_h);
	controller.forceresize = true;


}
