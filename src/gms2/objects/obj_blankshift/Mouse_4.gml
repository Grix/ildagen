if (instance_exists(obj_dropdown))
    exit;
if (!visible)
    exit;

if (keyboard_check_control())
{
    if (mouse_x > (x+23))
    {
        controller.opt_blankshift += 1;
        controller.opt_greenshift += 1;
        controller.opt_blueshift += 1;
        controller.opt_redshift += 1;
    }
    else
    {
        controller.opt_blankshift -= 1;
        controller.opt_greenshift -= 1;
        controller.opt_blueshift -= 1;
        controller.opt_redshift -= 1;
    }
}
else
{
    if (mouse_x > (x+23))
        controller.opt_blankshift += 1;
    else
        controller.opt_blankshift -= 1;
}
    
save_profile();

