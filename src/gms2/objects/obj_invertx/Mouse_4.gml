if (instance_exists(oDropDown))
    exit;

controller.invert_x = !controller.invert_x;

save_profile();

