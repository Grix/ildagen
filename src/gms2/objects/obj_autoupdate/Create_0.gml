image_speed = 0;
if (os_type != os_linux)
	ini_filename = "settings.ini";
else
	ini_filename = game_save_id + "settings.ini";
	
ini_open(ini_filename);
	updatecheckenabled = ini_read_real("main","updatecheck", 1);
ini_close();
image_index = updatecheckenabled;

