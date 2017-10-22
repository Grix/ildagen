if (instance_exists(obj_dropdown))
    exit;
	
_visible = !ds_list_empty(controller.semaster_list);
	
if (!_visible)
	exit;
	
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    image_index = 1;
    controller.tooltip = "Edit/Reapply the object's coloring\nRight click for settings\n(Keyboard shortcut, for both color and blanking: Enter)";
} 
else image_index = 0;

