if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
{
    seqcontrol.intensity_scale = clamp((mouse_x-bbox_left)/128, 0, 1);
}

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Adjusts brightness of all output from timeline.";
} 
    