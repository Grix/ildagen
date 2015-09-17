with(controller)
    {
    if (read_ilda_init(argument0) == 0) exit;
    
    ildlistsize = ds_list_size(ild_list);
    framelistsize = ds_list_size(frame_list);
    
    if (room == rm_seq)
        {
        frames_toseq_importedilda();
        }
    else
        {
        if ( (ildlistsize) > maxframes)
            repeat (ildlistsize - maxframes)
                {
                maxframes++;
                templist = ds_list_create();
                if (fillframes)
                    {
                    tempelcount = ds_list_size(ds_list_find_value(frame_list,framelistsize-1));
                    for (u = 0;u < tempelcount;u++)
                        {
                        tempellist = ds_list_create();
                        ds_list_copy(tempellist,ds_list_find_value(ds_list_find_value(frame_list,framelistsize-1),u));
                        ds_list_add(templist,tempellist);
                        }
                    }
                ds_list_add(frame_list,templist);
                }
                
        if (!fillframes) or (ildlistsize > framelistsize)
            {
            for (i = 0;i < ildlistsize;i++)
                {
                if (!ds_list_empty(ds_list_find_value(ild_list,i)))
                    {
                    templist = ds_list_create();
                    ds_list_copy(templist,ds_list_find_value(ild_list,i));
                    ds_list_add(ds_list_find_value(frame_list,i),templist);
                    }
                ds_list_destroy(ds_list_find_value(ild_list,i));
                }
            }
        else
            {
            for (i = 0;i < ds_list_size(frame_list);i++)
                {
                if (!ds_list_empty(ds_list_find_value(ild_list,i%ildlistsize)))
                    {
                    templist = ds_list_create();
                    ds_list_copy(templist,ds_list_find_value(ild_list,i%ildlistsize));
                    ds_list_add(ds_list_find_value(frame_list,i),templist);
                    }
                /*if (ildlistsize > framelistsize)
                    {
                    ds_list_destroy(ds_list_find_value(ild_list,i%ildlistsize));
                    }*/
                }
            for (i = 0;i < ds_list_size(ild_list);i++)
                {
                ds_list_destroy(ds_list_find_value(ild_list,i));
                }
            }
        ds_list_add(undo_list,el_id);
        el_id++;
        frame_surf_refresh = 1;
        refresh_miniaudio_flag = 1;
        }
    ds_list_destroy(ild_list);
    
    scope_end = maxframes-1;
    refresh_miniaudio_flag = 1;
    
    }
return 1;
