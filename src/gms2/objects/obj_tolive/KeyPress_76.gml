if (instance_exists(obj_dropdown))
    exit;
    
if (os_browser != browser_not_a_browser)
{
    show_message_new("Sorry, this feature is not available in the web version");
    exit;
}

with (controller)
{
    if (livecontrol.playingfile != -1)
    {
        ilda_dialog_yesno("tolivereplace","This will replace the selected live mode tile with these frames. Continue? (Cannot be undone)");
    }
    else
        frames_tolive();
}

