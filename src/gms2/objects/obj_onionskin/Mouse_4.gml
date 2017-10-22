if (instance_exists(obj_dropdown))
    exit;
if (!_visible)
	exit;
	
with (controller)
{
    onion = !onion;
    frame_surf_refresh = 1;
}
    

