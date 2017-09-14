if (instance_exists(oDropDown))
    exit;
if (!visible) 
    exit;

if (mouse_x > (x+23))
    controller.opt_maxdwell_blank += 1;
else
    controller.opt_maxdwell_blank -= 1;
if (controller.opt_maxdwell_blank < 0)
    controller.opt_maxdwell_blank = 0;
    
save_profile();

