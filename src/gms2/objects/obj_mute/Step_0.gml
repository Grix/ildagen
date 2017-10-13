if (instance_exists(obj_dropdown))
    exit;
visible = (seqcontrol.song != -1);
if (!visible)
    exit;
    
if (seqcontrol.muted) 
    image_index = 2;
else if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    image_index = 1;
} 
else 
{
    image_index = 0;
}
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    controller.tooltip = "Toggle mute audio.";

