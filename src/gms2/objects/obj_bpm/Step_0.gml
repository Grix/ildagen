visible = controller.use_bpm;

if (!visible)
    exit;
if (instance_exists(obj_dropdown))
    exit;
    
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the number of beats per minute (BPM) used in timing.\nIn the Timeline and Editor modes, BPM merely changes the timeline labels, not the actual playback speed.\nHowever, in the Grid mode, changing the BPM also changes the playback speed to match the new BPM.\nRight click to input exact value.";
    
    if ((mouse_x - bbox_left) > 24)
        image_index = 1;
    else
        image_index = 2;
} 
else
    image_index = 0;

