if (instance_exists(obj_dropdown))
    exit;
image_index = (obj_projectionzones.mode != 0) ? 0 : 1;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
	controller.tooltip = "Toggle between changing the projection window by dragging its sides, or its corners.";
} 

