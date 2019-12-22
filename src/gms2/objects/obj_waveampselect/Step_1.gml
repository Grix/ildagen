if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
{
    controller.wave_amp = clamp((mouse_x-bbox_left)/128*$ffff - $8000, -$8000, $8000);
	if (keyboard_check_control()) 
		controller.wave_amp = 0;
}

visible = (controller.placing == "wave");
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes wave height (Shortcut: Mouse wheel)";
} 
    


