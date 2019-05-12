if (room != rm_live) 
	exit;

alarm[2] = 1;
mouse_xprevious = mouse_x;

//menu
if (mouse_y < 0)   
{
    if (mouse_x > menu_width_start[0]) and (mouse_x < menu_width_start[1])
    {
        dropdown_menu_live_file();
    }
    else if (mouse_x > menu_width_start[1]) and (mouse_x < menu_width_start[2])
    {
        dropdown_menu_seq_properties();
    }
    else if (mouse_x > menu_width_start[2]) and (mouse_x < menu_width_start[3])
    {
        dropdown_menu_seq_edit();
    }
    else if (mouse_x > menu_width_start[3]) and (mouse_x < menu_width_start[4])
    {
        dropdown_menu_seq_tools();
    }
    else if (mouse_x > menu_width_start[4]) and (mouse_x < menu_width_start[5])
    {
        dropdown_menu_ilda_view();
    }
    else if (mouse_x > menu_width_start[5]) and (mouse_x < menu_width_start[6])
    {
        dropdown_menu_ilda_settings();
    }
    else if (mouse_x > menu_width_start[6]) and (mouse_x < menu_width_start[7])
    {
        dropdown_menu_ilda_about();
    }
    exit;
}

