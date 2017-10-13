if (instance_exists(obj_dropdown))
    exit;
controller.exp_optimize = !controller.exp_optimize;

if (!controller.exp_optimize)
    controller.opt_onlyblanking = false;

if (!controller.opt_warning_flag) and (!controller.exp_optimize)
{
    controller.opt_warning_flag = 1;
    show_message_new("NB: Unoptimized output can damage the scanners of your laser projector. Only use for imported ILDA files that are already optimized, or if you intent to use a third party program to optimize later.");
}
    
save_profile();

