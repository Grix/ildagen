if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
{
    livecontrol.mastery = clamp((mouse_x-bbox_left)/72*$ffff-$8000, -$8000, $8000);
}
    
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the master Y offset for all playing files.";
} 

