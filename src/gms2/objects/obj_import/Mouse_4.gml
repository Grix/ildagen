if (instance_exists(obj_dropdown))
    exit;

if (os_browser != browser_not_a_browser)
{
    show_message_new("Sorry, this feature is not available in the web version yet");
    exit;
}
    
with (controller)
{
    if (room == rm_ilda)
	{
        import_ilda(get_open_filename_ext("ILDA files|*.ild","","","Select ILDA file"));
		keyboard_clear(keyboard_lastkey);
		keyboard_clear(vk_control);
		mouse_clear(mouse_lastbutton);
	}
    else if (room == rm_seq)
    {
        import_ildaseq(get_open_filename_ext("ILDA files|*.ild","","","Select ILDA file"));
		keyboard_clear(keyboard_lastkey);
		keyboard_clear(vk_control);
		mouse_clear(mouse_lastbutton);
    }
	else if (room == rm_live)
    {
        import_ildalive(get_open_filename_ext("ILDA files|*.ild","","","Select ILDA file"));
		keyboard_clear(keyboard_lastkey);
		keyboard_clear(vk_control);
		mouse_clear(mouse_lastbutton);
    }
}


