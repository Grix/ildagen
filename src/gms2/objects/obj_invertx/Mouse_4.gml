if (instance_exists(obj_dropdown))
    exit;

controller.invert_x = !controller.invert_x;

save_profile();

