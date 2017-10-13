if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
    {
    controller.blank_period += (mouse_x-mouse_xprevious)*$8000/128;
    if (controller.blank_period  < 1) controller.blank_period = 1;
    if (controller.blank_period > $8000) controller.blank_period = $8000;
    }
    
visible = (controller.blankmode != "solid") && (controller.blankmode2 == 1) and (controller.blankmode != "func");
if (!visible)
    exit;
    
mouse_xprevious = mouse_x;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Changes the length between blanking intervals";
    } 

