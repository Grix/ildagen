if (instance_exists(oDropDown))
    exit;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    image_index = 1;
    controller.tooltip = "Click to open settings and laser configuration.";
    }
else
    image_index = 0;


