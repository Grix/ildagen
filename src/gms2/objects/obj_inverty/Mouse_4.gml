if (instance_exists(obj_dropdown))
    exit;

controller.invert_y = !controller.invert_y;

save_profile();

