if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
    {
    controller.anicolor_offset += (mouse_x-mouse_xprevious)*360/128;
    if (controller.anicolor_offset  < 0) controller.anicolor_offset = 0;
    if (controller.anicolor_offset > 360) controller.anicolor_offset = 360;
    }
    
visible = (controller.colormode != "solid") and (controller.anienable)  and (controller.colormode != "func");
if (!visible)
    exit;
    
mouse_xprevious = mouse_x;    
    
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Changes the periodic offset of the coloring at the end of the animation";
    } 

