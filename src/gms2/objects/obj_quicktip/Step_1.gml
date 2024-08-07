if (instance_exists(obj_ad))
	exit;
	
if (y != yprev)
	event_perform(ev_other, ev_room_start);

if (mouse_x == clamp(mouse_x, button_ok_x1, button_ok_x2) && mouse_y == clamp(mouse_y, button_ok_y1, button_ok_y2))
{
	controller.tooltip = ".";
}

else if (mouse_x == clamp(mouse_x, button_x1, button_x2) && mouse_y == clamp(mouse_y, button_y1, button_y2))
{
	controller.tooltip = ".";
	if (mouse_check_button(mb_left))
	{
		if (os_type != os_linux)
			ini_open("settings.ini");
		else
			ini_open(game_save_id + "settings.ini");
		ini_write_real("quicktips", "tip_viewed_"+string(tip_id), 1);
		ini_close();
		ds_list_add(controller.quicktip_closed_list, tip_id);
		instance_destroy();
	}
}
else if (room == rm_ilda && mouse_x == clamp(mouse_x, button_youtube_x1, button_youtube_x2) && mouse_y == clamp(mouse_y, button_youtube_y1, button_youtube_y2))
{
	controller.tooltip = ".";
	if (mouse_check_button(mb_left))
	{
		url_open("https://www.youtube.com/watch?v=l4a1p9EG1Y8");
		instance_destroy();
	}
}

if (mouse_check_button_pressed(mb_left))
{
	if (ready > 10)
	{
		ds_list_add(controller.quicktip_closed_list, tip_id);
		instance_destroy();
	}
}

ready++;