if (instance_exists(oDropDown))
    exit;
if (moving == 1)
    {
    controller.blank_offset += (mouse_x-mouse_xprevious)*360/128;
    if (controller.blank_offset  < 0) controller.blank_offset = 0;
    if (controller.blank_offset > 360) controller.blank_offset = 360;
    }

visible = (controller.blankmode != "solid") and (controller.blankmode != "func");
if (!visible)
    exit;
    
mouse_xprevious = mouse_x;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Changes the periodic offset of the blanking";
    } 

