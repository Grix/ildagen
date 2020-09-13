if (instance_exists(obj_dropdown))
    exit;
if (!_visible) 
	exit;

if (controller.editing_type == 1)
	controller.editing_type = 0;
else
	controller.editing_type = 1;
