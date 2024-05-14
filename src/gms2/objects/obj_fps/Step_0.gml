if (instance_exists(obj_dropdown))
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    image_index = 1;
    controller.tooltip = "Changes the number of frames per second (FPS) of the laser output. A lower number leads to a more accurate image, but increases flicker. Default: 50";
}
else image_index = 0; 

