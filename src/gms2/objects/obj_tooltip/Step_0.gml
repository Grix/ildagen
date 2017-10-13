if (instance_exists(obj_dropdown))
    exit;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    //image_index = 1;
    controller.tooltip = "Turn on or off this text.";
    } 
image_index = controller.show_tooltip;

