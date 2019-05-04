if (instance_exists(obj_dropdown))
    exit;
	
if (room == rm_seq)
	_visible = (ds_list_size(seqcontrol.somaster_list) == 1)
else if (room == rm_live)
	_visible = (livecontrol.playingfile != -1)
	
if (!_visible) 
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    image_index = 1;
    controller.tooltip = "Open selected object in the editor mode for editing.";
} 
else 
    image_index = 0;

