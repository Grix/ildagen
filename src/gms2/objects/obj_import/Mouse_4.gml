if (instance_exists(oDropDown))
    exit;

if (os_browser != browser_not_a_browser)
{
    show_message_new("Sorry, this feature is not available in the web version yet");
    exit;
}
    
with (controller)
{
    if (room == rm_ilda)
        import_ilda(get_open_filename_ext("ILDA files|*.ild","","","Select ILDA file"));
    else if (room == rm_seq)
    {
        if (!verify_serial())
            exit;
        import_ildaseq(get_open_filename_ext("ILDA files|*.ild","","","Select ILDA file"));
    }
}


