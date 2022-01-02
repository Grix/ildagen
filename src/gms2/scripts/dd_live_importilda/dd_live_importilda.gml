function dd_live_importilda() {
	with (livecontrol)
		import_ildalive(get_open_filename_ext("ILDA files|*.ild","","","Select ILDA file"));
	keyboard_clear(keyboard_lastkey);
	keyboard_clear(vk_control);
	mouse_clear(mouse_lastbutton);


}
