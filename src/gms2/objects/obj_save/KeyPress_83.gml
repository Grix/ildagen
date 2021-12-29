if (!keyboard_check_control())
    exit;

if (controller.maxframes == 1) and !ds_list_size(controller.el_list)
    exit;
    
with (controller)
{
    placing_status = 0;
    playing = 0;
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
}

save_frames_quick();

