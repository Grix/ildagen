//get and check data
if (ds_list_empty(font_list))
    {
    show_message_async("Please import a LaserBoy font file first");
    import_font();
    }
else
    ilda_dialog_string("text","Enter text","");
