if (instance_exists(obj_dropdown))
    exit;
	
visible = (controller.enable_artnet || controller.enable_sacn);
if (!visible) 
	exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
	image_index = 1;
} 
else 
    image_index = 0;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    controller.tooltip = "Sets the function for the color VALUE (brightness) channel.\nValue from 0 to 255.";

