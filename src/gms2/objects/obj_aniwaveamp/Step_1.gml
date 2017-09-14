if (instance_exists(oDropDown))
    exit;
if (moving == 1)
    {
    controller.aniwave_amp += (mouse_x-mouse_xprevious)*$ffff/128;
    if (controller.aniwave_amp  < -$ffff/2) controller.aniwave_amp = -$ffff/2;
    if (controller.aniwave_amp > $ffff/2) controller.aniwave_amp = $ffff/2;
    if (keyboard_check(vk_control)) controller.aniwave_amp = 0;
    }

visible = (controller.placing == "wave") and (controller.anienable);
if (!visible)
    exit;
    
mouse_xprevious = mouse_x;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Changes wave height at the end of the animation.";
    } 

