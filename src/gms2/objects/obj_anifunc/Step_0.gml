if (instance_exists(oDropDown))
    exit;
visible = controller.anienable;
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    controller.tooltip = "Changes the shape of the animation function (transition over time)";
    }
