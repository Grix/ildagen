if (instance_exists(obj_dropdown))
    exit;
if (!visible)
    exit;

if (mouse_x > (x+23))
    controller.bpm += 1;
else
    controller.bpm -= 1;
	
controller.bpm = clamp(controller.bpm, 5, 1000);

