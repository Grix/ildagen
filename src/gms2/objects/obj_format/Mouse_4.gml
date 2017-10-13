if (instance_exists(obj_dropdown))
    exit;
if (mouse_x < (x+32))
    controller.exp_format = 5;
else
    controller.exp_format = 0;

save_profile();

