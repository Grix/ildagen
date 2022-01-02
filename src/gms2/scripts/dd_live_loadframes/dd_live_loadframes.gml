function dd_live_loadframes() {
	if (os_browser != browser_not_a_browser)
	{
	    show_message_new("Sorry, this feature is not available in the web version yet");
	    exit;
	}

	with (livecontrol)
		load_frames_live(get_open_filename_ext("LSG frames|*.igf","","","Select LaserShowGen frames file"));
	keyboard_clear(keyboard_lastkey);
	keyboard_clear(vk_control);
	mouse_clear(mouse_lastbutton);


}
