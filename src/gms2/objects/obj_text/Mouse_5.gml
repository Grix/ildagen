if (instance_exists(obj_dropdown))
    exit;
if (os_browser != browser_not_a_browser)
{
    show_message_new("Sorry, this feature is not available in the web version yet");
    exit;
}

dropdown_text();

with (controller)
{
    placing = "text";
    placing_status = 0;
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
    exit;
}

