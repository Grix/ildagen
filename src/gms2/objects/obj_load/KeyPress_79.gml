if (keyboard_check_control())
{
	if (os_browser != browser_not_a_browser)
	{
	    show_message_new("Sorry, this feature is not available in the web version yet");
	    exit;
	}

	if (room == rm_ilda)
	{
	    ilda_dialog_yesno("loadfile","This will replace your current frames, all unsaved work will be lost. Continue? (Cannot be undone)");
	}
}
