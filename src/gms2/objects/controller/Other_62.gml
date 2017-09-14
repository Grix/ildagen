//if (!updatecheckenabled)
//    exit;
    
if (ds_map_find_value(async_load, "id") == updateget)
{
    if ds_map_find_value(async_load, "status") == 0
   {
       versionnew = ds_map_find_value(async_load, "result");
       log("Checking version")
       if (versionnew != version)
        {
            ilda_dialog_yesno("updatefound","New version available: "+versionnew+"#"+"Would you like to download and install the update?##"+releasenotes+"##");
        }
       else if (update_verbose == 1)
        {
            show_message_new("Current version is up to date.");
        }
   }
}
else if (ds_map_find_value(async_load, "id") == updatenotes)
{
    if ds_map_find_value(async_load, "status") == 0
   {
       releasenotes = ds_map_find_value(async_load, "result");
       updateget = http_get("https://raw.githubusercontent.com/Grix/ildagen/master/version.txt");
   }
}
else if (ds_map_find_value(async_load, "id") == file)
{
     if ds_map_find_value(async_load, "status") == 0
    {
        if (file_exists("temp/update.exe"))
        {
            if (alarm[4] == -1)
            {
                show_message_new("Launching installer");
                url_open_new(FStemp+"update.exe")
                alarm[4] = 60;
            }
        }
        else 
        {
            if (updatereceived == 0)
            {
                show_message_new("Failed to automatically download update. Opening download website..");
                url_open_new("http://pages.bitlasers.com/lasershowgen/");
                updatereceived = 1;
            }
        }
     }
}

