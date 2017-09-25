if (instance_exists(obj_dropdown))
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the bounds of colors in output, use to adjust white balance and accuracy of gradients.\n->Right click on a knob to enter precise values.";
} 

if (moving == 1) or ((moving < 4) and (moving > 0) and keyboard_check(vk_control))
{
    red = controller.red_scale * 255;
    red -= (mouse_y-mouse_yprevious)*255/52;
    red = clamp(red, (controller.red_scale_lower*255), 255);
    controller.red_scale = red/255;
}
if (moving == 2) or ((moving < 4) and (moving > 0) and keyboard_check(vk_control))
{
    green = controller.green_scale * 255;
    green -= (mouse_y-mouse_yprevious)*255/52;
    green = clamp(green, (controller.green_scale_lower*255), 255);
    controller.green_scale = green/255;
}
if (moving == 3) or ((moving < 4) and (moving > 0) and keyboard_check(vk_control))
{
    blue = controller.blue_scale * 255;
    blue -= (mouse_y-mouse_yprevious)*255/52;
    blue = clamp(blue, (controller.blue_scale_lower*255), 255);
    controller.blue_scale = blue/255;
}
if (moving == 4) or ((moving > 3) and keyboard_check(vk_control))
{
    red = controller.red_scale_lower * 255;
    red -= (mouse_y-mouse_yprevious)*255/52;
    red = clamp(red, 0, (controller.red_scale*255));
    controller.red_scale_lower = red/255;
}
if (moving == 5) or ((moving > 3) and keyboard_check(vk_control))
{
    green = controller.green_scale_lower * 255;
    green -= (mouse_y-mouse_yprevious)*255/52;
    green = clamp(green, 0, (controller.green_scale*255));
    controller.green_scale_lower = green/255;
}
if (moving == 6) or ((moving > 3) and keyboard_check(vk_control))
{
    blue = controller.blue_scale_lower * 255;
    blue -= (mouse_y-mouse_yprevious)*255/52;
    blue = clamp(blue, 0, (controller.blue_scale*255));
    controller.blue_scale_lower = blue/255;
}
    
mouse_yprevious = mouse_y;

