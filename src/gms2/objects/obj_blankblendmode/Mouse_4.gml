if (instance_exists(obj_dropdown))
    exit;

if (!_visible)
	exit;
	
controller.blank_blendmode++;
if (controller.blank_blendmode >= 4)
    controller.blank_blendmode = 0;

