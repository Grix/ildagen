if (instance_exists(oDropDown))
    exit;
if (moving == 1)
    {
    controller.anishaking_sdev += (mouse_x-mouse_xprevious)*50/72;
    if (controller.anishaking_sdev  < 0) controller.anishaking_sdev = 0;
    if (controller.anishaking_sdev > 50) controller.anishaking_sdev = 50;
    }

visible = (controller.shaking) and (controller.anienable);
if (!visible)
    exit;

mouse_xprevious = mouse_x;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Changes the intensity of the shaking at the end of the animation";
    } 

