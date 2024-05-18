if (instance_exists(obj_dropdown))
    exit;
    
if (controller.placing == "select") 
	image_index = 2;
else if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    image_index = 1;
} 
else 
	image_index = 0;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
	controller.tooltip = "Selection tool. Click on objects to select or deselect them.\nKeyboard shortcut: Hold ["+get_ctrl_string()+"] while clicking on objects.";

