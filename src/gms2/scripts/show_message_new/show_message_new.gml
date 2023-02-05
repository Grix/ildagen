/// @description show_message_new(message)
/// @function show_message_new
/// @param message
function show_message_new() {

	if (os_browser == browser_not_a_browser)
	{
		if (os_type == os_windows)
			show_message(string(argument[0]));//, "LaserShowGen", $00040000);
		else
			//show_message_async(argument[0]);*/
			show_message(string(argument[0]));
	}
	else
	    show_message_async(argument[0]);
	
	keyboard_clear(keyboard_lastkey);
	keyboard_clear(vk_control);
	mouse_clear(mouse_lastbutton);


}
