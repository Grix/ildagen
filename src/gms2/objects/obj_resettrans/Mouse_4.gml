if (instance_exists(obj_dropdown))
    exit;
	
if (!_visible)
	exit;
	
with (controller)
{
    for (c = 0; c < ds_list_size(semaster_list); c++)
    {
        selectedelement = ds_list_find_value(semaster_list,c);
        
        //find elements
        temp_undof_list = ds_list_create_pool();
        temp_frame_list = ds_list_create_pool();
        if (fillframes)
        {
            for (i = scope_start;i <= scope_end;i++)
            {
                el_list_temp = ds_list_find_value(frame_list,i);
                for (u = 0;u < ds_list_size(el_list_temp);u++)
                {
                    if (ds_list_find_value(ds_list_find_value(el_list_temp,u),9) == selectedelement)
                    {
                        if (ds_list_empty(temp_frame_list))
                            startframe = i;
                        ds_list_add(temp_frame_list,ds_list_find_value(el_list_temp,u));
                        temp_undo_list = ds_list_create_pool();
                        ds_list_copy(temp_undo_list,ds_list_find_value(el_list_temp,u));
                        ds_list_add(temp_undo_list,i);
                        ds_list_add(temp_undof_list,temp_undo_list);
                    }
                }
            }
        }
        else
        {
            el_list_temp = ds_list_find_value(frame_list,frame);
            for (u = 0; u < ds_list_size(el_list_temp); u++)
            {
                if (ds_list_find_value(ds_list_find_value(el_list_temp,u),9) == selectedelement)
                {
                    if (ds_list_empty(temp_frame_list))
                        startframe = frame;
                    ds_list_add(temp_frame_list,ds_list_find_value(el_list_temp,u))
                    temp_undo_list = ds_list_create_pool();
                    ds_list_copy(temp_undo_list,ds_list_find_value(el_list_temp,u));
                    ds_list_add(temp_undo_list,frame);
                    ds_list_add(temp_undof_list,temp_undo_list);
                }
            }
        }
        ds_list_add(undo_list,"k"+string(temp_undof_list));
        
        
        if (fillframes)
        {
            for (i = 0;i < ds_list_size(temp_frame_list);i++)
            {
                new_list = ds_list_find_value(temp_frame_list,i);
                
                if (i == 0)
                {
                    startposx_r = ds_list_find_value(new_list,0);
                    startposy_r = ds_list_find_value(new_list,1);
                    endx_r = ds_list_find_value(new_list,2);
                    endy_r = ds_list_find_value(new_list,3);
                }
                else if (reap_trans)
                {
                    ds_list_replace(new_list,0,startposx_r);
                    ds_list_replace(new_list,1,startposy_r);
                    ds_list_replace(new_list,2,endx_r);
                    ds_list_replace(new_list,3,endy_r);
                }
            }  
        }
        else
        {
            for (i = 0;i < ds_list_size(temp_frame_list);i++)
            {
                new_list = ds_list_find_value(temp_frame_list,i);
                
                //todo find first frame and use those's startpos
                if (i == 0)
                {
                    startposx_r = ds_list_find_value(new_list,0);
                    startposy_r = ds_list_find_value(new_list,1);
                    endx_r = ds_list_find_value(new_list,2);
                    endy_r = ds_list_find_value(new_list,3);
                }
                else if (reap_trans)
                {
                    ds_list_replace(new_list,0,startposx_r);
                    ds_list_replace(new_list,1,startposy_r);
                    ds_list_replace(new_list,2,endx_r);
                    ds_list_replace(new_list,3,endy_r);
                }
            }  
        }
            
        
        for (i = 0; i < ds_list_size(el_list);i++)
        {
            if (selectedelement = ds_list_find_value(ds_list_find_value(el_list,i),9))
            {
                sefound = 1;
                var t_list = ds_list_find_value(el_list,i);
                xo = ds_list_find_value(t_list,0);
                yo = ds_list_find_value(t_list,1);
                rectxmin = round(xo + (ds_list_find_value(t_list,4)));
                rectymin = round(yo + (ds_list_find_value(t_list,6)));
                rectxmax = round(xo + (ds_list_find_value(t_list,5)));
                rectymax = round(yo + (ds_list_find_value(t_list,7)));
            }
        }
    }
        
    frame_surf_refresh = 1;
    update_semasterlist_flag = 1;
	clean_redo_list();
    
}

