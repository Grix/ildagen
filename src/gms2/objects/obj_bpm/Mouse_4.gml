if (instance_exists(obj_dropdown))
    exit;
if (!visible)
    exit;
	
var previous_bpm = controller.bpm;

if (mouse_x > (x+23))
    controller.bpm += 1;
else
    controller.bpm -= 1;
	
controller.bpm = clamp(controller.bpm, 5, 1000);

if (previous_bpm == livecontrol.bpm_adjusted)
	livecontrol.bpm_adjusted = controller.bpm;