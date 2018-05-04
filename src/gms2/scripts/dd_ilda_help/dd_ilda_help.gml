if (os_browser == browser_not_a_browser)
{
	if (os_type == os_windows)
		url_open_new("help.pdf");
	else
		url_open("https://github.com/Grix/ildagen/raw/master/help.pdf");
}
else
    url_open_new("help.pdf");
