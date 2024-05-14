if (instance_exists(obj_dropdown))
    exit;

visible = (seqcontrol.song != -1);
if (!visible)
	exit;

	
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Shifts the audio relative to the timeline during playback. Used to compensate for latency of the audio compared to the laser.\nRight click to enter value manually.";
    
    if ((mouse_x - bbox_left) > 24)
        image_index = 1;
    else
        image_index = 2;
} 
else
    image_index = 0;

