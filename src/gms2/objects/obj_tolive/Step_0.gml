if (instance_exists(obj_dropdown))
    exit;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    image_index = 1;
	controller.tooltip = "Sends the frames from the editor mode to a new tile in the grid view, or replaces the selected tile. (Shortcut: L)";
} 
else image_index = 0;

