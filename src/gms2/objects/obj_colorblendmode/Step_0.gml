if (instance_exists(oDropDown))
    exit;
    
image_index = controller.color_blendmode;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the color blending mode when reapplying color properties to an object.";
    image_index += 3;
}

