image_speed = 0;
moving = 0;

activecolor = controller.color2;
if (is_undefined(activecolor))
	activecolor = c_white;
redy = y+23-(color_get_red(activecolor)/255*23);
greeny = y+23-(color_get_green(activecolor)/255*23);
bluey = y+23-(color_get_blue(activecolor)/255*23);

redx = x;
greenx = x+16;
bluex = x+32;

xplus70 = x+70;
yplus16 = y+16;
transparent = true;