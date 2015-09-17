if (obj_cursor.x != clamp(obj_cursor.x,0,512)) && (obj_cursor.y != clamp(obj_cursor.y,0,512))
    exit;
    
for (i = 0;i < ds_list_size(el_list); i++)
    {
    templist = ds_list_find_value(el_list,i);
    xo = ds_list_find_value(templist,0)/$ffff*512;
    yo = ds_list_find_value(templist,1)/$ffff*512;
    rectxmin2 = xo + (ds_list_find_value(templist,4));
    rectymin2 = yo + (ds_list_find_value(templist,6));
    rectxmax2 = xo + (ds_list_find_value(templist,5));
    rectymax2 = yo + (ds_list_find_value(templist,7));
    
    if (obj_cursor.x == clamp(obj_cursor.x,rectxmin2-5,rectxmax2+5)) && (obj_cursor.y == clamp(obj_cursor.y,rectymin2-5,rectymax2+5))
        {
        if (ds_list_find_index(semaster_list,ds_list_find_value(templist,9)) == -1)
            {
            tooltip = "Click to select this object";
        
            if (mouse_check_button_pressed(mb_left))
                {
                ds_list_add(semaster_list,ds_list_find_value(templist,9));
                
                update_semasterlist_flag = 1;
                }
            }
        else
            {
            tooltip = "Click to deselect this object";
        
            if (mouse_check_button_pressed(mb_left))
                {
                ds_list_delete(semaster_list,ds_list_find_index(semaster_list,ds_list_find_value(templist,9)));
                
                update_semasterlist_flag = 1;
                }
            }
            
        return 0;
        }
    }
    
if (mouse_check_button_pressed(mb_left))
    deselect_object();
