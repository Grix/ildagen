if (room != rm_options)
    exit;

//menu
if (mouse_y > camera_get_view_y(view_camera[3]))   
{
    if (mouse_x > menu_width_start[0]) and (mouse_x < menu_width_start[1])
    {
        dropdown_menu_set_view();
    }
    else if (mouse_x > menu_width_start[1]) and (mouse_x < menu_width_start[2])
    {
        dropdown_menu_set_about();
    }
    exit;
}

