//visible = controller.exp_optimize;
if (!visible)
    exit;
if (instance_exists(obj_dropdown))
    exit;
    
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the RED color offset in points. Right click to set custom amount.\nHold "+get_ctrl_string()+" and click to change all offsets at once.\nTry setting this to -5 or so if you see trailing on tips of lines.";
    
    if ((mouse_x - bbox_left) > 24)
        image_index = 1;
    else
        image_index = 2;
} 
else
    image_index = 0;

