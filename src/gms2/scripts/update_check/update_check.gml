function update_check() {
	if (os_browser != browser_not_a_browser) exit;

	log("Checking for updates")
	updatereceived = 0;

	if (os_type != os_linux)
		ini_filename = "settings.ini";
	else
		ini_filename = game_save_id + "settings.ini";
	if (file_exists(ini_filename))
	{
	    ini_open(ini_filename);
	    updatecheckenabled = ini_read_real("main","updatecheck", 1);
	    ini_close();
	    if (updatecheckenabled)
	    {
	        updatenotes = http_get("https://raw.githubusercontent.com/Grix/ildagen/master/versionnotes.txt");
	    }
	}
	else
	{
	    //ilda_dialog_yesno("update","Would you like to enable automatic checking for updates? (Requires internet connection)");
	    updatecheckenabled = true;
	    	if (os_type != os_linux)
			ini_filename = "settings.ini";
		else
			ini_filename = game_save_id + "settings.ini";
	    ini_open(ini_filename);
	    ini_write_real("main","updatecheck",updatecheckenabled);
	    ini_close();
	    if (updatecheckenabled)
	    {
			if (os_type == os_macosx)
				updateget = http_get("https://raw.githubusercontent.com/Grix/ildagen/master/version_mac.txt");
			else
				updateget = http_get("https://raw.githubusercontent.com/Grix/ildagen/master/version.txt");
	    }
	}



}
