if (os_browser != browser_not_a_browser)
    exit;

placing_status = 0;
ds_list_clear(free_list);
ds_list_clear(bez_list);
import_ilda(get_open_filename_ext("ILDA files|*.ild","","","Select ILDA file"));