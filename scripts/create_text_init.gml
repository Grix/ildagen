//get and check data
if (font_type = -1)
    {
    if (!import_font())
        return 0;
    }

getstr = get_string_async("Enter text","");
dialog = "text";
