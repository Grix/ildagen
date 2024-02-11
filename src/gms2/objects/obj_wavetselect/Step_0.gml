if (instance_exists(obj_dropdown))
    exit;
visible = (controller.placing == "wave");
if (!visible)
	exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes wave frequency (Shortcut: "+get_ctrl_string()+" + Mouse wheel)";
    
    if ((mouse_x - bbox_left) > 24)
        image_index = 1;
    else
        image_index = 2;
} 
else
    image_index = 0;

