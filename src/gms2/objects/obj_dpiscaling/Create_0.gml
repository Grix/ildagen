image_speed = 0;

ini_open("settings.ini");
value = ini_read_real("main", "dpi_scaling_override", 0);
ini_close();

if (value < 0)
	value = 0;
if (value > 3)
	value = 3;