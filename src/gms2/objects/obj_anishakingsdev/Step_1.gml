if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
{
    controller.anishaking_sdev = clamp((mouse_x-bbox_left)/72*10000, 0, 10000);
}

visible = (controller.shaking) and (controller.anienable);
if (!visible)
    exit;


if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Sets the intensity of the shaking at the end of the animation.";
} 

