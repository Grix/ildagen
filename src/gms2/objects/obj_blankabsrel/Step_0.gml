if (instance_exists(oDropDown))
    exit;
visible = (controller.blankmode != "solid") and (controller.blankmode != "func");
if (!visible)
    exit;
    

image_index = controller.blankmode2;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Toggles absolute or relative blanking intervals";
    } 

