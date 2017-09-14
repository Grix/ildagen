if (instance_exists(oDropDown))
    exit;
if (!visible) exit;

if (mouse_x < (x+14))
    {
    ilda_dialog_num("c2r","Enter value for RED from 0 to 255",colour_get_red(controller.color2));
    
    }
else if (mouse_x > (x+30))
    {
    ilda_dialog_num("c2b","Enter value for BLUE from 0 to 255",colour_get_blue(controller.color2));
   
    }
else 
    {
    ilda_dialog_num("c2g","Enter value for GREEN from 0 to 255",colour_get_green(controller.color2));
   
    }

