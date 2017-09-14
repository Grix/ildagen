if (instance_exists(oDropDown))
    exit;

controller.invert_y = !controller.invert_y;

save_profile();

