for (i = 0;i < ds_list_size(el_list);i++)
    {
    list_id = ds_list_find_value(el_list,i);
    
    xo = ds_list_find_value(list_id,0);
    yo = ds_list_find_value(list_id,1);
    
    currentpos = 16;
    
    for (u = 0; u < listsize; u++)
        {
        currentpos += 4;
        
        if (ds_list_find_value(list_id,currentpos+2))
            continue;
        
        xp = xo+ds_list_find_value(list_id,currentpos+0);
        yp = $ffff-(yo+ds_list_find_value(list_id,currentpos+1));
        }
    }
