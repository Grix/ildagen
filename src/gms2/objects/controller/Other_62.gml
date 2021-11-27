//if (!updatecheckenabled)
//    exit;

if (ds_map_find_value(async_load, "id") == updateget)
{
    if (ds_map_find_value(async_load, "status") == 0)
    {
        versionnew = ds_map_find_value(async_load, "result");
        log("Checking version");
        if (string_length(string(versionnew)) < 10 && versionnew != version)
        {
			//if (os_type == os_macosx)
			//	ilda_dialog_yesno("updatefound","New version available: "+versionnew+", would you like to download and install?");
			//else
				ilda_dialog_yesno("updatefound","New version available: "+versionnew+"\nWould you like to download and install the update?\n\n"+releasenotes+"\n\n");
        }
        else if (update_verbose == 1)
        {
	 		show_message_new("Current version is up to date.");
        }
    }
}
else if (ds_map_find_value(async_load, "id") == updatenotes)
{
   if (ds_map_find_value(async_load, "status") == 0)
   {
		releasenotes = ds_map_find_value(async_load, "result");
		if (os_type == os_macosx)
			updateget = http_get("https://raw.githubusercontent.com/Grix/ildagen/master/version_mac.txt");
		else if (os_type == os_linux)
			updateget = http_get("https://raw.githubusercontent.com/Grix/ildagen/master/version_linux.txt");
		else
			updateget = http_get("https://raw.githubusercontent.com/Grix/ildagen/master/version.txt");
   }
}
else if (ds_map_find_value(async_load, "id") == file)
{
    if (ds_map_find_value(async_load, "status") == 0)
    {
        if (file_exists("temp\\update.exe"))
        {
            if (alarm[4] == -1)
            {
                show_message_new("Launching installer");
                url_open_new(FStemp+"update.exe");
                alarm[4] = 60;
            }
        }
        else 
        {
            if (updatereceived == 0)
            {
                show_message_new("Failed to automatically download update. Opening download website..");
                url_open_new("https://bitlasers.com/lasershowgen-sw/");
                updatereceived = 1;
            }
        }
     }
	 else if (ds_map_find_value(async_load, "status") < 0)
	{
        if (updatereceived == 0)
        {
            show_message_new("Failed to automatically download update. Opening download website..");
            url_open_new("https://bitlasers.com/lasershowgen-sw/");
            updatereceived = 1;
        }
    }
	
}

