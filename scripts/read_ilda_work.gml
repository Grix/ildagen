//works its way through an ilda file

while (1)
    {
    action = read_ilda_header();
    if (action == 1)
        {
        if ( (frame+ds_list_size(controller.frame_list_parse)) < controller.maxframes)
            repeat (controller.maxframes - (frame+ds_list_size(controller.frame_list_parse)))
                {
                templist = ds_list_create();
                if (controller.fillframes)
                    ds_list_copy(templist,ds_list_find_value(controller.frame_list,ds_list_size(controller.frame_list)-1))
                ds_list_add(controller.frame_list,templist);
                }
        for (i = 0;i < maxframes_parse;i++)
            {
            ds_list_add(ds_list_find_value(frame_list,frame+i),ds_list_find_value(frame_list_parse,i));
            }
        buffer_delete(ild_file);
        refresh_surfaces();
        exit;
        }
    read_ilda_frame();
    }
