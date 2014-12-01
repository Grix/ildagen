ini_filename = working_directory+"settings.ini";
if (file_exists(ini_filename))
    {
    ini_open(ini_filename);
    updatecheckenabled = ini_read_real("main","updatecheck",0);
    ini_close();
    }
else
    {
    ini_open(ini_filename);
    updatecheckenabled = show_question("Would you like to enable automatic checking for updates? (Requires internet connection)");
    ini_write_real("main","updatecheck",updatecheckenabled);
    ini_close();
    }
if (updatecheckenabled)
    {
    updateget = http_get("http://github.com/Grix/ildagen/raw/master/version.txt");
    }
