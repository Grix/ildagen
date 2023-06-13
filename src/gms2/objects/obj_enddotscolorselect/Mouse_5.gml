if (instance_exists(obj_dropdown))
    exit;
if (!visible) exit;

if (mouse_x < (x+14))
{	
    ilda_dialog_num("c3r","Enter value for RED from 0 to 255",color_get_red(controller.enddotscolor));
}	
else if (mouse_x > (x+30))
{
    ilda_dialog_num("c3b","Enter value for BLUE from 0 to 255",color_get_blue(controller.enddotscolor));
}	
else 
{
    ilda_dialog_num("c3g","Enter value for GREEN from 0 to 255",color_get_green(controller.enddotscolor));
}

