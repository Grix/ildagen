if (instance_exists(obj_dropdown))
    exit;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    image_index = 1;
    controller.tooltip = "Adds a new blind zone to the projection. Blind zones will prevent the laser from being projected in the area.";
} 
else image_index = 0;

