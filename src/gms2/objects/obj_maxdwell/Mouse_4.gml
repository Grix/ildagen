if (instance_exists(obj_dropdown))
    exit;
if (!visible) 
    exit;

if (mouse_x > (x+23))
    controller.opt_maxdwell += 1;
else
    controller.opt_maxdwell -= 1;
if (controller.opt_maxdwell < 0)
    controller.opt_maxdwell = 0;
    
save_profile();

