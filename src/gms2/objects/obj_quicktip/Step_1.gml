if (instance_exists(obj_ad))
	exit;

if (mouse_x == clamp(mouse_x, button_ok_x1, button_ok_x2) && mouse_y == clamp(mouse_y, button_ok_y1, button_ok_y2))
{
	controller.tooltip = ".";
}

else if (mouse_x == clamp(mouse_x, button_x1, button_x2) && mouse_y == clamp(mouse_y, button_y1, button_y2))
{
	controller.tooltip = ".";
	if (mouse_check_button(mb_left))
	{
		ini_open("settings.ini");
		ini_write_real("quicktips", "tip_viewed_"+string(tip_id), 1);
		ini_close();
		instance_destroy();
	}
}

if (mouse_check_button_pressed(mb_left))
{
	if (ready > 10)
		instance_destroy();
}

ready++;