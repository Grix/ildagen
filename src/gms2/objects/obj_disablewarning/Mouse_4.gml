if (instance_exists(obj_dropdown))
    exit;

controller.warning_disable = !controller.warning_disable;

save_profile();

