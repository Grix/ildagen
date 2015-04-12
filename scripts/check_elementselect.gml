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
                
                xmax = -$ffff;
                xmin = $ffff;
                ymax = -$ffff;
                ymin = $ffff;
                for (u = 0; u < ds_list_size(el_list);u++)
                    {
                    templist = ds_list_find_value(el_list,u);
                    elid_temp = ds_list_find_value(templist,9);
                    
                    for (j = 0;j < ds_list_size(semaster_list);j++)
                        {
                        if (elid_temp = ds_list_find_value(semaster_list,j))
                            {
                            xo = ds_list_find_value(templist,0)/$ffff*512;
                            yo = ds_list_find_value(templist,1)/$ffff*512;
                            if (xmin > xo + (ds_list_find_value(templist,4)))
                                xmin = xo + (ds_list_find_value(templist,4));
                            if (ymin > yo + (ds_list_find_value(templist,6)))
                                ymin = yo + (ds_list_find_value(templist,6));
                            if (xmax < xo + (ds_list_find_value(templist,5)))
                                xmax = xo + (ds_list_find_value(templist,5));
                            if (ymax < yo + (ds_list_find_value(templist,7)))
                                ymax = yo + (ds_list_find_value(templist,7));
                            }
                        }
                    }
                rectxmax = xmax;
                rectxmin = xmin;
                rectymax = ymax;
                rectymin = ymin;
                }
            }
        else
            {
            tooltip = "Click to deselect this object";
        
            if (mouse_check_button_pressed(mb_left))
                {
                ds_list_delete(semaster_list,ds_list_find_index(semaster_list,ds_list_find_value(templist,9)));
                
                xmax = -$ffff;
                xmin = $ffff;
                ymax = -$ffff;
                ymin = $ffff;
                for (u = 0; u < ds_list_size(el_list);u++)
                    {
                    templist = ds_list_find_value(el_list,u);
                    elid_temp = ds_list_find_value(templist,9);
                    
                    for (j = 0;j < ds_list_size(semaster_list);j++)
                        {
                        if (elid_temp = ds_list_find_value(semaster_list,j))
                            {
                            xo = ds_list_find_value(templist,0)/$ffff*512;
                            yo = ds_list_find_value(templist,1)/$ffff*512;
                            if (xmin > xo + (ds_list_find_value(templist,4)))
                                xmin = xo + (ds_list_find_value(templist,4));
                            if (ymin > yo + (ds_list_find_value(templist,6)))
                                ymin = yo + (ds_list_find_value(templist,6));
                            if (xmax < xo + (ds_list_find_value(templist,5)))
                                xmax = xo + (ds_list_find_value(templist,5));
                            if (ymax < yo + (ds_list_find_value(templist,7)))
                                ymax = yo + (ds_list_find_value(templist,7));
                            }
                        }
                    }
                rectxmax = xmax;
                rectxmin = xmin;
                rectymax = ymax;
                rectymin = ymin;
                }
            }
            
        exit;
        }
    }
