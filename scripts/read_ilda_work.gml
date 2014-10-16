//works its way through an ilda file

while (1)
    {
    action = read_ilda_header();
    if (action == 1)
        {
        
        if ( (ds_list_size(ild_list)) > maxframes)
            repeat (ds_list_size(ild_list) - maxframes)
                {
                maxframes++;
                templist = ds_list_create();
                if (fillframes)
                    ds_list_copy(templist,ds_list_find_value(frame_list,ds_list_size(frame_list)-1))
                ds_list_add(frame_list,templist);
                }
                
        if (!fillframes)    
            {
            for (i = 0;i < ds_list_size(ild_list);i++)
                {
                if (!ds_list_empty(ds_list_find_value(ild_list,i)))
                    ds_list_add(ds_list_find_value(frame_list,i),ds_list_find_value(ild_list,i));
                }
            }
        else
            {
            for (i = 0;i < ds_list_size(frame_list);i++)
                {
                if (!ds_list_empty(ds_list_find_value(ild_list,i%ds_list_size(ild_list))))
                    ds_list_add(ds_list_find_value(frame_list,i),ds_list_find_value(ild_list,i%ds_list_size(ild_list)));
                show_message(i%ds_list_size(ild_list))
                }
            }
            
        buffer_delete(ild_file);
        refresh_surfaces();
        exit;
        
        }
    read_ilda_frame();
    }
