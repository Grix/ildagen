if (room != rm_options)
    exit;

//menu
if (mouse_y > __view_get( e__VW.YView, 3 ))   
{
    if (mouse_x > menu_width_start[0]) and (mouse_x < menu_width_start[1])
    {
        dropdown_menu_set_properties();
    }
    else if (mouse_x > menu_width_start[1]) and (mouse_x < menu_width_start[2])
    {
        dropdown_menu_set_view();
    }
    else if (mouse_x > menu_width_start[2]) and (mouse_x < menu_width_start[3])
    {
        dropdown_menu_set_about();
    }
    exit;
}

