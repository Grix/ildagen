if (instance_exists(obj_dropdown))
    exit;
visible = obj_anicolorselect_1.visible;
if (!visible)
    exit;
    
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
	image_index = 1;
    controller.tooltip = "Clones the main colors over to the animation end colors";
} 
else image_index = 0;


