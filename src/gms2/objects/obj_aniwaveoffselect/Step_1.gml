if (instance_exists(oDropDown))
    exit;
if (moving == 1)
    {
    controller.aniwave_offset += (mouse_x-mouse_xprevious)*360/128;
    if (controller.aniwave_offset  < 0) controller.aniwave_offset = 0;
    if (controller.aniwave_offset > 360) controller.aniwave_offset = 360;
    }

visible = (controller.placing == "wave") and (controller.anienable);
if (!visible)
    exit;
    
mouse_xprevious = mouse_x;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Changes the periodic offset of the wave shape at the end of the animation.";
    } 

