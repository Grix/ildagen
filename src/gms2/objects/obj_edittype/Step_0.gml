if (instance_exists(obj_dropdown))
    exit;
_visible = controller.anienable && !ds_list_empty(controller.semaster_list);
if (!_visible) exit;

if (controller.editing_type == 1) 
    image_index = 2;
else if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    image_index = 1;
else 
    image_index = 0;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    controller.tooltip = "Toggles drawing a custom path, rather than a straight line, for animating movement etc.\nRight click for options.";

