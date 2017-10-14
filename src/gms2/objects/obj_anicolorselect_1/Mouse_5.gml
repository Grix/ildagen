if (instance_exists(obj_dropdown))
    exit;
if (!visible) exit;

if (mouse_x < (x+14))
{
    ilda_dialog_num("ac1r","Enter value for RED from 0 to 255",colour_get_red(controller.anicolor1));
}
else if (mouse_x > (x+30))
{
    ilda_dialog_num("ac1b","Enter value for BLUE from 0 to 255",colour_get_blue(controller.anicolor1));
}
else 
{
    ilda_dialog_num("ac1g","Enter value for GREEN from 0 to 255",colour_get_green(controller.anicolor1));
}

