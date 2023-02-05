function url_open_new(argument0) {
	if (os_browser == browser_not_a_browser)
	{
		if (os_type != os_windows)
			url_open_ext(argument0,"_blank");
	    else
			execute_shell_simple(argument0);
	}
	else
	    url_open_ext(argument0,"_blank");


}
