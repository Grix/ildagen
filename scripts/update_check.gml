if (os_version == -1) exit;

show_debug_message("Checking for updates")

ini_filename = working_directory+"settings.ini";
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
    with (controller)
        {
        dialog = "update";
        getint = show_question_async("Would you like to enable automatic checking for updates? (Requires internet connection)");
        }
    }
