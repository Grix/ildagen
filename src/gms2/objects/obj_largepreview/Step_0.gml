//_visible = (controller.dpi_multiplier == 1);

if (instance_exists(obj_dropdown) || !_visible)
    exit;
	
if (seqcontrol.largepreview) 
    image_index = 2;
else if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    image_index = 1;
else 
    image_index = 0;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    controller.tooltip = "Toggles larger previewing window.";

