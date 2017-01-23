///show_question_new(message)

if (os_browser == browser_not_a_browser)
    return (show_question_win(argument[0], "LasershowGen", 0));
else
    return (show_question_async(argument[0]));
