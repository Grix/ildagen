if (instance_exists(obj_dropdown))
    exit;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    image_index = 1;
    controller.tooltip = "Adds a DMX (Art-Net) output event to the current timeline position. (Shortcut: E)";
} 
else image_index = 0;

