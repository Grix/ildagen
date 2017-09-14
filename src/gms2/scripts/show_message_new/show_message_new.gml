/// @description show_message_new(message)
/// @function show_message_new
/// @param message

if (os_browser == browser_not_a_browser)
    show_message_win(string(argument[0]), "LaserShowGen", 0);
else
    show_message_async(argument[0]);
