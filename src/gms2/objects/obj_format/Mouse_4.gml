if (instance_exists(oDropDown))
    exit;
if (mouse_x < (x+32))
    controller.exp_format = 5;
else
    controller.exp_format = 0;

save_profile();

