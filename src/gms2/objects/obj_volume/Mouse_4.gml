if (instance_exists(obj_dropdown))
    exit;
if (visible)
{
	seqcontrol.volume = (mouse_x-bbox_left)/1.28;
    moving = 1;
}
