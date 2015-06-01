if (!file_exists("palette.txt"))
    {
    show_message_async("Color palette file missing. Try reinstalling the program.");
    exit;
    }

palfile = file_text_open_read("palette.txt");
pal_list = ds_list_create();

while (!file_text_eof(palfile))
    ds_list_add(pal_list,real(string_digits(file_text_readln(palfile))));
    