if (instance_exists(obj_dropdown))
    exit;
if (!visible)
    exit;

if (mouse_x > (x+23))
    controller.beats_per_bar += 1;
else
    controller.beats_per_bar -= 1;
	
controller.beats_per_bar = clamp(controller.beats_per_bar, 1, 16);

