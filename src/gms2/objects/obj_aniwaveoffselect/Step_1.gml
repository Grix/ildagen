if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
{
    controller.aniwave_offset = clamp((mouse_x-bbox_left)/128*360, 0, 360);
}

visible = (controller.placing == "wave") and (controller.anienable);
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Sets the periodic offset of the wave shape at the end of the animation.";
} 

