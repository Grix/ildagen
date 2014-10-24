ini_filename = working_directory+"settings.ini";
if (file_exists(ini_filename))
    {
    ini_open(ini_filename);
    updatecheckenabled = ini_read_real("main","updatecheck",0);
    if (!ini_key_exists("main","showmessages"))
        show_messages = ini_read_real("main","showmessages",0);
    else
        show_messages = 1;
    ini_close();
    }
else
    {
    ini_open(ini_filename);
    updatecheckenabled = show_question("Would you like to enable automatic checking for updates? (Requires internet connection)");
    show_messages = 1;
    ini_write_real("main","updatecheck",updatecheckenabled);
    ini_write_real("main","showmessages",show_messages);
    ini_close();
    }
if (updatecheckenabled)
    {
    updateget = http_get("http://github.com/Grix/ildagen/raw/master/version.txt");
    }
