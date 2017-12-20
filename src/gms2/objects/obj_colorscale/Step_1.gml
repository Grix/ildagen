if (instance_exists(obj_dropdown))
    exit;

if (mouse_x > bbox_left) && (mouse_x < bbox_right) && (mouse_y > bbox_top) && ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the bounds of colors in output, use to adjust white balance and accuracy of gradients.\n->Right click on a knob to enter precise values.";
} 

if (moving == 1) || ((moving < 4) && (moving > 0) && keyboard_check(vk_control))
{
    controller.red_scale = clamp(1 - (mouse_y-bbox_top)/52, controller.red_scale_lower+0.001, 1);
}
if (moving == 2) || ((moving < 4) && (moving > 0) && keyboard_check(vk_control))
{
    controller.green_scale = clamp(1 - (mouse_y-bbox_top)/52, controller.green_scale_lower+0.001, 1);
}
if (moving == 3) || ((moving < 4) && (moving > 0) && keyboard_check(vk_control))
{
    controller.blue_scale = clamp(1 - (mouse_y-bbox_top)/52, controller.blue_scale_lower+0.001, 1);
}
if (moving == 4) || ((moving > 3) && keyboard_check(vk_control))
{
    controller.red_scale_lower = clamp(1 - (mouse_y-bbox_top)/52, 0, controller.red_scale-0.001);
}
if (moving == 5) || ((moving > 3) && keyboard_check(vk_control))
{
    controller.green_scale_lower = clamp(1 - (mouse_y-bbox_top)/52, 0, controller.green_scale-0.001);
}
if (moving == 6) || ((moving > 3) && keyboard_check(vk_control))
{
    controller.blue_scale_lower = clamp(1 - (mouse_y-bbox_top)/52, 0, controller.blue_scale-0.001);
}

if (controller.laseron && moving > 0)
	save_profile();
    
mouse_yprevious = mouse_y;

