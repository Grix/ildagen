function dd_live_loadproject() {
	with (livecontrol)
		load_live_project(get_open_filename_ext("LSG Grid File|*.igl","","","Select LaserShowGen grid file"));
	keyboard_clear(keyboard_lastkey);
	keyboard_clear(vk_control);
	mouse_clear(mouse_lastbutton);


}
