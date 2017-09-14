if (instance_exists(oDropDown))
    exit;
visible = (controller.maxframes > 1);
if (!visible) exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    image_index = 1;
    controller.tooltip = "Edits the start and end point of placed animation";
    }
else image_index = 0; 

