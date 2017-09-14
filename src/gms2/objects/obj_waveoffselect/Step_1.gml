if (instance_exists(oDropDown))
    exit;
if (moving == 1)
    {
    controller.wave_offset += (mouse_x-mouse_xprevious)*360/128;
    controller.wave_offset = clamp(controller.wave_offset,0,360);
    }
    
mouse_xprevious = mouse_x;


visible = (controller.placing == "wave");
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Changes the periodic offset of the wave shape";
    } 

