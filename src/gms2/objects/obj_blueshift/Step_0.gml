visible = controller.exp_optimize;
if (!visible)
    exit;
if (instance_exists(oDropDown))
    exit;
    
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Changes the BLUE color offset in points. Right click to set custom amount.#Hold Ctrl and click to change all offsets at once.#Try setting this to -3 or so if you see trailing on tips of lines.";
    
    if ((mouse_x - bbox_left) > 24)
        image_index = 1;
    else
        image_index = 2;
    } 
else
    image_index = 0;

