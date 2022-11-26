image_speed = 0;
ini_filename = "settings.ini";
ini_open(ini_filename);
	updatecheckenabled = ini_read_real("main","updatecheck", 1);
ini_close();
image_index = updatecheckenabled;

