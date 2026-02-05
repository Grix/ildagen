if (instance_exists(obj_dropdown))
    exit;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    //image_index = 1;
    controller.tooltip = "Enable Art-Net input on the specified DMX universe and network interface chosen below.";
} 
image_index = controller.enable_artnet;

