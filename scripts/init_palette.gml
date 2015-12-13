if (os_browser != browser_not_a_browser)
    {
    pal_list = ds_list_create();
    ini_open("palette.ini");
    ds_list_read(pal_list,ini_read_string("palette","palette",""));
    ini_close();
    exit;
    }
    
if (!file_exists("palette.txt"))
    {
    show_message_async("Color palette file missing. Try reinstalling the program.");
    exit;
    }

palfile = file_text_open_read("palette.txt");
pal_list = ds_list_create();

while (!file_text_eof(palfile))
    ds_list_add(pal_list,real(string_digits(file_text_readln(palfile))));

/*log("----------");  
for (j = 0; j < ds_list_size(pal_list); j++)
    {
    log(ds_list_find_value(pal_list,j));
    }
log("----------");*/
log("palette loaded, size: "+string(ds_list_size(pal_list)));
