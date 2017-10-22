if (instance_exists(obj_dropdown))
    exit;
	
_visible = !ds_list_empty(controller.semaster_list);

if (!_visible)
	exit;
    
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    image_index = 1;
else 
    image_index = 0;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    controller.tooltip = "Resets displacement animation, makes the object stand still";

