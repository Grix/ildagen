//get and check data
if (ds_list_empty(font_list))
    {
    if (!import_font())
        return 0;
    }

getstr = get_string_async("Enter text","");
dialog = "text";
