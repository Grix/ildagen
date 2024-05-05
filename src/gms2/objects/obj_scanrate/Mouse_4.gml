if (!visible) 
    exit;
if (instance_exists(obj_dropdown))
    exit;

if (mouse_x > (x+23))
{
    controller.opt_scanspeed += 1000;
	if (controller.opt_scanspeed > 30000 && !suppress_warning)
	{
		show_message_new("NB: It is recommended to keep sampling rate at 30000 or below, as higher values can cause problems in certain devices like LaserCube Wifi");
		suppress_warning = true;
	}
}
else
    controller.opt_scanspeed -= 1000;
controller.opt_scanspeed = clamp(controller.opt_scanspeed,1000,50000);

    
save_profile();

