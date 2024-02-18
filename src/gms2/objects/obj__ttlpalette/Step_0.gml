if (instance_exists(obj_dropdown))
    exit;
	
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    //image_index = 1;
    controller.tooltip = "Switch to an alternative 7-color palette for ILDA format 0 files.\nTry this if colors appear wrong on your SD card reader projector.";
} 
image_index = controller.ttlpalette;

