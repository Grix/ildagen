function update_check_verbose() {
	if (os_browser != browser_not_a_browser) 
		exit;

	log("Checking for updates");
	updatereceived = 0;

	with (controller)   
	{
	    update_verbose = 1;
	    updatenotes = http_get("https://raw.githubusercontent.com/Grix/ildagen/master/versionnotes.txt");
	}



}
