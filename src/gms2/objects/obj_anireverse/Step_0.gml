if (instance_exists(obj_dropdown))
    exit;

_visible = controller.anienable;
if (!_visible)
    exit;
	
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Mirror the animation function (makes new animations be reversed)";
} 

