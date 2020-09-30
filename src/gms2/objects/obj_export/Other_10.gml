with (controller)
{
    placing_status = 0;
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
}

with (controller) 
{
    if (os_browser == browser_not_a_browser)
        export_ilda();
    else 
        ilda_dialog_string("exporthtml5","Enter the name of the ILDA file","example"+string(current_hour) + "" + string(current_minute)+".ild");
}

