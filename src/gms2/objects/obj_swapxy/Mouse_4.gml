if (instance_exists(obj_dropdown))
    exit;

controller.swapxy = !controller.swapxy;

save_profile();