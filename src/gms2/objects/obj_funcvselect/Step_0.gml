if (instance_exists(obj_dropdown))
    exit;
visible = (controller.colormode == "func")
if (!visible) 
	exit;
if (controller.colormode2 == 0)
    instance_change(obj_funcbselect,1);

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
	image_index = 1;
} 
else 
    image_index = 0;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    controller.tooltip = "Sets the function for the color VALUE (brightness) channel.\nValue from 0 to 255.";

