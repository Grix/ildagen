if (instance_exists(obj_dropdown))
    exit;
if (!visible) 
    exit;

if (mouse_x > (x+23))
    controller.opt_maxdist += 25;
else
    controller.opt_maxdist -= 25;
if (controller.opt_maxdist < 25)
    controller.opt_maxdist = 25;
    
save_profile();

