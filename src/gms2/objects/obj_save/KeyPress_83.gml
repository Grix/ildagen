if (!keyboard_check(vk_control))
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

with (controller) 
    {
    if (os_browser == browser_not_a_browser)
        save_frames();
    else 
        ilda_dialog_string("saveframes","Enter the name of the LaserShowGen frames IGF file","example.igf");
    }

