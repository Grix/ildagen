if (!visible) 
    exit;
if (instance_exists(oDropDown))
    exit;

if (mouse_x > (x+23))
    controller.opt_scanspeed += 1000;
else
    controller.opt_scanspeed -= 1000;
controller.opt_scanspeed = clamp(controller.opt_scanspeed,1000,100000);

    
save_profile();

