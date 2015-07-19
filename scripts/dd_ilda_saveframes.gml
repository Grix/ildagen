if (controller.maxframes == 1) && !ds_list_size(controller.el_list)
    exit;

ilda_cancel();

if (!verify_serial())
    exit;

with (controller) 
    {
    if (os_browser == browser_not_a_browser)
        save_frames();
    else 
        ilda_dialog_string("saveframes","Enter the name of the LasershowGen frames IGF file","example.igf");
    }
