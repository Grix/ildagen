if (instance_exists(obj_dropdown))
    exit;
visible = !ds_list_empty(seqcontrol.marker_list);
if (!visible) 
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
    image_index = 1;
    controller.tooltip = "Clears all the markers from the timeline";
    } 
else 
    image_index = 0;

