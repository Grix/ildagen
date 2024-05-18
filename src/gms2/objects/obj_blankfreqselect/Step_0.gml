if (instance_exists(obj_dropdown))
    exit;
visible = (controller.blankmode != "solid") && (controller.blankmode2 == 0) and (controller.blankmode != "func");
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes number of stroke blanking intervals per whole element.";
    
    if ((mouse_x - bbox_left) > 24)
        image_index = 1;
    else
        image_index = 2;
} 
else
    image_index = 0;

