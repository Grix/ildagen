if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
{
    controller.blank_dc = clamp((mouse_x-bbox_left)/128, 0, 1);
}
    
visible = (controller.blankmode == "dash");    
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the ratio of blanking on and off";
} 

