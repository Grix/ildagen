if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
{
    livecontrol.masterx = clamp((mouse_x-bbox_left)/72*$ffff-$8000, -$8000, $8000);
	if (keyboard_check_control()) 
		livecontrol.masterx = 0;
}
    
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the master X position offset for all playing files.";
} 

