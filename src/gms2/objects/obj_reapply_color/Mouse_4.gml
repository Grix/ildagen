if (instance_exists(obj_dropdown))
    exit;
if (!_visible)
	exit;	
	
with (controller)
{
    reap_color = 1;
    reap_blank = 0;
    reapply_properties();
}
    

