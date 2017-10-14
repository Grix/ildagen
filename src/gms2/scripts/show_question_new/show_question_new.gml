/// @description show_question_new(message)
/// @function show_question_new
/// @param message

if (os_browser == browser_not_a_browser)
{
	var t_caption = "LaserShowGen";
    show_question_win(string(argument[0]), t_caption, $00040000 /*topmost*/ );
}
else
    return (show_question_async(argument[0]));
