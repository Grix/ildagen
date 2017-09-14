if (instance_exists(oDropDown))
    exit;
if (moving == 1)
    {
    controller.wave_amp += (mouse_x-mouse_xprevious)*$ffff/128;
    if (controller.wave_amp  < -$ffff/2) controller.wave_amp = -$ffff/2;
    if (controller.wave_amp > $ffff/2) controller.wave_amp = $ffff/2;
    if (keyboard_check(vk_control)) controller.wave_amp = 0;
    }
    
mouse_xprevious = mouse_x;


visible = (controller.placing == "wave");
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Changes wave height (Shortcut: Mouse wheel)";
    } 
    


