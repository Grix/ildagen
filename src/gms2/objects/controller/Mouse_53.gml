if (room != rm_ilda) exit;
    
//menu
if (mouse_y < 0)
{
    if (mouse_x > menu_width_start[0]) and (mouse_x < menu_width_start[1])
    {
        dropdown_menu_ilda_file();
    }
    else if (mouse_x > menu_width_start[1]) and (mouse_x < menu_width_start[2])
    {
        dropdown_menu_ilda_properties();
    }
    else if (mouse_x > menu_width_start[2]) and (mouse_x < menu_width_start[3])
	{
        dropdown_menu_ilda_edit();
    }
    else if (mouse_x > menu_width_start[3]) and (mouse_x < menu_width_start[4])
    {
        dropdown_menu_ilda_tools();
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

if (instance_exists(obj_dropdown)) or (window_mouse_get_x() > view_wport[4]) or (window_mouse_get_y()-23 > view_wport[4]) or (keyboard_check(vk_control) or (placing == "select"))
    exit;

var t_scale = $ffff/view_wport[4];
var t_mouse_x = window_mouse_get_x();
var t_mouse_y = window_mouse_get_y()-23;

//todo maybe rewrite to avoid clamp
if !ds_list_empty(semaster_list)  and (
((t_mouse_x == clamp(t_mouse_x,rectxmin/t_scale-2,rectxmax/t_scale+2)) and (t_mouse_y == clamp(t_mouse_y,rectymin/t_scale-2,rectymax/t_scale+2)))
or ((t_mouse_x == clamp(t_mouse_x,anchorx/t_scale-10,anchorx/t_scale+10)) and (t_mouse_y == clamp(t_mouse_y,anchory/t_scale-10,anchory/t_scale+10)))
or ((t_mouse_x == clamp(t_mouse_x,rectxmin/t_scale-20,rectxmin/t_scale-2)) and (t_mouse_y == clamp(t_mouse_y,rectymax/t_scale+2,rectymax/t_scale+20)))
or ((t_mouse_x == clamp(t_mouse_x,rectxmax/t_scale+2,rectxmax/t_scale+20)) and (t_mouse_y == clamp(t_mouse_y,rectymax/t_scale+2,rectymax/t_scale+20)))
)
    exit;
    
ds_list_clear(semaster_list);

if ((keyboard_check(ord("E"))) and (placing_status != 2))
{
    ds_list_add(undo_list,"bb"+string(color2));
    ds_list_add(undo_list,"b"+string(color1));
    color1 = draw_getpixel(obj_cursor.x,obj_cursor.y+23);
    update_colors();
    exit;
}

if ((window_mouse_get_x() > view_wport[4]+3) or (window_mouse_get_y()-23 > view_wport[4]+3)) and (placing_status != 2)
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
    if (point_distance(window_mouse_get_x(), window_mouse_get_y()-23,ds_list_find_value(bez_list,2)/$ffff*view_wport[4],ds_list_find_value(bez_list,3)/$ffff*view_wport[4]) < 7)
        bez_moving = 1;
    else if (point_distance(window_mouse_get_x(), window_mouse_get_y()-23,ds_list_find_value(bez_list,4)/$ffff*view_wport[4],ds_list_find_value(bez_list,5)/$ffff*view_wport[4]) < 7)
        bez_moving = 2;
    if (point_distance(window_mouse_get_x(), window_mouse_get_y()-23,ds_list_find_value(bez_list,0)/$ffff*view_wport[4],ds_list_find_value(bez_list,1)/$ffff*view_wport[4]) < 7)
        bez_moving = 3;
    else if (point_distance(window_mouse_get_x(), window_mouse_get_y()-23,ds_list_find_value(bez_list,6)/$ffff*view_wport[4],ds_list_find_value(bez_list,7)/$ffff*view_wport[4]) < 7)
        bez_moving = 4;
    mouse_yprevious = t_mouse_y;
    mouse_xprevious = t_mouse_x;
}

