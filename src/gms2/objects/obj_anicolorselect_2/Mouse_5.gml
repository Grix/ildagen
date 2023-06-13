if (instance_exists(obj_dropdown))
    exit;
if (!visible) exit;

if (mouse_x < (x+14))
{
    ilda_dialog_num("ac2r","Enter value for RED from 0 to 255",color_get_red(controller.anicolor2));
}
else if (mouse_x > (x+30))
{
    ilda_dialog_num("ac2b","Enter value for BLUE from 0 to 255",color_get_blue(controller.anicolor2));
}
else 
{
    ilda_dialog_num("ac2g","Enter value for GREEN from 0 to 255",color_get_green(controller.anicolor2));
}

