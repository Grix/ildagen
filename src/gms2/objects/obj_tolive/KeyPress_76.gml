if (instance_exists(obj_dropdown))
    exit;
    
if (os_browser != browser_not_a_browser)
{
    show_message_new("Sorry, this feature is not available in the web version");
    exit;
}

with (controller)
{
	frames_tolive();
}

