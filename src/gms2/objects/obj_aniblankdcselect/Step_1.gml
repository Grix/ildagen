if (instance_exists(oDropDown))
    exit;

if (moving == 1)
    {
    controller.aniblank_dc += (mouse_x-mouse_xprevious)/128;
    if (controller.aniblank_dc  < 0) controller.aniblank_dc = 0;
    if (controller.aniblank_dc > 1) controller.aniblank_dc = 1;
    }

visible = (controller.blankmode == "dash") and (controller.anienable);
if (!visible)
    exit;
    
mouse_xprevious = mouse_x;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Changes the ratio of blank on/off at the end of the animation.";
    } 

