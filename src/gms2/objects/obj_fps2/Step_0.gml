//visible = controller.exp_optimize;
if (!visible)
    exit;
if (instance_exists(obj_dropdown))
    exit;
    
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the number of frames per second (FPS) of the animation.\nHigher FPS means smoother animations with less flicker, but is harder for scanners to display without distortion.\nRight-click to input exact value.";
    
    if ((mouse_x - bbox_left) > 24)
        image_index = 1;
    else
        image_index = 2;
} 
else
    image_index = 0;

