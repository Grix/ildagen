function dd_live_loadproject() {
	with (livecontrol)
		load_live_project(get_open_filename_ext("LSG Live Grid|*.igl","","","Select LaserShowGen Live grid file"));
	keyboard_clear(keyboard_lastkey);
	keyboard_clear(vk_control);
	mouse_clear(mouse_lastbutton);


}
