if (instance_exists(obj_dropdown))
    exit;
_visible = (controller.maxframes > 1);
if (!_visible) 
	exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    image_index = 1;
    controller.tooltip = "Set the start and end point of the editing scope. The editing scope delimits new animations and other editing actions.";
}
else image_index = 0; 

