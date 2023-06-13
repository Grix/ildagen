if (instance_exists(obj_dropdown))
    exit;
if (!visible) exit;

if (mouse_x < (x+14))
    {
    ilda_dialog_num("ac3r","Enter value for RED from 0 to 255",color_get_red(controller.anienddotscolor));
    
    }
else if (mouse_x > (x+30))
    {
    ilda_dialog_num("ac3b","Enter value for BLUE from 0 to 255",color_get_blue(controller.anienddotscolor));
   
    }
else 
    {
    ilda_dialog_num("ac3g","Enter value for GREEN from 0 to 255",color_get_green(controller.anienddotscolor));
   
    }

