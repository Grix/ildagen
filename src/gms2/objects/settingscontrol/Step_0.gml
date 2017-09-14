if (room != rm_options)
    exit;

if (keyboard_check_pressed(vk_tab))
    room_goto(rm_ilda);
    

if (keyboard_check_pressed(vk_escape))
{
    if (controller.laseron)
    {
        controller.laseron = false;
        frame_surf_refresh = true;
        dac_blank_and_center(controller.dac);
    }
}

