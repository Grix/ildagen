if (room != rm_options)
    exit;

//menu
if (mouse_y > camera_get_view_y(view_camera[3]))   
{
	var t_width =  max(1, camera_get_view_width(view_camera[3]));
	
    if (mouse_x > menu_width_start[0]) and (mouse_x < menu_width_start[1])
    {
        dropdown_menu_set_view();
    }
    else if (mouse_x > menu_width_start[1]) and (mouse_x < menu_width_start[2])
    {
        dropdown_menu_ilda_about();
    }
	
	else if (mouse_x < t_width-controller.tab_menu_width_start[0]) and (mouse_x > t_width-controller.tab_menu_width_start[1])
    {
        dd_ilda_vieweditor();
    }
    else if (mouse_x < t_width-controller.tab_menu_width_start[1]) and (mouse_x > t_width-controller.tab_menu_width_start[2])
    {
        dd_ilda_viewtimeline();
    }
    else if (mouse_x < t_width-controller.tab_menu_width_start[2]) and (mouse_x > t_width-controller.tab_menu_width_start[3])
	{
        dd_ilda_viewlive();
    }
    else if (mouse_x < t_width-controller.tab_menu_width_start[3]) and (mouse_x > t_width-controller.tab_menu_width_start[4])
    {
        dropdown_menu_ilda_settings();
    }
    exit;
}

