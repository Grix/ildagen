function dd_seq_importframes() {
	if (os_browser != browser_not_a_browser)
	{
	    show_message_new("Sorry, this feature is not available in the web version yet");
	    exit;
	}

	with (seqcontrol)
	    load_frames_seq(get_open_filename_ext("LSG frames|*.igf","","","Select LaserShowGen frames file"));
	keyboard_clear(keyboard_lastkey);
	mouse_clear(mouse_lastbutton);



}
