if (instance_exists(obj_dropdown))
    exit;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    //image_index = 1;
    controller.tooltip = "Base time on beats and BPM from music, instead of frame counts and minutes/seconds.";
} 
image_index = controller.use_bpm;

