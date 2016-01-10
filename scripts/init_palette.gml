if (os_browser != browser_not_a_browser)
    {
    pal_list = ds_list_create();
    ini_open("palette.ini");
    var t_string;
    for (j = 0; j <= 191; j++)
        {
        t_string = ini_read_string("pal",string(j),"");
        ds_list_add(pal_list,real(t_string));
        }
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
    
/*ini_open(get_save_filename("",""));
for (j = 0; j < ds_list_size(pal_list); j++)
    {
    ini_write_real("pal",string(j),ds_list_find_value(pal_list,j));
    }
ini_close();*/

log("palette loaded, size: "+string(ds_list_size(pal_list)));
