if (instance_exists(obj_dropdown))
    exit;
if (!visible)
    exit;

if (controller.use_bpm)
{
	if (mouse_x > (x+23))
	    livecontrol.bpm_adjusted += 2;
	else
	    livecontrol.bpm_adjusted -= 2;
		
	livecontrol.bpm_adjusted = clamp(livecontrol.bpm_adjusted, 6, 1000);
}
else
{
	if (mouse_x > (x+23))
	    livecontrol.speed_adjusted += 0.05;
	else
	    livecontrol.speed_adjusted -= 0.05;
		
	livecontrol.speed_adjusted = clamp(livecontrol.speed_adjusted, 0.05, 20);
}
	