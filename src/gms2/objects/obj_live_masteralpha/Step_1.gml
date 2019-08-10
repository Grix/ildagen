if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
{
    livecontrol.masteralpha = clamp((mouse_x-bbox_left)/72*100, 0, 100);
}
    
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the master intensity for all playing files.";
} 

