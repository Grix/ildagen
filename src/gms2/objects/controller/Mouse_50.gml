if (room != rm_ilda) exit;
if (mouse_x > 512) or (mouse_y > 512)
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
        if (point_distance(startpos[0]+ds_list_find_value(free_list,ds_list_size(free_list)-2),startpos[1]+ds_list_find_value(free_list,ds_list_size(free_list)-1),mouse_x,mouse_y) >= resolution/128)
        {
            ds_list_add(free_list,mouse_x-startpos[0]);
            ds_list_add(free_list,mouse_y-startpos[1]);
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
        bezier_coeffs(ds_list_find_value(bez_list,0),ds_list_find_value(bez_list,1),ds_list_find_value(bez_list,2),ds_list_find_value(bez_list,3),ds_list_find_value(bez_list,4),ds_list_find_value(bez_list,5),ds_list_find_value(bez_list,6),ds_list_find_value(bez_list,7));
    }
    else if (placing_status == 2)
    {
        if (bez_moving == 1)
        {
            ds_list_replace(bez_list,2,ds_list_find_value(bez_list,2)+mouse_x-mouse_xprevious);
            ds_list_replace(bez_list,3,ds_list_find_value(bez_list,3)+mouse_y-mouse_yprevious);
            mouse_yprevious = mouse_y;
            mouse_xprevious = mouse_x;
        }
        else if (bez_moving == 2)
        {
            ds_list_replace(bez_list,4,ds_list_find_value(bez_list,4)+mouse_x-mouse_xprevious);
            ds_list_replace(bez_list,5,ds_list_find_value(bez_list,5)+mouse_y-mouse_yprevious);
            mouse_yprevious = mouse_y;
            mouse_xprevious = mouse_x;
        }
        else if (bez_moving == 3)
        {
            ds_list_replace(bez_list,0,ds_list_find_value(bez_list,0)+mouse_x-mouse_xprevious);
            ds_list_replace(bez_list,1,ds_list_find_value(bez_list,1)+mouse_y-mouse_yprevious);
            startpos[0] = ds_list_find_value(bez_list,0);
            startpos[1] = ds_list_find_value(bez_list,1);
            mouse_yprevious = mouse_y;
            mouse_xprevious = mouse_x;
        }
        else if (bez_moving == 4)
        {
            ds_list_replace(bez_list,6,ds_list_find_value(bez_list,6)+mouse_x-mouse_xprevious);
            ds_list_replace(bez_list,7,ds_list_find_value(bez_list,7)+mouse_y-mouse_yprevious);
            endx = ds_list_find_value(bez_list,6);
            endy = ds_list_find_value(bez_list,7);
            mouse_yprevious = mouse_y;
            mouse_xprevious = mouse_x;
        }
    }
}
    

