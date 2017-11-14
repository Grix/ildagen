if (room != rm_ilda) exit;
if (instance_exists(obj_dropdown))
    exit;

if ((mouse_x > view_wport[4]+30) or (mouse_y > view_wport[4]+30)) and (placing_status != 2) or (!ds_list_empty(semaster_list) and (
((mouse_x == clamp(mouse_x,rectxmin-2,rectxmax+2)) and (mouse_y == clamp(mouse_y,rectymin-2,rectymax+2)))
or ((mouse_x == clamp(mouse_x,anchorx/$ffff*view_wport[4]-10,anchorx/$ffff*view_wport[4]+10)) and (mouse_y == clamp(mouse_y,anchory/$ffff*view_wport[4]-10,anchory/$ffff*view_wport[4]+10)))
or ((mouse_x == clamp(mouse_x,rectxmin-20,rectxmin-2)) and (mouse_y == clamp(mouse_y,rectymax+2,rectymax+20)))
or ((mouse_x == clamp(mouse_x,rectxmax+2,rectxmax+20)) and (mouse_y == clamp(mouse_y,rectymax+2,rectymax+20)))
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
        point1x = startpos[0]+cos(-mousedir-pi/2)*100;
        if (point1x > view_wport[4]-10) or (point1x < 10)
            point1x = startpos[0]+cos(-mousedir+pi/2)*100;
        point1y = startpos[1]+sin(-mousedir-pi/2)*100;
        if (point1y > view_wport[4]-10) or (point1y < 10)
            point1y = startpos[1]+sin(-mousedir+pi/2)*100;
        point2x = endx+cos(-mousedir-pi/2)*100;
        if (point2x > view_wport[4]-10) or (point2x < 10)
            point2x = endx+cos(-mousedir+pi/2)*100;
        point2y = endy+sin(-mousedir-pi/2)*100;
        if (point2y > view_wport[4]-10) or (point2y < 10)
            point2y = endy+sin(-mousedir+pi/2)*100;
        ds_list_replace(bez_list,2,point1x/view_wport[4]*$ffff);
        ds_list_replace(bez_list,3,point1y/view_wport[4]*$ffff);
        ds_list_replace(bez_list,4,point2x/view_wport[4]*$ffff);
        ds_list_replace(bez_list,5,point2y/view_wport[4]*$ffff);
        bezier_coeffs(	ds_list_find_value(bez_list,0)/$ffff*view_wport[4],
						ds_list_find_value(bez_list,1)/$ffff*view_wport[4],
						ds_list_find_value(bez_list,2)/$ffff*view_wport[4],
						ds_list_find_value(bez_list,3)/$ffff*view_wport[4],
						ds_list_find_value(bez_list,4)/$ffff*view_wport[4],
						ds_list_find_value(bez_list,5)/$ffff*view_wport[4],
						ds_list_find_value(bez_list,6)/$ffff*view_wport[4],
						ds_list_find_value(bez_list,7)/$ffff*view_wport[4]);
    }
}
    
bez_moving = 0;

