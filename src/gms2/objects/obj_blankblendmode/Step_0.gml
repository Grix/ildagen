if (instance_exists(obj_dropdown))
    exit;
    
image_index = controller.blank_blendmode;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the blanking blending mode when reapplying blanking properties to an object.";
    image_index += 4;
}


