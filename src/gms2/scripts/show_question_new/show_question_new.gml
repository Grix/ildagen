/// @description show_question_new(message)
/// @function show_question_new
/// @param message
function show_question_new() {

	var t_ret;
	if (os_browser == browser_not_a_browser)
	{
		if (os_type == os_windows)
			t_ret = show_question_win(string(argument[0]), "LaserShowGen", $00040000);
		else
			t_ret = show_question_async(argument[0]);
	}
	else
	    t_ret = show_question_async(argument[0]);

	keyboard_clear(keyboard_lastkey);
	mouse_clear(mouse_lastbutton);
	io_clear();

	return t_ret;

}
