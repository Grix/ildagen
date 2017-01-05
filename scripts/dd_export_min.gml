controller.exp_optimize = 0;

if (!controller.opt_warning_flag) and (!controller.exp_optimize)
{
    controller.opt_warning_flag = 1;
    show_message_async("NB: Unoptimized files are meant only for simulation or to be optimized in third party programs. Attempting to play an unoptimized file directly on a projector can damage the scanners.");
}
    
save_profile();
