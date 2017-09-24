visible = controller.exp_optimize;
if (!visible)
    exit;
if (instance_exists(obj_dropdown))
    exit;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Changes max duration of dwell at angles, in number of points. #Right click to set custom amount.";
    
    if ((mouse_x - bbox_left) > 24)
        image_index = 1;
    else
        image_index = 2;
    } 
else
    image_index = 0;

