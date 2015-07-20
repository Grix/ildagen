if (os_browser != browser_not_a_browser)
    {
    show_message_async("Sorry, this feature is not available in the web version yet");
    exit;
    }
    
with (controller)
    {
    ilda_cancel();
    import_ilda(get_open_filename_ext("ILDA files|*.ild","","","Select ILDA file"));
    }