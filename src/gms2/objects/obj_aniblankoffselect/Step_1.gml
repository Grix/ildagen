if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
    {
    controller.aniblank_offset += (mouse_x-mouse_xprevious)*360/128;
    if (controller.aniblank_offset  < 0) controller.aniblank_offset = 0;
    if (controller.aniblank_offset > 360) controller.aniblank_offset = 360;
    }
    
visible = (controller.blankmode != "solid")  and (controller.blankmode != "func") and (controller.anienable);
if (!visible)
    exit;

mouse_xprevious = mouse_x;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Changes the blanking periodic offset at end of animation.";
    } 

