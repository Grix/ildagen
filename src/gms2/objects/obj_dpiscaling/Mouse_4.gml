if (instance_exists(obj_dropdown))
    exit;
if (!visible)
    exit;

if (mouse_x > (x+23))
{
	if (value == 1 || value == 1.5)
		value += 0.5;
	else
		value += 1;
}
else
{
	if (value == 2 || value == 1.5)
		value -= 0.5;
	else
		value -= 1;
}
	
if (value < 0)
	value = 0;
if (value > 3)
	value = 3;
	
ini_open("settings.ini");
ini_write_real("main", "dpi_scaling_override", value);
ini_close();

if (value == 0)
	controller.dpi_multiplier = ceil(display_get_height()/1700);
else
	controller.dpi_multiplier = value;
	
controller.dpi_scaling = value;
controller.forceresize = true;