if (instance_exists(obj_dropdown))
    exit;
visible = controller.anienable;
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Sets the number of times to repeat the animation. Changes will only apply to new animations, not existing ones.";
    
    if ((mouse_x - bbox_left) > 24)
        image_index = 1;
    else
        image_index = 2;
} 
else
    image_index = 0;

