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
                }
            }
        }
    }
else
    {
    el_list = ds_list_find_value(frame_list,frame);
    
    list_id = selectedelementlist;
    copy_list = ds_list_create();
    ds_list_copy(temp_undo_list,list_id);
    ds_list_add(temp_undo_list,frame);
    ds_list_add(copy_list,temp_undo_list);
    }


placing_status = 0;
ds_list_clear(free_list);
ds_list_clear(bez_list);