if (os_browser == browser_not_a_browser)
{
	if (os_type != os_windows)
		url_open_ext(argument0,"_blank");
    else
		open_in_explorer(argument0);
}
else
    url_open_ext(argument0,"_blank");