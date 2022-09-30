function dd_ilda_loadframes() {
	if (os_browser != browser_not_a_browser)
	    exit;
    
	if (os_browser != browser_not_a_browser)
	{
	    show_message_new("Sorry, this feature is not available in the web version yet");
	    exit;
	}

	if (!controller.warning_disable)
		ilda_dialog_yesno("loadfile","This will replace your current frames, all unsaved work will be lost. Continue? (Cannot be undone)");
	else
		with (controller)
			load_frames(get_open_filename_ext("LSG frames|*.igf","","","Select LaserShowGen frames file"));
}
