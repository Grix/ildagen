if (instance_exists(obj_dropdown))
    exit;
visible = controller.anienable;
if (!visible) exit;

if (controller.shaking) 
    image_index = 2;
else if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    image_index = 1;
else 
    image_index = 0;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    controller.tooltip = "Toggles shaking effect#Right click for options";

