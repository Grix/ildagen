if (instance_exists(obj_dropdown))
    exit;
_visible = controller.anienable;
if (!_visible) exit;

if (controller.shaking) 
    image_index = 2;
else if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    image_index = 1;
else 
    image_index = 0;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    controller.tooltip = "Toggles shaking animation effect. Changes will only apply to new animations, not existing ones.\nRight click for options.";

