if (room != rm_ilda) exit;
    
//menu
if (mouse_y < 0)
{
	var t_width =  max(1, camera_get_view_width(view_camera[3]));
	
    if (mouse_x > menu_width_start[0]) and (mouse_x < menu_width_start[1])
    {
        dropdown_menu_ilda_file();
    }
    else if (mouse_x > menu_width_start[1]) and (mouse_x < menu_width_start[2])
    {
        dropdown_menu_ilda_edit();
    }
    else if (mouse_x > menu_width_start[2]) and (mouse_x < menu_width_start[3])
	{
        dropdown_menu_ilda_tools();
    }
    else if (mouse_x > menu_width_start[3]) and (mouse_x < menu_width_start[4])
    {
        dropdown_menu_ilda_view();
    }
    else if (mouse_x > menu_width_start[4]) and (mouse_x < menu_width_start[5])
    {
        dropdown_menu_ilda_about();
    }
	else if (mouse_x < t_width-tab_menu_width_start[0]) and (mouse_x > t_width-tab_menu_width_start[1])
    {
        dd_ilda_vieweditor();
    }
    else if (mouse_x < t_width-tab_menu_width_start[1]) and (mouse_x > t_width-tab_menu_width_start[2])
    {
        dd_ilda_viewtimeline();
    }
    else if (mouse_x < t_width-tab_menu_width_start[2]) and (mouse_x > t_width-tab_menu_width_start[3])
	{
        dd_ilda_viewlive();
    }
    else if (mouse_x < t_width-tab_menu_width_start[3]) and (mouse_x > t_width-tab_menu_width_start[4])
    {
        dropdown_menu_ilda_settings();
    }
    exit;
}

if (instance_exists(obj_dropdown)) or (window_mouse_get_x() > view_wport[4]) or (mouse_y-camera_get_view_y(view_camera[4]) > view_wport[4]) or (keyboard_check_control() or (placing == "select"))
    exit;

if (!ds_list_empty(semaster_list) && handle_trans())
    exit;
    
ds_list_clear(semaster_list);

if ((keyboard_check(ord("E"))) and (placing_status != 2))
{
	add_action_history_ilda("ILDA_samplecolor");
	
	var t_tempundolist = ds_list_create_pool();
    ds_list_add(t_tempundolist,controller.enddotscolor);
    ds_list_add(t_tempundolist,controller.color2);
    ds_list_add(t_tempundolist,controller.color1);
    ds_list_add(controller.undo_list,"b"+string(t_tempundolist));
	
    color1 = draw_getpixel(obj_cursor.x,obj_cursor.y+23);
    update_colors();
    exit;
}

if ((window_mouse_get_x() > view_wport[4]+3) or (window_mouse_get_y()-view_hport[3] > view_wport[4]+3)) and (placing_status != 2)
{
    placing_status = 0;
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
    exit;
}
    
    
if (placing_status == 0)
{
    placing_status = 1;
    startpos[0] = obj_cursor.x/view_wport[4]*$ffff;
    startpos[1] = obj_cursor.y/view_wport[4]*$ffff;
    if (placing == "text")
        create_text_init();
    else if (placing == "free")
    {
        ds_list_add(free_list,0);
        ds_list_add(free_list,0);
    }
    else if (placing == "curve")
    {
        bezier_coeffs(0,0,0,0,0,0,0,0);
        ds_list_add(bez_list,startpos[0]);
        ds_list_add(bez_list,startpos[1]);
        ds_list_add(bez_list,startpos[1]);
        ds_list_add(bez_list,startpos[1]);
        ds_list_add(bez_list,startpos[1]);
        ds_list_add(bez_list,startpos[1]);
        ds_list_add(bez_list,startpos[1]);
        ds_list_add(bez_list,startpos[1]);
    }
}
    
else if (placing_status == 2) and (placing == "curve")
{
    if (point_distance(mouse_x, mouse_y-camera_get_view_y(view_camera[4]),ds_list_find_value(bez_list,2)/$ffff*view_wport[4],ds_list_find_value(bez_list,3)/$ffff*view_wport[4]) < 7*dpi_multiplier)
        bez_moving = 1;
    else if (point_distance(mouse_x, mouse_y-camera_get_view_y(view_camera[4]),ds_list_find_value(bez_list,4)/$ffff*view_wport[4],ds_list_find_value(bez_list,5)/$ffff*view_wport[4]) < 7*dpi_multiplier)
        bez_moving = 2;
    if (point_distance(mouse_x, mouse_y-camera_get_view_y(view_camera[4]),ds_list_find_value(bez_list,0)/$ffff*view_wport[4],ds_list_find_value(bez_list,1)/$ffff*view_wport[4]) < 7*dpi_multiplier)
        bez_moving = 3;
    else if (point_distance(mouse_x, mouse_y-camera_get_view_y(view_camera[4]),ds_list_find_value(bez_list,6)/$ffff*view_wport[4],ds_list_find_value(bez_list,7)/$ffff*view_wport[4]) < 7*dpi_multiplier)
        bez_moving = 4;
    mouse_yprevious = window_mouse_get_y();
    mouse_xprevious = window_mouse_get_x();
}

