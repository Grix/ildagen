if (instance_exists(obj_dropdown))
    exit;
_visible = !ds_list_empty(controller.blindzone_list);
if (!_visible) 
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    image_index = 1;
    controller.tooltip = "Clears all the blind zones";
} 
else 
    image_index = 0;

