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
        tooltip = "Click to select this object";
        
        if (mouse_check_button_pressed(mb_left))
            {
            selectedelementlist = templist;
            selectedelement = ds_list_find_value(selectedelementlist,9);
            rectxmin = rectxmin2;
            rectymin = rectymin2;
            rectxmax = rectxmax2;
            rectymax = rectymax2;
            }
            
        exit;
        }
    }
