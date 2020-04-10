var t_close = false;
ini_open("settings.ini");
	if (ini_read_real("quicktips", "tip_viewed_"+string(tip_id), 0))
		t_close = true;
ini_close();

if (t_close)
	instance_destroy();

width = 400;
height = ceil(string_width(message)/400)*20;
height += 25*string_count("\n",message);

button_ok_x1 = x+width-140;
button_ok_x2 = x+width-20;
button_ok_y1 = y+height+30;
button_ok_y2 = y+height+55;

button_x1 = button_ok_x1-200;
button_x2 = button_ok_x2-200;
button_y1 = button_ok_y1;
button_y2 = button_ok_y2;