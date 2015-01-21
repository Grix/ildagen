with(controller)
    {
    if (read_ilda_init(argument0) == 0) exit;

    if ( (ds_list_size(ild_list)) > maxframes)
        repeat (ds_list_size(ild_list) - maxframes)
            {
            maxframes++;
            templist = ds_list_create();
            if (controller.fillframes)
                {
                tempelcount = ds_list_size(ds_list_find_value(controller.frame_list,ds_list_size(controller.frame_list)-1));
                for (u = 0;u < tempelcount;u++)
                    {
                    tempellist = ds_list_create();
                    ds_list_copy(tempellist,ds_list_find_value(ds_list_find_value(controller.frame_list,ds_list_size(controller.frame_list)-1),u));
                    ds_list_add(templist,tempellist);
                    }
                }
            ds_list_add(frame_list,templist);
            }
            
    if (!fillframes)    
        {
        for (i = 0;i < ds_list_size(ild_list);i++)
            {
            if (!ds_list_empty(ds_list_find_value(ild_list,i)))
                {
                templist = ds_list_create();
                ds_list_copy(templist,ds_list_find_value(ild_list,i));
                ds_list_add(ds_list_find_value(frame_list,i),templist);
                }
            }
        }
    else
        {
        for (i = 0;i < ds_list_size(frame_list);i++)
            {
            if (!ds_list_empty(ds_list_find_value(ild_list,i%ds_list_size(ild_list))))
                {
                templist = ds_list_create();
                ds_list_copy(templist,ds_list_find_value(ild_list,i%ds_list_size(ild_list)));
                ds_list_add(ds_list_find_value(frame_list,i),templist);
                }
                //ds_list_add(ds_list_find_value(frame_list,i),ds_list_find_value(ild_list,i%ds_list_size(ild_list)));
            }
        }
                
    buffer_delete(ild_file);
    for (i = 0;i < ds_list_size(ild_list);i++)
        ds_list_destroy(ds_list_find_value(ild_list,i));
    ds_list_destroy(ild_list);
    frame_surf_refresh = 1;
        
    ds_stack_push(undo_list,el_id);
    el_id++;
    }
return 1;