if (os_version == -1) exit;

show_debug_message("Checking for updates")

ini_filename = "settings.ini";
if (file_exists(ini_filename))
    {
    ini_open(ini_filename);
    updatecheckenabled = ini_read_real("main","updatecheck",0);
    ini_close();
    if (updatecheckenabled)
        {
        updateget = http_get("http://github.com/Grix/ildagen/raw/master/version.txt");
        }
    }
else
    {
    ilda_dialog_yesno("update","Would you like to enable automatic checking for updates? (Requires internet connection)");
    }