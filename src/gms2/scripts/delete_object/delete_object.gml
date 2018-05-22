if (ds_list_empty(controller.semaster_list)) exit;

temp_undof_list = ds_list_create();

for (c = 0; c < ds_list_size(semaster_list); c++)
{
    selectedelement = ds_list_find_value(semaster_list,c);

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
                    ds_list_add(temp_undof_list,temp_undo_list);
                    ds_list_destroy(list_id);
                    ds_list_delete(el_list,i);
                }
            }
        }
    }
    else
    {
        el_list = ds_list_find_value(frame_list,frame);
        
        for (i = 0;i < ds_list_size(el_list);i++)
        {
            if (ds_list_find_value(ds_list_find_value(el_list,i),9) == selectedelement)
            {
                list_id = ds_list_find_value(el_list,i);
                temp_undo_list = ds_list_create();
                ds_list_copy(temp_undo_list,list_id);
                ds_list_add(temp_undo_list,frame);
                ds_list_add(temp_undof_list,temp_undo_list);
                ds_list_destroy(list_id);
                ds_list_delete(el_list,i);
            }
        }
    }
    ds_list_add(undo_list,"l"+string(temp_undof_list));
}
    

frame_surf_refresh = 1;
ds_list_clear(semaster_list);
ilda_cancel();
