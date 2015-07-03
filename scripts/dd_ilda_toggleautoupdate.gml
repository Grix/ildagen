ini_filename = "settings.ini";

ini_open(ini_filename);
updatecheckenabled = !ini_read_real("main","updatecheck",0);
ini_write_real("main","updatecheck",updatecheckenabled);
ini_close();