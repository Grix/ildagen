if (os_browser != browser_not_a_browser)
{
    show_message_new("Sorry, this feature is not available in the web version yet");
    exit;
}

with (livecontrol)
	load_folder_live(get_directory_alt("Select folder with ILDA files or LSG frame files", ""));
keyboard_clear(keyboard_lastkey);
mouse_clear(mouse_lastbutton);