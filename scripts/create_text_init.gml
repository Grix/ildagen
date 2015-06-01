//get and check data
if (ds_list_empty(font_list))
    {
    if (!import_font())
        return 0;
    }

ilda_dialog_string("text","Enter text","");