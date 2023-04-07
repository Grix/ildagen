image_speed = 0;

value = 0;
if (os_type != os_linux)
	ini_open("settings.ini");
else
	ini_open(game_save_id + "settings.ini");
value = ini_read_real("main", "dpi_scaling_override", 0);
ini_close();

if (value < 0)
	value = 0;
if (value > 3)
	value = 3;