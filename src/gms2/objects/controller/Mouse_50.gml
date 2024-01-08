if (room != rm_ilda) exit;
if (window_mouse_get_x() > view_wport[4]) || (mouse_y-camera_get_view_y(view_camera[4]) > view_wport[4])
    exit;
if (instance_exists(obj_dropdown))
    exit;
    
if (placing == "free")
{
    if (placing_status == 1)
    {
        autoresflag = 0;
        if (is_string(resolution)) 
        {
            autoresflag = 1; 
            resolution = 512;
        }
        if (point_distance(startpos[0]+ds_list_find_value(free_list,ds_list_size(free_list)-2),startpos[1]+ds_list_find_value(free_list,ds_list_size(free_list)-1),obj_cursor.x*$ffff/view_wport[4],obj_cursor.y*$ffff/view_wport[4]) >= resolution)
        {
            ds_list_add(free_list, obj_cursor.x*$ffff/view_wport[4]-startpos[0]);
            ds_list_add(free_list, obj_cursor.y*$ffff/view_wport[4]-startpos[1]);
        }
        if (autoresflag)
            resolution = "auto";
    }
}
else if (placing == "curve")
{
    if (placing_status == 1)
    {
        mousedir = degtorad(point_direction(startpos[0],startpos[1],endx,endy));
        ds_list_replace(bez_list,6,endx);
        ds_list_replace(bez_list,7,endy);
        bezier_coeffs(	ds_list_find_value(bez_list,0),
						ds_list_find_value(bez_list,1),
						ds_list_find_value(bez_list,2),
						ds_list_find_value(bez_list,3),
						ds_list_find_value(bez_list,4),
						ds_list_find_value(bez_list,5),
						ds_list_find_value(bez_list,6),
						ds_list_find_value(bez_list,7));
    }
    else if (placing_status == 2)
    {
        if (bez_moving == 1)
        {
			log("moving 2");
            ds_list_replace(bez_list,2,ds_list_find_value(bez_list,2)+(window_mouse_get_x()-mouse_xprevious)/view_wport[4]*$ffff);
            ds_list_replace(bez_list,3,ds_list_find_value(bez_list,3)+(window_mouse_get_y()-mouse_yprevious)/view_wport[4]*$ffff);
            mouse_yprevious = window_mouse_get_y();
            mouse_xprevious = window_mouse_get_x();
        }
        else if (bez_moving == 2)
        {
			log("moving 3");
            ds_list_replace(bez_list,4,ds_list_find_value(bez_list,4)+(window_mouse_get_x()-mouse_xprevious)/view_wport[4]*$ffff);
            ds_list_replace(bez_list,5,ds_list_find_value(bez_list,5)+(window_mouse_get_y()-mouse_yprevious)/view_wport[4]*$ffff);
            mouse_yprevious = window_mouse_get_y();
            mouse_xprevious = window_mouse_get_x();
        }
        else if (bez_moving == 3)
        {
			log("moving 1");
            ds_list_replace(bez_list,0,ds_list_find_value(bez_list,0)+(window_mouse_get_x()-mouse_xprevious)/view_wport[4]*$ffff);
            ds_list_replace(bez_list,1,ds_list_find_value(bez_list,1)+(window_mouse_get_y()-mouse_yprevious)/view_wport[4]*$ffff);
            startpos[0] = ds_list_find_value(bez_list,0);
            startpos[1] = ds_list_find_value(bez_list,1);
            mouse_yprevious = window_mouse_get_y();
            mouse_xprevious = window_mouse_get_x();
        }
        else if (bez_moving == 4)
        {
			log("moving 4");
            ds_list_replace(bez_list,6,ds_list_find_value(bez_list,6)+(window_mouse_get_x()-mouse_xprevious)/view_wport[4]*$ffff);
            ds_list_replace(bez_list,7,ds_list_find_value(bez_list,7)+(window_mouse_get_y()-mouse_yprevious)/view_wport[4]*$ffff);
            endx = ds_list_find_value(bez_list,6);
            endy = ds_list_find_value(bez_list,7);
            mouse_yprevious = window_mouse_get_y();
            mouse_xprevious = window_mouse_get_x();
        }
    }
}
    

