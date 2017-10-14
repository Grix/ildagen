if (instance_exists(obj_dropdown))
    exit;
if (!visible) 
	exit;

if (mouse_x < (x+14))
{
    ilda_dialog_num("c1r","Enter value for RED from 0 to 255",colour_get_red(controller.color1));
}
else if (mouse_x > (x+30))
{
    ilda_dialog_num("c1b","Enter value for BLUE from 0 to 255",colour_get_blue(controller.color1));
}
else 
{
    ilda_dialog_num("c1g","Enter value for GREEN from 0 to 255",colour_get_green(controller.color1));
}

