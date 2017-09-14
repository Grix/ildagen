if (instance_exists(oDropDown))
    exit;
    
if (!controller.exp_optimize)
    exit;

controller.opt_onlyblanking = !controller.opt_onlyblanking;

save_profile();

