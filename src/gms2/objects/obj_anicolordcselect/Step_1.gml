if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
{
    controller.anicolor_dc = clamp((mouse_x-bbox_left)/128, 0, 1);
}
    
visible = (controller.colormode == "dash") and (controller.anienable);
if (!visible) 
    exit;


if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Sets the ratio (duty cycle) of the primary and secondary colors at the end of animation.";
} 

