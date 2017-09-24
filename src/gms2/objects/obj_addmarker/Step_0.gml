if (instance_exists(obj_dropdown))
    exit;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    image_index = 1;
    controller.tooltip = "Adds a guideline marker to the current timeline position (Shortcut: L)";
    } 
else image_index = 0;

