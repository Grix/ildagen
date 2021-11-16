if (instance_exists(obj_dropdown))
    exit;
if (!visible)
    exit;

if (mouse_x > (x+23))
    controller.projectfps += 5;
else
    controller.projectfps -= 5;
	
controller.projectfps = clamp(controller.projectfps, 5, 95);
seqcontrol.projectfps = controller.projectfps;

