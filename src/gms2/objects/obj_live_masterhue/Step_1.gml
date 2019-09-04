if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
{
    livecontrol.masterhue = clamp((mouse_x-bbox_left)/72*255, 0, 255);
}
    
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the master color hue offset for all playing files.";
} 

