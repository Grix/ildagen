if (room != rm_ilda) exit;
if (instance_exists(obj_dropdown))
    exit;
	
var t_mouse_x = window_mouse_get_x();
var t_mouse_y = window_mouse_get_y()-23;

if ((t_mouse_x > view_wport[4]+30) or (t_mouse_y > view_wport[4]+30)) and (placing_status != 2) or (!ds_list_empty(semaster_list) and (
((t_mouse_x == clamp(t_mouse_x,rectxmin-2,rectxmax+2)) and (t_mouse_y == clamp(t_mouse_y,rectymin-2,rectymax+2)))
or ((t_mouse_x == clamp(t_mouse_x,anchorx/$ffff*view_wport[4]-10,anchorx/$ffff*view_wport[4]+10)) and (t_mouse_y == clamp(t_mouse_y,anchory/$ffff*view_wport[4]-10,anchory/$ffff*view_wport[4]+10)))
or ((t_mouse_x == clamp(t_mouse_x,rectxmin-20,rectxmin-2)) and (t_mouse_y == clamp(t_mouse_y,rectymax+2,rectymax+20)))
or ((t_mouse_x == clamp(t_mouse_x,rectxmax+2,rectxmax+20)) and (t_mouse_y == clamp(t_mouse_y,rectymax+2,rectymax+20)))
))
{
    placing_status = 0;
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
    exit;
}

if (placing_status == 1) and (placing != "text") and (placing != "select")
{
    if (placing != "curve")
        create_element();
    else
    {
        placing_status = 2;
        point1x = startpos[0]+cos(-mousedir-pi/2)*5000;
        if (point1x/$ffff*view_wport[4] > view_wport[4]-10) or (point1x < 500)
            point1x = startpos[0]+cos(-mousedir+pi/2)*5000;
        point1y = startpos[1]+sin(-mousedir-pi/2)*5000;
        if (point1y/$ffff*view_wport[4] > view_wport[4]-10) or (point1y < 500)
            point1y = startpos[1]+sin(-mousedir+pi/2)*5000;
        point2x = endx+cos(-mousedir-pi/2)*5000;
        if (point2x/$ffff*view_wport[4] > view_wport[4]-10) or (point2x < 500)
            point2x = endx+cos(-mousedir+pi/2)*5000;
        point2y = endy+sin(-mousedir-pi/2)*5000;
        if (point2y/$ffff*view_wport[4] > view_wport[4]-10) or (point2y < 500)
            point2y = endy+sin(-mousedir+pi/2)*5000;
        ds_list_replace(bez_list,2,point1x);
        ds_list_replace(bez_list,3,point1y);
        ds_list_replace(bez_list,4,point2x);
        ds_list_replace(bez_list,5,point2y);
        bezier_coeffs(	ds_list_find_value(bez_list,0),
						ds_list_find_value(bez_list,1),
						ds_list_find_value(bez_list,2),
						ds_list_find_value(bez_list,3),
						ds_list_find_value(bez_list,4),
						ds_list_find_value(bez_list,5),
						ds_list_find_value(bez_list,6),
						ds_list_find_value(bez_list,7));
    }
}
    
bez_moving = 0;

