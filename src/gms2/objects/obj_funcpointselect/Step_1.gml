if (instance_exists(oDropDown))
    exit;
if (moving == 1)
    {
    controller.shapefunc_cp += (mouse_x-mouse_xprevious)/128*400;
    if (controller.shapefunc_cp < 2) controller.shapefunc_cp = 2
    }
    
mouse_xprevious = mouse_x;

visible = (controller.placing == "func");
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Changes the number of points to calculate along the functions";
    } 

