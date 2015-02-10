if (copy_list != -1)
    ds_list_destroy(copy_list);
    
copy_list = ds_list_create();
if (fillframes)
    {
    for (j = scope_start;j <= scope_end;j++)
        {
        el_list = ds_list_find_value(frame_list,j);
        for (i = 0;i < ds_list_size(el_list);i++)
            {
            if (ds_list_find_value(ds_list_find_value(el_list,i),9) == selectedelement)
                {
                list_id = ds_list_find_value(el_list,i);
                temp_undo_list = ds_list_create();
                ds_list_copy(temp_undo_list,list_id);
                ds_list_add(temp_undo_list,j);
                ds_list_add(copy_list,temp_undo_list);
                ds_list_destroy(list_id);
                ds_list_delete(el_list,i);
                }
            }
        }
    }
else
    {
    el_list = ds_list_find_value(frame_list,frame);
    
    list_id = selectedelementlist;
    temp_undo_list = ds_list_create();
    ds_list_copy(temp_undo_list,list_id);
    ds_list_add(temp_undo_list,frame);
    ds_list_add(copy_list,temp_undo_list);
    ds_list_delete(el_list,ds_list_find_index(el_list,list_id));
    ds_list_destroy(list_id);
    }
    
frame_surf_refresh = 1;

placing_status = 0;
selectedelement = -1;
ds_list_clear(free_list);
ds_list_clear(bez_list);