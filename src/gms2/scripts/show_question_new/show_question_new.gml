/// @description show_question_new(message)
/// @function show_question_new
/// @param message

if (os_browser == browser_not_a_browser)
    return (show_question_win(string(argument[0]), "LaserShowGen", $00040000 /*topmost*/));
else
    return (show_question_async(argument[0]));
