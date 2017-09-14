if (instance_exists(oDropDown))
    exit;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    //image_index = 1;
    controller.tooltip = "Enable automatic update checking at program startup. Requires internet.";
    } 

