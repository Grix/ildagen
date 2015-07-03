if (controller.maxframes == 1) && !ds_list_size(controller.el_list)
    exit;

with (controller)
    {
    placing_status = 0;
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
    }

if (!verify_serial())
    exit;

with (controller) 
    {
    if (os_browser == browser_not_a_browser)
        export_ilda();
    else 
        ilda_dialog_string("exporthtml5","Enter the name of the ILDA file","example.ild");
    }