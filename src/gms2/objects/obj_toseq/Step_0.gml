if (instance_exists(obj_dropdown))
    exit;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    image_index = 1;
	if (room == rm_ilda || room == rm_seq)
		controller.tooltip = "Sends the frames from the editor mode to the selected\nposition in the timeline mode (Shortcut: I)";
	else
		controller.tooltip = "Sends the selected file to the selected position in the timeline mode (Shortcut: I)."
} 
else image_index = 0;

if (room == rm_ilda || room == rm_seq)
	visible = true;
else if (room == rm_live)
	visible = livecontrol.selectedfile != -1;