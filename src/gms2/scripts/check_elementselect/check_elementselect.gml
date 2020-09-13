function check_elementselect() {
	//if (obj_cursor.x != clamp(obj_cursor.x,0,512)) && (obj_cursor.y != clamp(obj_cursor.y,0,512))
	//    exit;

	if (laseron)
		exit;
    
	var t_ellistsize = ds_list_size(el_list);
	var t_order_grid = ds_grid_create(2, t_ellistsize);
	var t_templist;

	for (i = 0;i < t_ellistsize; i++)
	{
	    t_templist = ds_list_find_value(el_list,i);
	    rectxmin2 = (ds_list_find_value(t_templist, 4));
	    rectymin2 = (ds_list_find_value(t_templist, 6));
	    rectxmax2 = (ds_list_find_value(t_templist, 5));
	    rectymax2 = (ds_list_find_value(t_templist, 7));
    
	    ds_grid_add(t_order_grid, 0, i, point_distance(rectxmin2,rectymin2,rectxmax2,rectymax2));
	    ds_grid_add(t_order_grid, 1, i, t_templist);
	}
    
	ds_grid_sort(t_order_grid,0,true);
    
	for (i = 0;i < t_ellistsize; i++)
	{
	    t_templist = ds_grid_get(t_order_grid, 1, i);
	    xo = ds_list_find_value(t_templist, 0) / $ffff*view_wport[4];
	    yo = ds_list_find_value(t_templist, 1) / $ffff*view_wport[4];
	    rectxmin2 = xo + (ds_list_find_value(t_templist, 4)/$ffff*view_wport[4]);
	    rectymin2 = yo + (ds_list_find_value(t_templist, 6)/$ffff*view_wport[4]);
	    rectxmax2 = xo + (ds_list_find_value(t_templist, 5)/$ffff*view_wport[4]);
	    rectymax2 = yo + (ds_list_find_value(t_templist, 7)/$ffff*view_wport[4]);
    
	    if	(obj_cursor.x == clamp(obj_cursor.x,rectxmin2-5,rectxmax2+5)) && 
			(obj_cursor.y == clamp(obj_cursor.y,rectymin2-5,rectymax2+5))
	    {
	        if (ds_list_find_index(semaster_list,ds_list_find_value(t_templist,9)) == -1)
	        {
	            tooltip = "Click to select this object";
	            object_select_hovering = 1;
        
	            if (mouse_check_button_pressed(mb_left) || mouse_check_button_pressed(mb_right)) 
	            {
					canrightclick = 0;
	                ds_list_add(semaster_list,ds_list_find_value(t_templist,9));
	                update_semasterlist_flag = 1;
	                if (placing == "select")
	                    placing = placing_select_last;
	            }
	        }
	        else
	        {
	            tooltip = "Click to deselect this object";
	            object_select_hovering = 2;
        
	            if (mouse_check_button_pressed(mb_left) || mouse_check_button_pressed(mb_right)) 
	            {
					canrightclick = 0;
	                ds_list_delete(semaster_list,ds_list_find_index(semaster_list,ds_list_find_value(t_templist,9)));
	                update_semasterlist_flag = 1;
	                if (placing == "select")
	                    placing = placing_select_last;
	            }
	        }
            
	        return 0;
	    }
	}
    
	if (mouse_check_button_pressed(mb_left) and (placing != "select"))
	{
	    deselect_object();
	}




}
