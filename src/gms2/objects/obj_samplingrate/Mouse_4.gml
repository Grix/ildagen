if (instance_exists(obj_dropdown))
    exit;
if (!visible) 
    exit;

if (mouse_x > (x+23))
    controller.opt_maxdist += 50;
else
    controller.opt_maxdist -= 50;
if (controller.opt_maxdist < 50)
    controller.opt_maxdist = 50;
    
save_profile();

