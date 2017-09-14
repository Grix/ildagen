if (instance_exists(oDropDown))
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    image_index = 1;
    controller.tooltip = "Changes the number of frames per second (FPS) of the animation";
    }
else image_index = 0; 

