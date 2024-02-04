if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
{
    livecontrol.masterabsrot = clamp((mouse_x-bbox_left)/72*pi*2, 0, pi*2);
	if (keyboard_check_control()) 
		livecontrol.masterabsrot = pi;
}
    
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the master rotation offset for all playing files.";
} 

