function dd_ilda_importilda() {
	if (os_browser != browser_not_a_browser)
	    exit;
    
	if (os_browser != browser_not_a_browser)
	{
	    show_message_new("Sorry, this feature is not available in the web version yet");
	    exit;
	}

	ilda_cancel();
	import_ilda(get_open_filename_ext("ILDA files|*.ild","","","Select ILDA file"));
	keyboard_clear(keyboard_lastkey);
	keyboard_clear(vk_control);
	mouse_clear(mouse_lastbutton);



}
