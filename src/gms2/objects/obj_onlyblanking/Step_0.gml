if (instance_exists(obj_dropdown))
    exit;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    //image_index = 1;
    controller.tooltip = "Only optimize the blanked segments between objects (and keep object points intact).";
} 
image_index = controller.opt_onlyblanking;

if (!controller.opt_warning_flag) and (controller.opt_onlyblanking)
{
    controller.opt_warning_flag = 1;
    show_message_new("NB: Unoptimized output can damage the scanners of your laser projector. Only use for imported ILDA files that are already optimized, or if you intent to use a third party program to optimize later.");
}

