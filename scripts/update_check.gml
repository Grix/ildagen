if (os_browser != browser_not_a_browser) exit;

show_debug_message("Checking for updates")
updatereceived = 0;

ini_filename = "settings.ini";
if (file_exists(ini_filename))
    {
    ini_open(ini_filename);
    updatecheckenabled = ini_read_real("main","updatecheck",0);
    ini_close();
    if (updatecheckenabled)
        {
        updatenotes = http_get("https://raw.githubusercontent.com/Grix/ildagen/master/versionnotes.txt");
        }
    }
else
    {
    ilda_dialog_yesno("update","Would you like to enable automatic checking for updates? (Requires internet connection)");
    }
