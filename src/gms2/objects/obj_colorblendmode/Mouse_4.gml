if (instance_exists(obj_dropdown))
    exit;

if (!_visible)
	exit;
	
controller.color_blendmode++;
if (controller.color_blendmode >= 3)
    controller.color_blendmode = 0;

