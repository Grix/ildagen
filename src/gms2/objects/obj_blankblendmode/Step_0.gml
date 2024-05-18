if (instance_exists(obj_dropdown))
    exit;
	
_visible = !ds_list_empty(controller.semaster_list);
	
if (!_visible)
	exit;
    
image_index = controller.blank_blendmode;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the stroke blending mode when reapplying stroke properties to an object.";
    image_index += 4;
}


