if (instance_exists(oDropDown))
    exit;
visible = !seqcontrol.largepreview || (room == rm_options);
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    image_index = 1;
    controller.tooltip = "Enter frame editor mode (Shortcut: Tab)";
} 
else 
    image_index = 0;

