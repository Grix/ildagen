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
	
if (os_type != os_linux)
	ini_open("settings.ini");
else
	ini_open(game_save_id + "settings.ini");
ini_write_real("main", "dpi_scaling_override", value);
ini_close();

if (value == 0)
{
	var t_windowwidth = window_get_width();
	var t_windowheight = window_get_height();
	
	controller.dpi_multiplier = clamp(min( ceil(t_windowheight/(735*2.05)), ceil(t_windowwidth/(1350*2)) ),1,3);
	if (controller.dpi_multiplier == 1 && t_windowheight > 1460)
		controller.dpi_multiplier = 1.5;
}
else
	controller.dpi_multiplier = value;
	
controller.dpi_scaling = value;
controller.forceresize = true;