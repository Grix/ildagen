if (instance_exists(oDropDown))
    exit;
visible = (controller.maxframes > 1);
if (!visible) exit;

if (controller.onion)
    {
    image_index = 2;
    if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
        {
        controller.tooltip = "Turn off onion skinning (Superimposing previous frames on top)#Right-click for settings.";
        }
    }
else if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    image_index = 1;
    controller.tooltip = "Turn on onion skinning (Superimposing previous frames on top)#Right-click for settings.";
    } 
else image_index = 0;

