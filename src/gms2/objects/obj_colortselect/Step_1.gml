if (instance_exists(oDropDown))
    exit;
if (moving == 1)
    {
    controller.color_period += (mouse_x-mouse_xprevious)*$8000/128;
    if (controller.color_period  < 1) controller.color_period = 1;
    if (controller.color_period > $8000) controller.color_period = $8000;
    }

visible = ((controller.colormode == "rainbow") || (controller.colormode == "gradient") || (controller.colormode == "dash")) && (controller.colormode2 == 1);
if (!visible)
    exit;

mouse_xprevious = mouse_x;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Changes the length between color changes";
    } 

