if (instance_exists(oDropDown))
    exit;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    image_index = 1;
    controller.tooltip = "Sends the frames from the editor mode to the selected#position in the timeline mode (Shortcut: I)";
    } 
else image_index = 0;

