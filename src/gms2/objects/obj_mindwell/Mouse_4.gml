if (instance_exists(obj_dropdown))
    exit;
if (!visible) 
    exit;

if (mouse_x > (x+23))
    controller.opt_mindwell += 1;
else
    controller.opt_mindwell -= 1;
if (controller.opt_mindwell < 0)
    controller.opt_mindwell = 0;
    
save_profile();

