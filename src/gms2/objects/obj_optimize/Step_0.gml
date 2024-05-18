if (instance_exists(obj_dropdown))
    exit;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    //image_index = 1;
    controller.tooltip = "Toggle between optimized and raw output. Raw output should only be used if the file has already been optimized elsewhere, otherwise the output will likely look greatly distorted.";
} 

